"""
File: iris_flower_data.jl
Authors: Reese Pathak, Stephen Boyd
====================================
Iris dataset, taken from 
http://archive.ics.uci.edu/ml/datasets/Iris


"""
features = ["sepal length (cm)";  
            "sepal width (cm)";
            "petal length (cm)";
            "petal width (cm)"] 

labels = ["setosa"; "versicolor"; "virginica"]

X = [4.9 4.8 6.0 6.4 5.1 6.7 4.3 6.8 6.3 6.7 4.9 4.4 4.6 7.9 5.8 7.0 7.7 5.6 5.7 5.9 5.0 5.7 6.4 5.8 5.1 6.7 6.0 6.4 6.3 4.8 5.5 4.7 5.5 5.0 6.3 6.4 6.3 4.9 6.5 5.7 6.6 6.0 6.0 5.5 6.7 5.6 6.7 6.1 5.1 7.7 7.2 5.5 5.2 6.5 5.8 7.2 5.4 6.3 7.6 6.4 6.7 6.5 5.6 5.7 4.7 5.0 5.4 5.0 6.3 5.5 6.1 6.2 6.1 5.3 6.3 6.2 5.6 5.0 5.8 5.8 6.2 5.4 6.5 5.9 4.9 4.6 7.2 6.9 6.4 5.5 6.0 6.3 4.9 4.8 6.7 5.1 7.3 5.1 6.9 4.9 6.1 7.7 6.1 5.9 4.6 5.2 6.9 5.8 6.3 6.1 5.4 4.8 7.7 6.7 4.5 5.4 5.0 5.1 5.6 4.6 5.7 5.0 5.7 6.8 6.4 5.0 5.7 5.6 5.0 4.8 5.2 7.1 6.5 4.4 6.2 6.8 7.4 5.1 5.1 5.5 4.4 6.0 6.6 5.1 5.8 5.4 6.9 5.0 5.7 5.2; 
    3.1 3.4 2.7 3.2 3.8 3.1 3.0 3.2 2.8 3.1 3.6 3.2 3.6 3.8 2.6 3.2 2.6 3.0 2.8 3.2 3.2 3.8 2.8 2.7 3.7 3.0 3.0 2.8 2.5 3.0 2.6 3.2 4.2 3.5 2.9 2.9 2.5 2.5 2.8 2.6 2.9 2.2 2.2 2.3 2.5 2.7 3.0 2.6 2.5 2.8 3.6 2.5 2.7 3.0 2.7 3.0 3.4 2.7 3.0 3.1 3.3 3.2 2.9 2.5 3.2 3.3 3.0 3.0 3.4 3.5 2.9 2.8 3.0 3.7 3.3 2.2 2.5 3.4 2.7 4.0 2.9 3.7 3.0 3.0 3.0 3.2 3.2 3.1 3.2 2.4 2.9 2.3 3.1 3.0 3.1 3.8 2.9 3.4 3.1 2.4 2.8 3.0 3.0 3.0 3.4 3.5 3.2 2.8 3.3 2.8 3.9 3.1 3.8 3.3 2.3 3.9 3.6 3.5 3.0 3.1 2.9 3.4 4.4 2.8 2.7 2.0 2.8 2.8 2.3 3.4 4.1 3.0 3.0 3.0 3.4 3.0 2.8 3.3 3.5 2.4 2.9 3.4 3.0 3.8 2.7 3.4 3.1 3.5 3.0 3.4; 
    1.5 1.6 5.1 4.5 1.9 4.7 1.1 5.9 5.1 5.6 1.4 1.3 1.0 6.4 4.0 4.7 6.9 4.5 4.1 4.8 1.2 1.7 5.6 4.1 1.5 5.2 4.8 5.6 5.0 1.4 4.4 1.3 1.4 1.3 5.6 4.3 4.9 4.5 4.6 3.5 4.6 4.0 5.0 4.0 5.8 4.2 5.0 5.6 3.0 6.7 6.1 4.0 3.9 5.2 5.1 5.8 1.5 4.9 6.6 5.5 5.7 5.1 3.6 5.0 1.6 1.4 4.5 1.6 5.6 1.3 4.7 4.8 4.9 1.5 4.7 4.5 3.9 1.5 3.9 1.2 4.3 1.5 5.8 5.1 1.4 1.4 6.0 5.4 5.3 3.8 4.5 4.4 1.5 1.4 4.4 1.6 6.3 1.5 5.1 3.3 4.7 6.1 4.6 4.2 1.4 1.5 5.7 5.1 6.0 4.0 1.3 1.6 6.7 5.7 1.3 1.7 1.4 1.4 4.1 1.5 4.2 1.6 1.5 4.8 5.3 3.5 4.5 4.9 3.3 1.9 1.5 5.9 5.5 1.3 5.4 5.5 6.1 1.7 1.4 3.7 1.4 4.5 4.4 1.5 5.1 1.7 4.9 1.6 4.2 1.4; 
    0.1 0.2 1.6 1.5 0.4 1.5 0.1 2.3 1.5 2.4 0.1 0.2 0.2 2.0 1.2 1.4 2.3 1.5 1.3 1.8 0.2 0.3 2.1 1.0 0.4 2.3 1.8 2.2 1.9 0.3 1.2 0.2 0.2 0.3 1.8 1.3 1.5 1.7 1.5 1.0 1.3 1.0 1.5 1.3 1.8 1.3 1.7 1.4 1.1 2.0 2.5 1.3 1.4 2.0 1.9 1.6 0.4 1.8 2.1 1.8 2.5 2.0 1.3 2.0 0.2 0.2 1.5 0.2 2.4 0.2 1.4 1.8 1.8 0.2 1.6 1.5 1.1 0.2 1.2 0.2 1.3 0.2 2.2 1.8 0.2 0.2 1.8 2.1 2.3 1.1 1.5 1.3 0.2 0.1 1.4 0.2 1.8 0.2 2.3 1.0 1.2 2.3 1.4 1.5 0.3 0.2 2.3 2.4 2.5 1.3 0.4 0.2 2.2 2.1 0.3 0.4 0.2 0.3 1.3 0.2 1.3 0.4 0.4 1.4 1.9 1.0 1.3 2.0 1.0 0.2 0.1 2.1 1.8 0.2 2.3 2.1 1.9 0.5 0.2 1.0 0.2 1.6 1.4 0.3 1.9 0.2 1.5 0.6 1.2 0.2];

