using CSV
using DataFrames
using LinearAlgebra
using Plots
df = CSV.read("asset_prices.csv", DataFrame);
prices=Matrix(df);
asset_names=names(df);
p_changes = prices[2:end,:] - prices[1:end-1,:];
R = p_changes./prices[1:end-1,:];
T,n = size(R)
p_tar = 0.2/250;

Model = zeros((n+2,n+2));
y = zeros((n+2,1));
miu = transpose(R) * ones((T,1)) / T;
Model[1:n,1:n] = 2* transpose(R) * R;
Model[n+1,1:n] .= 1;
Model[n+2,1:n] = transpose(miu);
Model[1:n,n+1] .= 1;
Model[1:n,n+2] = miu;
y[1:n] = 2 * p_tar * T * miu;
y[n+1] = 1;
y[n+2] = p_tar;

Initial_Ans = (Model \ y);
W0 = Initial_Ans[1:n];
r0 = R*W0;
downsiderisk_Arr = zeros(T)
for i = 1 : T
    downsiderisk_Arr[i] = maximum([p_tar-r0[i],0])
end
W0_downsiderisk = sum(downsiderisk_Arr)/T

function f(w)
    r = R*w;
    y = zeros((T,1));
    for i =1:T
        y[i] = maximum([p_tar-r[i],0])/T;
    end
    return y
end

function Df(w)
    y = f(w);
    alpha = y.>0;
    dw = zeros((T,T))
    for i = 1 : T
       dw[i,i]= alpha[i]; 
    end
    y = - dw * R
end

Kmax = 300;
lambda = 1e-4;
loss_value = zeros(Kmax);
W = W0
for i =1:Kmax
    D = Df(W)
    F = f(W)
    W = W .- (transpose(D) * D + lambda * I) \ (transpose(D)* F)
    loss_value[i] = sum(F)
end

plot(1:Kmax, loss_value,
    xlabel = "Iteration",
    ylabel = "loss",
    title = "Downside risk vs Iterations",
    legend = false,
    grid = true)
savefig("Downside_risk.png")

println("Final Result:")
println("Initial downside risk is " * string(W0_downsiderisk))
println("Downside risk of portfolio optimization after " * string(Kmax) * " iteration is " * string(loss_value[Kmax]))
