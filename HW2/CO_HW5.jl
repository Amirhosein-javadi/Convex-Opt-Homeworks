using MLDatasets
using LinearAlgebra
using Printf
# data reading
train_x, train_y = MNIST.traindata();
test_x,  test_y  = MNIST.testdata();
# Creating Input
train_x_array = zeros((60000,28*28));
test_x_array = zeros((10000,28*28));
for i = 1:60000
    train_x_array[i,:] = vec(convert(Array{Float64}, train_x[:,:,i]));
end
for i = 1:10000
    test_x_array[i,:] = vec(convert(Array{Float64}, test_x[:,:,i]));
end
# Creating Output
train_y_onehot = zeros((60000,10));
test_y_onehot  = zeros((10000,10));
for i = 1:10
    train_y_onehot[:,i] = train_y .== (i-1);
end
for i = 1:10
    test_y_onehot[:,i]  = test_y  .== (i-1);
end
train_y_onehot = 2 .* train_y_onehot .- 1;   # 1-->1 and 0-->-1
test_y_onehot  = 2 .* test_y_onehot  .- 1;   # 1-->1 and 0-->-1
# Creating Random Features for Train Sets
extra_features = 1540;
R = rand([-1,1],(extra_features,28*28));
train_x_new_features = train_x_array * R';
train_State = train_x_new_features .> 0;
train_x_new_features = train_x_new_features .* train_State;
# Concating New Features with Old Ones
train_x_final_features = [train_x_array train_x_new_features];
# Creating Model
Model = train_x_final_features \ train_y_onehot;
# Creating Random Features for Test Sets
test_x_new_features = test_x_array * R';
test_State = test_x_new_features .> 0
test_x_new_features = test_x_new_features .* test_State;
# Concating New Features with Old Ones
test_x_final_features = [test_x_array test_x_new_features];
# Model Evaluation on Test set
test_y_model = test_x_final_features * Model;
score, index = findmax(test_y_model,dims=2);
test_y_hat = zeros(10000)
for i = 1 : 10000
    test_y_hat[i] = index[i][2]-1
end
test_error = ((test_y_hat - test_y) .!= 0);
@printf("Error rate on test data is %.2f percent \n", sum(test_error)/10000 * 100)

table = zeros((10,10))
for i = 1:10000
    table[Int(test_y[i]+1), Int(test_y_hat[i]+1)] += 1;
end
for i = 1:10
    sentence = "Error rate for number " * string(i-1) * " is " * string(1 - table[i,i]/sum(table[i,:]))
    println(sentence)
end
for i = 1:10
    for j = 1:10
        sentence = string(table[i,j]) * "\t"
        print(sentence)
    end
    println()
end


