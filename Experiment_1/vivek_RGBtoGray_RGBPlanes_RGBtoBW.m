function vivek_RGBtoGray_RGBPlanes_RGBtoBW(imgg, choice)
close all;
clc;
% Function to process image based on choice:
% 1 - Convert RGB to Grayscale (3 logic versions)
% 2 - Show Red Plane
% 3 - Show Green Plane
% 4 - Show Blue Plane
% 5 - Convert Grayscale to Black and White

% Read and display original image
I = imread(imgg);
figure;
imshow(I); title("Original Image");

[M, N, ~] = size(I);
OutputImage = zeros(M, N, 'uint8'); % Initialize output

switch choice
    case 1
        % --- RGB to Grayscale Conversion ---
        
        % Logic 1: Weighted sum method (used)
        RGB = double(I);
        Gray = 0.298936 * RGB(:, :, 1) + ...
               0.587043 * RGB(:, :, 2) + ...
               0.114021 * RGB(:, :, 3);
        OutputImage = uint8(Gray);
        
        % Gray_Image_avg = uint8(mean(OutputImage, 'all')); % Optional average grayscale value

        % Logic 2: Average method (commented)
        % OutputImage = uint8(mean(I, 3));

        % Logic 3: Pixel-wise weighted sum using loops (commented)
        % for i = 1:M
        %     for j = 1:N
        %         R = double(I(i, j, 1));
        %         G = double(I(i, j, 2));
        %         B = double(I(i, j, 3));
        %         OutputImage(i, j) = uint8(0.298936 * R + 0.587043 * G + 0.114021 * B);
        %     end
        % end

    case 2
        % --- Red Plane ---
        Ired=I;
        Ired(:,:,2)=0;
        Ired(:,:,3)=0;
        OutputImage = Ired;

    case 3
        % --- Green Plane ---
        Ig=I;
        Ig(:,:,1)=0;
        Ig(:,:,3)=0;
        OutputImage = Ig;

    case 4
        % --- Blue Plane ---
        Ib=I;
        Ib(:,:,1)=0;
        Ib(:,:,2)=0;
        OutputImage = Ib;

    case 5
        % --- RGB to Black and White using threshold ---
        RGB = double(I);
        Gray = 0.298936 * RGB(:, :, 1) + ...
               0.587043 * RGB(:, :, 2) + ...
               0.114021 * RGB(:, :, 3);
        Gray = uint8(Gray);
        
        % Gray_Image_avg = uint8(mean(Gray, 'all')); % Optional mean gray value
        %Can use mean value of pixels intensity of given image  but mid-value of intensity (127) is more accurate 


        BW = Gray; % Copy for thresholding
        for i = 1:M
            for j = 1:N
                if BW(i, j) <= 127
                    BW(i, j) = 0;
                else
                    BW(i, j) = 255;
                end
            end
        end
        OutputImage = uint8(BW);

    otherwise
        disp('Invalid choice. Please enter a number from 1 to 5.');
        return;
end

% Display result
figure;
imshow(OutputImage);
titles = ["Grayscale Image", "Red Plane", "Green Plane", "Blue Plane", "Black and White Image"];
title(titles(choice));
end
