clc;
clear;
close all;

image = imread('ImageOutput/sampleImage11Edge.jpg');
figure, imshow(image);title('Original Image');

cform = makecform('srgb2lab');
lab = applycform(image, cform);
figure, imshow(lab);title('Lab color space');
imwrite(lab,'LabCS11.jpg');

ab = double(lab);
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,3);

nColors = 6;
[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqeuclid','Replicates',6);
pixel_labels = reshape(cluster_idx,nrows,ncols);
RGB = label2rgb(pixel_labels);

figure,imshow(RGB,[]); title('K-means CLustering');
imwrite(RGB,'KMeans11.jpg');

segmentedImages = cell(1,3);
rgbLabel = repmat(pixel_labels, [1 1 3]);

for k = 1:nColors
    color = image;
    color(rgbLabel ~= k) = 0;
    segmentedImages{k} = color;
    figure, imshow(segmentedImages{k});title(strcat(['Objek dalam cluster ',num2str(k)]));
    imwrite(segmentedImages{k},strcat(['ImageOutput/sample11KmeansObject_',num2str(k),'.jpg']));
end