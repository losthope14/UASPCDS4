clc;
clear;
close all;

image = imread('ImageInput/sample_image4.jpg');
figure, imshow(image);title('Original Image');

cform = makecform('srgb2lab');
lab = applycform(image, cform);
figure, imshow(lab);title('Lab color space');
imwrite(lab,'ImageOutput/LabColorSpace4.jpg');

ab = double(lab);
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,3);

nColors = 3;
[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqeuclid','Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);
RGB = label2rgb(pixel_labels);

figure,imshow(RGB,[]); title('K-means Clustering');
imwrite(RGB,'ImageOutput/Kmeans4.jpg');

segmentedImages = cell(1,3);
rgbLabel = repmat(pixel_labels, [1 1 3]);

for k = 1:nColors
    color = image;
    color(rgbLabel ~= k) = 0;
    segmentedImages{k} = color;
    figure, imshow(segmentedImages{k});title(strcat(['Objek pada cluster ',num2str(k)]));
    imwrite(segmentedImages{k},strcat(['ImageOutput/sample4KmeansObject_',num2str(k),'.jpg']));
end
