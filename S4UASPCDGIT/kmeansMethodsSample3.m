clc;
clear;
close all;

image = imread('ImageOutput/sample3Thresh.jpg');
figure, imshow(image);title('Image Input');

cform = makecform('srgb2lab');%srgb2xyz
lab = applycform(image, cform);
figure, imshow(lab);title('Lab color space');
imwrite(lab,'LabCS3.jpg');

ab = double(lab);
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,3);

nColors = 3;
[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqeuclid','Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);
RGB = label2rgb(pixel_labels);

figure,imshow(RGB,[]); title('K-means Clustering');
imwrite(RGB,'KMeans3.jpg');

segmentedImages = cell(1,3);
rgbLabel = repmat(pixel_labels, [1 1 3]);

for k = 1:nColors
    color = image;
    color(rgbLabel ~= k) = 0;
    segmentedImages{k} = color;
    figure, imshow(segmentedImages{k});title(strcat(['Objek dalam cluster ',num2str(k)]));
    imwrite(segmentedImages{k},strcat(['ImageOutput/sample3KmeansObject_',num2str(k),'.jpg']));
end