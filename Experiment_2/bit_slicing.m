function bit_slicing(imgg)
close all;
clc

% 1. Read image
img = imread(imgg); % Replace with your image

% 2. Check if RGB
if size(img, 3) == 3
    img =  uint8(mean(img, 3));
end

% 3. Get dimensions
[rows, cols] = size(img);

% 4. Initialize 8 bitplanes with zeros
bit_planes = zeros(rows, cols, 8); % 8 bit-planes

% 5. Traverse each pixel
for i = 1:rows
    for j = 1:cols
        % 6. Get intensity
        pixel_val = img(i, j);
        
        % 7. Convert to binary string (8-bit)
        binary_val = dec2bin(pixel_val, 8);  % Returns a string like '00110111'
        
        % 8. Extract MSB to LSB (bit 8 to bit 1)
        for count = 1:8
            binary_bit_value = str2double(binary_val(count));  % Get bit (MSB first)
            bit_planes(i, j, count) = binary_bit_value;         % Store it in bitplanes
        end
    end
end

% 9. Display all bit planes (from MSB to LSB)
figure;
for k = 1:8
    subplot(2,4,k);
    %Below is to view bit slicing in grayscale but most of them will be balck due to LSB bits values 
    %imshow(uint8(bit_planes(:, :, k) * 2^(8 - k)));
    imshow(logical(bit_planes(:,:,k)));  % Convert to logical for display
    title(['Bit Plane ', num2str(9 - k)]);  % Reverse title to match bit number (MSB=8)
end
