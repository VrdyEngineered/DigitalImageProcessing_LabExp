function vivek_ImgCompression_shannoncoding(imgg)
close all;
clc
% --- STEP 1: Read image ---
img = imread(imgg); %Load image (can be JPG, BMP, PNG, or TIF)

% If it's a color image (3 channels), convert it to grayscale
if size(img, 3)==3
    img = uint8(mean(img,3)); % Average the RGB values to get black & white image
end

% --- STEP 2: Prepare pixel data ---
data = img(:); %Flatten image into a long column of pixel values (0–255)

% --- STEP 3: Get symbol frequencies ---
symbols = unique(data); % 🔍 Find all unique pixel values that actually appear
freq = histcounts(data, symbols); % Count how many times each pixel value appears
prob = freq / sum(freq); % Convert counts to probabilities

% --- STEP 4: Sort symbols by probability ---
[prob, idx] = sort(prob, 'descend'); % ⬇️ Most frequent first
symbols = symbols(idx); %  Reorder symbols accordingly

% --- STEP 5: Generate Shannon–Fano codes ---
codes = shannon_fano(symbols, prob); % 🧠 Assign binary codes based on probability

% --- STEP 6: Encode the image ---
encoded_str = ''; % Start with an empty string for our compressed bits
for i = 1:length(data)
    encoded_str = [encoded_str codes{symbols == data(i)}]; %#ok<AGROW>
    %  For each pixel: find its symbol, append its binary code
end

% --- STEP 7: Calculate compression stats ---
original_bits = numel(data) * 8; %  Size before compression (8 bits per pixel)
compressed_bits = length(encoded_str); % Size after compression (bits)

compression_ratio = original_bits / compressed_bits; % Compression ratio

original_size_kb = original_bits / 8 / 1024; % KB before compression
compressed_size_kb = compressed_bits / 8 / 1024; % KB after compression

% Print results
fprintf('Original size: %.2f KB\n', original_size_kb);
fprintf('Compressed size: %.2f KB\n', compressed_size_kb);
fprintf('Compression ratio: %.2f\n', compression_ratio);

% --- STEP 8: Show original & "compressed" images ---
figure;
subplot(1,2,1);
imshow(img);
title(sprintf('Original Image\n%.2f KB', original_size_kb));

subplot(1,2,2);
imshow(img); %  We show the same image, since Shannon–Fano is lossless
title(sprintf('Compressed Image\n%.2f KB', compressed_size_kb));
end
% =========================
% Shannon–Fano Coding Function
% =========================
function codes = shannon_fano(symbols, prob)
    codes = cell(length(symbols),1); %Prepare empty list for codes
    assign_codes(1:length(symbols), prob, ''); % Start recursive coding
    
    function assign_codes(indices, prob, prefix)
        if length(indices) == 1
            codes{indices} = prefix; %  Assign code if only one symbol remains
            return;
        end
        
        %  Find the split point where probability is half the total
        total = sum(prob);
        cum_sum = cumsum(prob);
        [~, split_index] = min(abs(cum_sum - total/2));
        
        % Left group gets '0', right group gets '1'
        assign_codes(indices(1:split_index), prob(1:split_index), [prefix '0']);
        assign_codes(indices(split_index+1:end), prob(split_index+1:end), [prefix '1']);
    end
end

