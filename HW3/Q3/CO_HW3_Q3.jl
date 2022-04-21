using Gadfly
#srand(1524)
# number of products
n=5
# nominal prices
p_nom = [1.6
         1.7
         1.5
         0.7
         1.85];
# nominal demand
d_nom = [0.623
         0.811
         0.302
         0.336
         0.110];
# costs
c = [0.9
     1.50
     1.05
     0.1
     0.75];
# A matrix for the true model, which is not the same as yours.
# Your E_hat will not necessarily look like this one.
E =[-1.1   0.18 -0.4  -0.2   0.1
     0.18 -0.9   0.1  -0.3  -0.4
    -0.4   0.1  -0.7  -0.2  -0.3
    -0.2  -0.3  -0.2  -1.0   0.05
     0.1  -0.4  -0.3   0.05  -1.3];
# returns the true demand for a given price
function demand(p_new)
    exp.(E*(log.(p_new) .- log.(p_nom)) .+ log.(d_nom) .+ randn(n)*0.20);
end
# plots a histogram of a list of profits
function plot_profit_hist(profits)
    plot(x=profits, Geom.histogram(bincount=20));
end
# Create the data 
N=10000;
Prices = zeros(n,N);
Demands = zeros(n,N);
for i=1:N
    Prices[:,i] = p_nom.*exp.(0.2*(rand(n).-0.5))
    p_new = Prices[:,i]
    Demands[:,i] = demand(Prices[:,i])
end

Train_size = 8000;
Test_size = N - Train_size;

Delta_P_Train = Prices[:,1:Train_size] .- p_nom;
Delta_D_Train = Demands[:,1:Train_size] .- d_nom;

Delta_P_Test = Prices[:,Train_size+1:N] .- p_nom;
Delta_D_Test = Demands[:,Train_size+1:N] .- d_nom;


E_hat = Delta_P_Train' \ Delta_D_Train';
E_hat

Delta_D_hat_Train = (Delta_P_Train' * E_hat)';
Error = sum((Delta_D_hat_Train - Delta_D_Train).^2)/Train_size;
println("Error Rate on Train Data is " * string(round(Error; digits = 5)))

Delta_D_hat_Test = (Delta_P_Test' * E_hat)';
Error = sum((Delta_D_hat_Test - Delta_D_Test).^2)/Test_size;
println("Error Rate on Test Data is " * string(round(Error; digits = 5)))
