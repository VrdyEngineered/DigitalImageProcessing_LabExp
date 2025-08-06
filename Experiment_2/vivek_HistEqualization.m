
function vivek_HistEqualization(imgg)
close all;
clc;



% Step 1: Input 8x8 grayscale image
I = imread(imgg);
% Check if image is a color image??
if size(I,3)==3
    I= uint8(mean(I, 3)); % Convert ColorImg2GrayScaleImg
end

[M, N] = size(I);              % Get image dimensions (8, 8)
num_pixels = M * N;            % Total number of pixels (64)

% Step 2: Flatten the image into a 1D array
I_flat=I(:);
% I_flat = reshape(I, 1, []);    % Converts 8x8 matrix into 1x64 row vector

% Step 3: Initialize histogram array for 256 levels (0–255)
histogram = zeros(1, 256);

% Step 4: Count frequency of each intensity value
for i = 1:num_pixels
    pixel_val = I_flat(i);
    histogram(pixel_val + 1) = histogram(pixel_val + 1) + 1; % +1 for MATLAB indexing
end

% Step 5: Compute the CDF (cumulative sum of histogram)
cdf = cumsum(histogram);
cdf_min = min(cdf(cdf > 0));   % Minimum non-zero CDF value

% Step 6: Apply Histogram Equalization
equalized = zeros(1, 256);
for i = 1:256
    equalized(i) = round((cdf(i) - cdf_min) / (num_pixels - cdf_min) * 255);
end

% Step 7: Map old pixel values to new equalized values
I_eq_flat = zeros(1, num_pixels);
for i = 1:num_pixels
    I_eq_flat(i) = equalized(I_flat(i) + 1);  % +1 for MATLAB indexing
end

% Step 8: Reshape equalized flat image back to 8x8
I_eq = reshape(I_eq_flat, M, N);

figure;
subplot(2,2,1);
imshow(uint8(I));title('Original Image');

subplot(2,2,2);
bar(0:255, histogram);
xlim([0 255]);
title('Histogram of Original Image');

subplot(2,2,3);
imshow(uint8(I_eq));
title('Equalized Image');

subplot(2,2,4);
eq_hist = zeros(1, 256);
for i = 1:num_pixels
    eq_hist(I_eq_flat(i) + 1) = eq_hist(I_eq_flat(i) + 1) + 1;
end
bar(0:255, eq_hist);
xlim([0 255]);
title('Histogram of Equalized Image');
