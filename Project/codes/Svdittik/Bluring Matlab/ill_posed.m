clc;
close all;
clear all;
N = 32;
bandw = 3;
xy = 'x';
A_x = mblur(N,bandw,xy);
save('A_x.mat','A_x');
xy = 'y';
A_y = mblur(N,bandw,xy);
save('A_y.mat','A_y');
T = oblur(N,bandw);
save('T.mat','T');
%%
image = double(imread('image.jpg'));
figure() 
imshow(uint8(image))
%%
vector_image = image(:);
restored_image = reshape(vector_image,[32,32]);
figure() 
imshow(uint8(restored_image))
%%
A_x_filtered = A_x * vector_image;
A_x_restored = reshape(A_x_filtered,[32,32]);
imwrite(uint8(A_x_restored),'A_x_result.jpg')
%%
A_y_filtered = A_y * vector_image;
A_y_restored = reshape(A_y_filtered,[32,32]);
imwrite(uint8(A_y_restored),'A_y_result.jpg')
%%
T_filtered = T * vector_image;
T_restored = reshape(T_filtered,[32,32]);
imwrite(uint8(T_restored),'T_result.jpg')