y  =[1.0,1.0,2.0,2.0,1.0,2.0,1.0,3.0,3.0,3.0,1.0,1.0,1.0,3.0,2.0,2.0,3.0,2.0,2.0,2.0,1.0,1.0,3.0,2.0,1.0,3.0,3.0,3.0,3.0,1.0,2.0,1.0,1.0,1.0,3.0,2.0,2.0,3.0,2.0,2.0,2.0,2.0,3.0,2.0,3.0,2.0,2.0,3.0,2.0,3.0,3.0,2.0,2.0,3.0,3.0,3.0,1.0,3.0,3.0,3.0,3.0,3.0,2.0,3.0,1.0,1.0,2.0,1.0,3.0,1.0,2.0,3.0,3.0,1.0,2.0,2.0,2.0,1.0,2.0,1.0,2.0,1.0,3.0,3.0,1.0,1.0,3.0,3.0,3.0,2.0,2.0,2.0,1.0,1.0,2.0,1.0,3.0,1.0,3.0,2.0,2.0,3.0,2.0,2.0,1.0,1.0,3.0,3.0,3.0,2.0,1.0,1.0,3.0,3.0,1.0,1.0,1.0,1.0,2.0,1.0,2.0,1.0,1.0,2.0,3.0,2.0,2.0,3.0,2.0,1.0,1.0,3.0,3.0,1.0,3.0,3.0,3.0,1.0,1.0,2.0,1.0,2.0,2.0,1.0,3.0,1.0,2.0,1.0,2.0,1.0]


# function to get and format dataset 
if false
    function get_iris_data()
        srand(5)
        # Formatting dataset (must Pkg.add("RDatasets"))
        iris = dataset("datasets", "iris")
        data = convert(Array, iris)
        X = transpose(1.0*data[:, 1:4]);
        perm = randperm(150);
        X = X[:, perm]; 
        y = [ones(50); 2*ones(50); 3*ones(50)];
        y = y[perm];
        return (X, y)
    end
end

"""
File: iris_multiclass_helpers.jl
Authors: Reese Pathak, Stephen Boyd
------------------------------------
Helper methods for the iris dataset
multiclass classification problem.
"""

function argmax_by_row(A) 
    """
    Function: argmax_by_row(A)
    Usage: class_labels = argmax_by_row(Y_tilde)
    ---------------------------------------------
    Returns a vector with each entry equal to 
    the index of maximum element (argmax) for the 
    corresponding row vector in the input matrix 
    A. Data type is Float64. 
    """
    return 1.0 * ind2sub(A, vec(findmax(A, dims =2)[2]))[2]
end


