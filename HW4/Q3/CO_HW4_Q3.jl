using Random, Distributions
using LinearAlgebra
using Plots
N = 200
x = rand(Uniform(-1,1), (200,2))
y = x[:,1] .* x[:,2];
theta = rand(Uniform(-1,1), (13,1))
New_theta = theta
Kmax = 150;
lambda = 1e-5;

function Sigmoid(x)
   return (exp.(x) .- exp.(-x)) ./ (exp.(x) .+ exp.(-x))
end
function D_Sigmoid(x)
   return 4 ./ ((exp.(x) .+ exp.(-x)).^2)
end
function RMS_loss(x,y,theta)
   return (norm(f(theta, x).-y)^2)/N 
end
function f(theta, x)
    return theta[1].*Sigmoid(theta[2].*x[:,1].+theta[3].*x[:,2].+theta[4]) .+
           theta[5].*Sigmoid(theta[6].*x[:,1].+theta[7].*x[:,2].+theta[8]) .+
           theta[9].*Sigmoid(theta[10].*x[:,1].+theta[11].*x[:,2].+theta[12]) .+ theta[13]
end
function derivative_matrix(theta, x)
    Dr = zeros((200,13))
    Dr[:,1] = Sigmoid(theta[2].*x[:,1].+theta[3].*x[:,2].+theta[4])
    Dr[:,2] = theta[1].*x[:,1].*D_Sigmoid(theta[2].*x[:,1].+theta[3].*x[:,2].+theta[4])
    Dr[:,3] = theta[1].*x[:,2].*D_Sigmoid(theta[2].*x[:,1].+theta[3].*x[:,2].+theta[4])
    Dr[:,4] = theta[1].*D_Sigmoid(theta[2].*x[:,1].+theta[3].*x[:,2].+theta[4])
    Dr[:,5] = Sigmoid(theta[6].*x[:,1].+theta[7].*x[:,2].+theta[8])
    Dr[:,6] = theta[5].*x[:,1].*D_Sigmoid(theta[6].*x[:,1].+theta[7].*x[:,2].+theta[8])
    Dr[:,7] = theta[5].*x[:,2].*D_Sigmoid(theta[6].*x[:,1].+theta[7].*x[:,2].+theta[8])
    Dr[:,8] = theta[5].*D_Sigmoid(theta[6].*x[:,1].+theta[7].*x[:,2].+theta[8])
    Dr[:,9] = Sigmoid(theta[10].*x[:,1].+theta[11].*x[:,2].+theta[12])
    Dr[:,10] = theta[10].*x[:,1].*D_Sigmoid(theta[10].*x[:,1].+theta[11].*x[:,2].+theta[12])
    Dr[:,11] = theta[10].*x[:,2].*D_Sigmoid(theta[10].*x[:,1].+theta[11].*x[:,2].+theta[12])
    Dr[:,12] = theta[10].*D_Sigmoid(theta[10].*x[:,1].+theta[11].*x[:,2].+theta[12])
    Dr[:,13] .= 1
    return Dr
end

f_value = zeros(Kmax);
gradient_norm = zeros(Kmax);
New_theta = theta
for i =1:Kmax
    D = derivative_matrix(theta, x)
    New_theta = (transpose(D) * D + lambda * I) \ (transpose(D)*(D*theta.+y.-f(theta, x)))
    if RMS_loss(x,y,New_theta) < RMS_loss(x,y,theta)
        theta = New_theta
        lambda *= 0.8
    else
        lambda *= 2
    end
    f_value[i] = (RMS_loss(x,y,theta)^0.5)*N
    gradient_norm[i] = norm(derivative_matrix(theta, x))
end

gr();
plot(1:Kmax, f_value,
    xlabel = "Iteration",
    ylabel = "loss",
    title = "LM Loss vs Iterations",
    legend = false,
    grid = true)
savefig("LM_Loss.png")

plot(1:Kmax, gradient_norm,
    xlabel = "Iteration",
    ylabel = "Norm of Gradient",
    title = "Norm of Gradient vs Iterations",
    legend = false,
    grid = true)
savefig("Norm_of_Gradient.png")

data = hcat(x, ones(200,1)) 
Model = data \ y
Linear_Model_RMS = norm(data*Model-y)/(N^0.5)
println("The RMS fitting error of linear model is ", string(Linear_Model_RMS))
Neural_Network_RMS = norm(f(theta, x).-y)/(N^0.5)
println("The RMS fitting error of neural network is ", string(Neural_Network_RMS))

Model


