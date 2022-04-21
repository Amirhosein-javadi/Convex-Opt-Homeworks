using MLDatasets
train_x, train_y = MNIST.traindata();
test_x,  test_y  = MNIST.testdata();
train_x_array = zeros((60000,28*28));
test_x_array = zeros((10000,28*28));

for i = 1:60000
    train_x_array[i,:] = vec(convert(Array{Float64}, train_x[:,:,i]));
end
for i = 1:10000
    test_x_array[i,:] = vec(convert(Array{Float64}, test_x[:,:,i]));
end

k = 3;

Class_1 = [0, 1, 2, 3];
Class_2 = [4, 5, 6];
Class_3 = [7, 8, 9];

Class_1_Train_Index = findall(x-> (x<=3), train_y);
Class_2_Train_Index = findall(x-> (x>=4) && (x<=6), train_y);
Class_3_Train_Index = findall(x-> (x>=7), train_y);

Class_1_Test_Index = findall(x-> (x<=3), test_y);
Class_2_Test_Index = findall(x-> (x>=4) && (x<=6), test_y);
Class_3_Test_Index = findall(x-> (x>=7), test_y);

Class_1_Train_x = train_x_array[Class_1_Train_Index,:];
Class_2_Train_x = train_x_array[Class_2_Train_Index,:];
Class_3_Train_x = train_x_array[Class_3_Train_Index,:];

Class_1_Train_y = train_y[Class_1_Train_Index];
Class_2_Train_y = train_y[Class_2_Train_Index];
Class_3_Train_y = train_y[Class_3_Train_Index];

Model_1_data = [Class_1_Train_x ; Class_2_Train_x];
Model_2_data = [Class_1_Train_x ; Class_3_Train_x];
Model_3_data = [Class_2_Train_x ; Class_3_Train_x];

Model_1_label = [ones(size(Class_1_Train_y)) ; -1 * ones(size(Class_2_Train_y))];
Model_2_label = [ones(size(Class_1_Train_y)) ; -1 * ones(size(Class_3_Train_y))];
Model_3_label = [ones(size(Class_2_Train_y)) ; -1 * ones(size(Class_3_Train_y))];

Model_1 = Model_1_data \ Model_1_label;
Model_2 = Model_2_data \ Model_2_label;
Model_3 = Model_3_data \ Model_3_label;

Train_Model_Votes = zeros(60000,Int(k*(k-1)/2));
vote1 = sign.(train_x_array * Model_1);  # 1 -- > 1   -1 --> 2   y = (3-x)/2
vote1 = Int.((3 .- vote1) ./ 2);
vote2 = sign.(train_x_array * Model_2);  # 1 -- > 1   -1 --> 3   y = 2-x
vote2 = Int.(2 .- vote2);
vote3 = sign.(train_x_array * Model_3);  # 1 -- > 2   -1 --> 3   y = (5-x)/2
vote3 = Int.((5 .- vote3) ./ 2);
for i = 1:60000
    Train_Model_Votes[i,vote1[i]] += 1;
    Train_Model_Votes[i,vote2[i]] += 1;
    Train_Model_Votes[i,vote3[i]] += 1;
end
Train_y_hat = getindex.(findmax(Train_Model_Votes, dims=2 )[2], 2);
Train_y = zeros((60000,1));
Train_y[Class_1_Train_Index,1] .= 1;
Train_y[Class_2_Train_Index,1] .= 2;
Train_y[Class_3_Train_Index,1] .= 3;
Train_Error_Rate = 1 - sum(Train_y_hat .== Train_y) / 60000;
println("Error Rate on Train Data is " * string(round(Train_Error_Rate; digits = 5)))

Test_Model_Votes = zeros(10000,Int(k*(k-1)/2));
vote1 = sign.(test_x_array * Model_1);  # 1 -- > 1   -1 --> 2   y = (3-x)/2
vote1 = Int.((3 .- vote1) ./ 2);
vote2 = sign.(test_x_array * Model_2);  # 1 -- > 1   -1 --> 3   y = 2-x
vote2 = Int.(2 .- vote2);
vote3 = sign.(test_x_array * Model_3);  # 1 -- > 2   -1 --> 3   y = (5-x)/2
vote3 = Int.((5 .- vote3) ./ 2);
for i = 1:10000
    Test_Model_Votes[i,vote1[i]] += 1;
    Test_Model_Votes[i,vote2[i]] += 1;
    Test_Model_Votes[i,vote3[i]] += 1;
end
Test_y_hat = getindex.(findmax(Test_Model_Votes, dims=2 )[2], 2);
Test_y = zeros((10000,1));
Test_y[Class_1_Test_Index,1] .= 1;
Test_y[Class_2_Test_Index,1] .= 2;
Test_y[Class_3_Test_Index,1] .= 3;
Test_Error_Rate = 1 - sum(Test_y_hat .== Test_y) / 10000;
println("Error Rate on Test Data is " * string(round(Test_Error_Rate; digits = 5)))

function confusion_matrix(y_hat, y_true)
    C = zeros(3,3)
    for i in 1:3
        for j in 1:3
            C[i,j] = 1.0 * sum((y_hat .== i) .* (y_true .== j))
        end
    end
    return C
end

Train_Confusion_Matrix = confusion_matrix(Train_y_hat, Train_y);
println("Train Confusion Matrix :")
println(Train_Confusion_Matrix[1,:])
println(Train_Confusion_Matrix[2,:])
println(Train_Confusion_Matrix[3,:])

Test_Confusion_Matrix = confusion_matrix(Test_y_hat, Test_y)
println("Test Confusion Matrix :")
println(Test_Confusion_Matrix[1,:])
println(Test_Confusion_Matrix[2,:])
println(Test_Confusion_Matrix[3,:])
