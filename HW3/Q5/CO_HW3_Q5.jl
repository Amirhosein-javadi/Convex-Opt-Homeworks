include("readclassjson.jl")
data = readclassjson("tomo_data.json");
using Plots

N = data["N"];
npixels = data["npixels"];
y = data["y"];
line_pixel_lenghts = data["line_pixel_lengths"];
lines_theta = data["lines_theta"];
lines_d = data["lines_d"];
A = line_pixel_lenghts';
x = A \ y;

reshaped_x = reshape(x,(30,30))
heatmap(reshaped_x, yflip=true, aspect_ratio=:equal, color=:gist_gray, cbar=:none, framestyle=:none)

using LinearAlgebra
A_Rank = rank(A)
print("Rank of matrix A is " * string(A_Rank) * ". So A is full rank and the least squares problem has unique answer.")
