function vivek_ImgCompression_ArithmaticCoding(imgg) 
close all;
clc
% Step 1: Read the Image
originalImage = imread(imgg);
if size(originalImage, 3)==3
    originalImage = rgb2gray(originalImage); % Proper grayscale conversion
end
[rows, cols] = size(originalImage);

% Step 2: Prepare Symbols and Probability Model
% Convert the 2D image into a 1D vector of symbols.
original_symbols = double(originalImage(:));

% --- FIX STARTS HERE ---
% Find the unique pixel values and their counts.
% 'unique' also gives us the mapping 'ic' which we will use.
[unique_symbols, ~, ic] = unique(original_symbols);

% The sequence to be encoded is now 'ic', which contains values from 1 to N,
% where N is the number of unique symbols.
seq_to_encode = ic(:)'; % Ensure it's a row vector

% The counts are simply the number of times each unique symbol appears.
counts = histcounts(ic, 1:(length(unique_symbols)+1) );
% --- FIX ENDS HERE ---

% Step 3: Encode the image data
compressedCode = arithenco(seq_to_encode, counts);

% Step 4: Decode the data
% The decoder needs the original length of the sequence
decompressed_seq = arithdeco(compressedCode, counts, length(seq_to_encode));

% Step 5: Reshape and Reconstruct the Image
% Map the decoded sequence (1, 2, 3...) back to the original pixel values.
reconstructed_symbols = unique_symbols(decompressed_seq);
reconstructedImage = uint8(reshape(reconstructed_symbols, rows, cols));

if isequal(originalImage, reconstructedImage)
    disp('Success: The reconstructed image is identical to the original.');
else
    disp('Error: The images are different.');
end

% % Calculate the compression ratio
% originalBits = numel(originalImage) * 8;
% compressedBits = numel(compressedCode) * 8;
% compressionRatio = originalBits / compressedBits;
% 
% fprintf('\nOriginal Size: %.2f KB\n', originalBits/8/1024);
% fprintf('Compressed Size: %.2f KB\n', compressedBits/8/1024);
% fprintf('Compression Ratio: %.2f : 1\n', compressionRatio);
% --- Corrected Verification and Results ---

% The TRUE size of the compressed data is the length of the binary stream.
% The 'compressedCode' variable is a vector of bits (0s and 1s).
compressedBits = length(compressedCode); 

originalBits = numel(originalImage) * 8; % 8 bits per pixel for uint8
compressionRatio = originalBits / compressedBits;

fprintf('\n--- Correct Measurement ---\n');
fprintf('Original Raw Data Size: %.2f KB\n', originalBits / (8*1024));
fprintf('True Compressed Stream Size: %.2f KB\n', compressedBits / (8*1024));
fprintf('Compression Ratio: %.2f : 1\n', compressionRatio);

% --- Old, Misleading Calculation for Comparison ---
bloatedMemorySize = numel(compressedCode) * 64; % 64 bits for each double
fprintf('\n--- Why it looked big ---\n');
fprintf('Bloated In-Memory Size of Compressed Data: %.2f KB\n', bloatedMemorySize / (8*1024));

% Step 6: Verification and Results
figure;
subplot(1, 2, 1);
imshow(originalImage);
title(sprintf('Original Image\n %.2f KB',originalBits / (8*1024)));
subplot(1, 2, 2);
imshow(reconstructedImage);
title(sprintf('Reconstructed Image\n %.2f KB',compressedBits / (8*1024)));

end

