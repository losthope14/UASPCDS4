clc;
clear;
close all;

image = imread('ImageInput/sample_image11.jpg');
figure,imshow(image);title('Original Image');

gray = rgb2gray(image);
canny = edge(gray, 'log');
figure, imshow(canny);title('Log Edge Detection');

proses_close = imclose(canny,strel('line',30,0));
figure, imshow(proses_close);title('imclose');

proses_fill = imfill(proses_close, 'holes');
figure, imshow(proses_fill);title('Imfill');

proses_open =imopen(proses_fill,strel(ones(3,3)));
figure, imshow(proses_open);title('Imopen');

mask = bwareaopen(proses_open,1000);
figure, imshow(mask);title('Mask');

R = image(:,:,1).*uint8(mask);
G = image(:,:,2).*uint8(mask);
B = image(:,:,3).*uint8(mask);

op = cat(3, R, G, B);
figure, imshow(op);title('Output');
imwrite(op,'ImageOutput/sampleImage11Edge.jpg');
