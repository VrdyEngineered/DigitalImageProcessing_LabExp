close all;
clc
% --- STEP 1: Read image ---
img = imread('lowcontrast.jpg'); % Load image (can be JPG, BMP, PNG, or TIF)

% If it's a color image (3 channels), convert it to grayscale
if size(img, 3)==3
    img = rgb2gray(img); % Proper grayscale conversion
end

% --- STEP 2: Prepare pixel data ---
data = img(:)'; % Flatten image into row vector

% --- STEP 3: Get symbol frequencies ---
symbols = unique(data);                % Unique pixel values
counts = histc(data, symbols);         % Count occurrences of each symbol
prob = counts / sum(counts);           % Convert counts → probabilities

% --- STEP 4: Map pixels to symbol indices ---
[~, idx] = ismember(data, symbols);    % Replace pixels with symbol indices (1..length(symbols))

% --- STEP 5: Arithmetic Encoding ---
arithStream = arithenco(idx, counts);  % Encode using counts

% --- STEP 6: Arithmetic Decoding ---
decodedIdx = arithdeco(arithStream, counts, length(idx));
decodedImg = reshape(symbols(decodedIdx), size(img));

% --- STEP 7: Compression stats ---
original_bits = numel(data) * 8;       % Original size (8 bits/pixel)
compressed_bits = numel(arithStream);  % Encoded stream length in bits
compression_ratio = original_bits / compressed_bits;

original_size_kb = original_bits / 8 / 1024;
compressed_size_kb = compressed_bits / 8 / 1024;

% --- STEP 8: Entropy, Avg Length, Efficiency, Redundancy ---
entropy_val = -sum(prob(prob>0) .* log2(prob(prob>0))); % Entropy
L = compressed_bits / numel(data);                      % Avg code length
efficiency = (entropy_val / L) * 100;
redundancy = 100 - efficiency;

% --- STEP 9: Print results ---
fprintf('Original size: %.2f KB\n', original_size_kb);
fprintf('Compressed size: %.2f KB\n', compressed_size_kb);
fprintf('Compression ratio: %.2f\n', compression_ratio);
fprintf('Entropy (H): %.4f bits/symbol\n', entropy_val);
fprintf('Average Code Length (L): %.4f bits/symbol\n', L);
fprintf('Efficiency: %.2f %%\n', efficiency);
fprintf('Redundancy: %.2f %%\n', redundancy);

% --- STEP 10: Show original & reconstructed images ---
figure;
subplot(1,2,1);
imshow(img);
title(sprintf('Original Image\n%.2f KB', original_size_kb));

subplot(1,2,2);
imshow(uint8(decodedImg));
title(sprintf('Reconstructed Image\n%.2f KB | L=%.2f', compressed_size_kb,L));
