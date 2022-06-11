clc;
clear;
close all;

image = imread('ImageInput/sample_image3.jpg');
figure, imshow(image);title('Citra RGB');

gray = rgb2gray(image);
figure, imshow(gray);title('Citra Grayscale');

bw = imbinarize(gray, graythresh(gray));
figure, imshow(bw);title('Citra Biner dengan Otsu Threshold');

bw = imfill(bw, 'holes');
figure,imshow(bw);title('Image Fill');

bw = bwareaopen(bw,550);
figure,imshow(bw);title('Image Clean Up');

R = image(:,:,1).*uint8(bw);
G = image(:,:,2).*uint8(bw);
B = image(:,:,3).*uint8(bw);

output = cat(3, R, G, B);
figure, imshow(output);title('Citra Output');
imwrite(output,'ImageOutput/sample3Thresh.jpg');