function confusion_matrix(y_hat, y_true)
    """
    Function: confusion_matrix(y_hat, y_true)
    Usage: conf_matrix = confusion_matrix(y_hat, y_test)
    ----------------------------------------------------
    Returns a 3x3 matrix where the C[i,j] is the number 
    of predictions for which y_hat[k] == i and 
    y_hat[k] == j. Data type is Float64
    """
    C = zeros(3,3)
    for i in 1:3
        for j in 1:3
            C[i,j] = 1.0 * sum((y_hat .== i) .* (y_true .== j))
        end
    end
    return C
end

Train_X = X[:,1:100];
Test_X  = X[:,101:150];
Train_y = y[1:100];
Test_y  = y[101:150];

Train_Model_1_y = 2 * (Train_y .== 1) .- 1;
Model_1 = Train_X' \ Train_Model_1_y;
Train_Model_2_y = 2 * (Train_y .== 2) .- 1;
Model_2 = Train_X' \ Train_Model_2_y;
Train_Model_3_y = 2 * (Train_y .== 3) .- 1;
Model_3 = Train_X' \ Train_Model_3_y;

Test_Model_1_y = 2 * (Test_y .== 1) .- 1;
Model_1_Train_y_hat = sign.(Train_X' * Model_1);
Model_1_Train_Error_Rate = 1 - sum(Model_1_Train_y_hat .== Train_Model_1_y) / 100;
Model_1_Test_y_hat = sign.(Test_X' * Model_1);
Model_1_Test_Error_Rate = 1 - sum(Model_1_Test_y_hat .== Test_Model_1_y) / 50;
println("Model 1 Error Rate on Train Data is " * string(round(Model_1_Train_Error_Rate; digits = 5)))
println("Model 1 Error Rate on Test Datais " * string(round(Model_1_Test_Error_Rate; digits = 5)))

Test_Model_2_y = 2 * (Test_y .== 2) .- 1;
Model_2_Train_y_hat = sign.(Train_X' * Model_2);
Model_2_Train_Error_Rate = 1 - sum(Model_2_Train_y_hat .== Train_Model_2_y) / 100;
Model_2_Test_y_hat = sign.(Test_X' * Model_2);
Model_2_Test_Error_Rate = 1 - sum(Model_2_Test_y_hat .== Test_Model_2_y) / 50;
println("Model 2 Error Rate on Train Data is " * string(round(Model_2_Train_Error_Rate; digits = 5)))
println("Model 2 Error Rate on Test Datais is " * string(round(Model_2_Test_Error_Rate; digits = 5)))

Test_Model_3_y = 2 * (Test_y .== 3) .- 1;
Model_3_Train_y_hat = sign.(Train_X' * Model_3);
Model_3_Train_Error_Rate = 1 - sum(Model_3_Train_y_hat .== Train_Model_3_y) / 100;
Model_3_Test_y_hat = sign.(Test_X' * Model_2);
Model_3_Test_Error_Rate = 1 - sum(Model_3_Test_y_hat .== Test_Model_3_y) / 50;
println("Model 3 Error Rate on Train Data is " * string(round(Model_3_Train_Error_Rate; digits = 5)))
println("Model 3 Error Rate on Test Datais " * string(round(Model_3_Test_Error_Rate; digits = 5)))

Model = [Model_1 Model_2 Model_3];
Train_y_hat = reshape(getindex.(findmax(Train_X' * Model, dims =2)[2], 2),(100,));
Train_Confusion_Matrix = confusion_matrix(Train_y_hat, Train_y);
println("Train Confusion Matrix :")
println(Train_Confusion_Matrix[1,:])
println(Train_Confusion_Matrix[2,:])
println(Train_Confusion_Matrix[3,:])

println()

Test_y_hat = reshape(getindex.(findmax(Test_X' * Model, dims =2)[2], 2),(50,));
Test_Confusion_Matrix = confusion_matrix(Test_y_hat, Test_y)
println("Test Confusion Matrix :")
println(Test_Confusion_Matrix[1,:])
println(Test_Confusion_Matrix[2,:])
println(Test_Confusion_Matrix[3,:])

Model_Train_Error_Rate = 1 - sum([Train_Confusion_Matrix[1,1],Train_Confusion_Matrix[2,2],Train_Confusion_Matrix[3,3]]) / 100;
println("Model Error Rate on Train Data is " * string(round(Model_Train_Error_Rate; digits = 5)))

Model_Test_Error_Rate = 1 - sum([Test_Confusion_Matrix[1,1],Test_Confusion_Matrix[2,2],Test_Confusion_Matrix[3,3]]) / 50;
println("Model Error Rate on Test Data is " * string(round(Model_Test_Error_Rate; digits = 5)))


