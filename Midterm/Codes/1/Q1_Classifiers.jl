using Random, Distributions
using LinearAlgebra

A = [-0.992451 -0.0662472 -0.111489 -0.0135726 -0.00161579 0.0132494 -0.00113105 -0.00396837 -0.0296594 0.020876;
-0.0662472 -0.418635 0.978395 0.119109 0.0141796 -0.116273 0.00992574 0.0348252 0.260281 -0.183201;
-0.111489 0.978395 0.646567 0.200452 0.0238633 -0.195679 0.0167043 0.0586082 0.438034 -0.308314;
-0.0135726 0.119109 0.200452 -0.975597 0.0029051 -0.0238218 0.00203357 0.00713492 0.0533259 -0.0375338;
-0.00161579 0.0141796 0.0238633 0.0029051 -0.999654 -0.00283593 0.000242091 0.000849395 0.00634833 -0.00446831;
0.0132494 -0.116273 -0.195679 -0.0238218 -0.00283593 -0.976745 -0.00198515 -0.00696504 -0.0520563 0.0366402;
-0.00113105 0.00992574 0.0167043 0.00203357 0.000242091 -0.00198515 -0.999831 0.000594576 0.00444383 -0.00312782;
-0.00396837 0.0348252 0.0586082 0.00713492 0.000849395 -0.00696504 0.000594576 -0.997914 0.0155915 -0.0109742;
-0.0296594 0.260281 0.438034 0.0533259 0.00634833 -0.0520563 0.00444383 0.0155915 -0.88347 -0.0820204;
0.020876 -0.183201 -0.308314 -0.0375338 -0.00446831 0.0366402 -0.00312782 -0.0109742 -0.0820204 -0.942269;]

x = [-0.05539568 0.48613499 0.81812962 0.09959839 0.01185695 -0.097227 0.00829987 0.02912067 0.21764619 -0.15319181]

function Create_data(data_size)
    data = rand(Uniform(-1,1), (data_size,10));
    for i = 1 : data_size
        data[i,:] = data[i,:] / norm(data[i,:])
    end
    return data
end

function Label_data(data_Arr,data_size)
    label_d = zeros(data_size)
    for i = 1 : data_size
        data = data_Arr[i,:]'
        A_pred = data * A * transpose(data)
        if A_pred>=0
            label_d[i] = 1
        else
            label_d[i] = -1
        end
    end
    return label_d 
end

Train_size = 100000;
Test_size = 10000;
Train_data = Create_data(Train_size);
Train_label = Label_data(Train_data,Train_size);
Test_data = Create_data(Test_size);
Test_label = Label_data(Test_data,Test_size);
Model = x' / norm(x);

function Find_alpha(data,model,label)
    model_pred = data*model
    P_indx = findall(label .== 1)
    N_indx = findall(label .== -1)
    Positive_pred = model_pred[P_indx]
    Negative_pred = model_pred[N_indx]
    P_max = maximum(Positive_pred)
    P_min = minimum(Positive_pred)
    N_max = maximum(Negative_pred)
    N_min = minimum(Negative_pred)   
    alpha = (P_max + N_max + abs(P_min) + abs(N_min))/4
    return alpha
end

alpha = Find_alpha(Train_data,Model,Train_label)

function evaluate(model,data,label,n,alpha)
    data_score = abs.(data * model)
    data_pred = (data_score .> alpha ) .* 2 .- 1;
    precision = sum(data_pred .== label) / n;
    return precision
end

Train_precision = evaluate(Model,Train_data,Train_label,Train_size,alpha)
println("The precision of my classifier on training data is ", string(Train_precision*100 , "%"))

Test_precision = evaluate(Model,Test_data,Test_label,Test_size,alpha)
println("The precision of my classifier on test data is ", string(Test_precision*100 , "%"))




