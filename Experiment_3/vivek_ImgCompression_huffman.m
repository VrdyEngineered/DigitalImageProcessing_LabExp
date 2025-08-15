function vivek_ImgCompression_huffman(imgg)

%% Huffman Coding for Image Compression
clc;  close all;

% --- STEP 1: Read the grayscale image ---
img = imread(imgg); % Can be PNG/JPG/BMP/TIF
if size(img, 3) == 3
    img = rgb2gray(img); % Convert color image to grayscale
end

% Flatten image into a 1D array for processing
data = img(:);

% --- STEP 2: Calculate symbol frequencies ---
symbols = unique(data);            % Unique pixel values
freq = histc(data,symbols);     % Count occurrences
prob = freq / sum(freq);           % Convert counts to probabilities

% --- STEP 3: Generate Huffman dictionary ---
[dict, ~] = huffmandict(symbols, prob); % dict = {symbol, code}

% --- STEP 4: Encode the image ---
encoded = huffmanenco(data, dict); % Encoded as 0/1 bitstream

% --- STEP 5: Decode to reconstruct image ---
decoded = huffmandeco(encoded, dict);
decoded_img = reshape(uint8(decoded), size(img)); % Reshape to original size

% --- STEP 6: Calculate compression metrics ---
original_bits = numel(data) * 8;          % Original size in bits
compressed_bits = length(encoded);        % Compressed size in bits
compression_ratio = original_bits / compressed_bits;

fprintf('Original Size: %.2f KB\n', original_bits/8/1024);
fprintf('Compressed Size: %.2f KB\n', compressed_bits/8/1024);
fprintf('Compression Ratio: %.2f:1\n', compression_ratio);

% --- STEP 7: Display Original vs Reconstructed Image ---
figure;
subplot(1,2,1);
imshow(img);
title(sprintf('Original Image\n%.2f KB', original_bits/8/1024));

subplot(1,2,2);
imshow(decoded_img);
title(sprintf('Reconstructed Image\n%.2f KB', compressed_bits/8/1024));
end
