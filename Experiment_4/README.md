# Experiment 4: Image Compression using Arithmetic Coding and JPEG
---
## Author
**Name:** Chilla Vivek Reddy<br>
**Roll No.:** BT23ECI037

---

## Aim

To study and implement two fundamental image compression techniques:
1.  **Lossless Compression** using Arithmetic Coding.
2.  **Lossy Compression** using the JPEG method with the Discrete Cosine Transform (DCT).

---

## Brief Theory

Image compression is the process of reducing the total number of bits required to represent an image. This is done by removing redundant data. The techniques are broadly classified into two categories:

### 1. Lossless Compression
In lossless compression, the reconstructed image after decompression is **bit-for-bit identical** to the original image. No information is lost. This is crucial for applications where perfect fidelity is required, such as medical imaging or archival purposes.

* **Arithmetic Coding**: This is an entropy encoding technique that represents an entire stream of symbols as a single fractional number in the range [0, 1). It is more efficient than Huffman coding because it can assign a non-integer number of bits to each symbol, allowing it to get closer to the theoretical compression limit (entropy).

### 2. Lossy Compression
In lossy compression, some information from the original image is permanently discarded. The reconstructed image is a close approximation of the original but is not identical. This method can achieve much higher compression ratios than lossless techniques.

* **JPEG (Joint Photographic Experts Group)**: This is the most common lossy compression standard. Its core logic is to transform the image from the spatial domain to the frequency domain using the **Discrete Cosine Transform (DCT)**. In the frequency domain, it's possible to identify and discard high-frequency information that is less perceptible to the human eye. This is achieved through a step called **quantization**.

---

## Methodology and Algorithms

### Arithmetic Coding (Lossless)
The algorithm follows these steps:
1.  **Read Image**: The input image is read into a matrix.
2.  **Create Probability Model**: The image data is converted into a 1D sequence of symbols. The unique symbols (pixel values) and their frequencies (counts) are determined to create a probability model.
3.  **Encode**: The `arithenco` function in MATLAB is used to encode the sequence of symbols based on their counts into a compressed binary stream.
4.  **Decode**: The `arithdeco` function uses the compressed stream and the original counts to perfectly reconstruct the sequence of symbols.
5.  **Reconstruct Image**: The decoded sequence is reshaped back into the original image dimensions. The final image is identical to the original.

### JPEG Compression (Lossy)
The algorithm processes the image in 8x8 blocks and follows these steps:
1.  **Read Image**: The input image is read. If it's a color image, it's converted to grayscale for this demonstration.
2.  **Block Processing**: The image is divided into 8x8 pixel blocks.
3.  **Apply DCT**: For each block, the `dct2` function is applied. This transforms the 8x8 block of pixel values into an 8x8 block of frequency coefficients.
4.  **Quantization**: Each coefficient in the DCT block is divided by a corresponding value from a standard **Quantization Table**, and the result is rounded. This is the **lossy step** where high-frequency information is discarded (rounded to zero).
5.  **De-quantization & Inverse DCT**: To view the result, the process is reversed. The quantized block is multiplied by the same table, and the `idct2` function is applied to convert the coefficients back to pixel values.
6.  **Reconstruct Image**: All the reconstructed 8x8 blocks are reassembled to form the final compressed image.

---

## Implementation Details

The implementation for each compression algorithm is provided as a function within a `.m` file.

#### 1. `performArithmeticCompression.m`
* This function implements lossless compression using MATLAB's built-in `arithenco` and `arithdeco` functions.
* It correctly handles both grayscale and color images by processing each color channel independently.
* The compression ratio is calculated based on the original raw bits (pixels * 8) versus the length of the compressed binary stream.

#### 2. `performJPEGCompression.m`
* This function demonstrates the core logic of lossy JPEG compression.
* It uses `blockproc` to efficiently apply the DCT and quantization logic to every 8x8 block of the image.
* The `quantizationTable` is the key controller of compression. Larger values in this table lead to more data being discarded and thus a higher compression ratio (and lower quality).
* The "Compressed Size" is an **estimate** based on how many non-zero coefficients remain after quantization.

---

## How to Run the Code

1.  Ensure you have MATLAB installed with the **Image Processing Toolbox**.
2.  Place the MATLAB function files (`vivek_ImgCompression_ArithmaticCoding.m`, `vivek_ImgCompression_JPEG.m`) and a sample image in the same directory.
3.  Open MATLAB and navigate to this directory.
4.  To run the Arithmetic Coding experiment, call the function from the command window: `vivek_ImgCompression_ArithmaticCoding.m('my_image.png')`.
5.  To run the JPEG experiment, call the function: `vivek_ImgCompression_JPEG.m('my_image.png')`.
6.  Observe the figures generated and the output in the command window, which shows size comparisons and compression ratios.

---

## Observations and Results

** Output Files include the Compressed Images.

| Feature            | Arithmetic Coding (Lossless)                                  | JPEG Compression (Lossy)                                        |
| ------------------ | ------------------------------------------------------------- | --------------------------------------------------------------- |
| **Reconstruction** | Reconstructed image is **identical** to the original.         | Reconstructed image is an **approximation** of the original.    |
| **Quality** | Perfect (no data loss).                                       | Degrades as compression increases. Blocky artifacts may appear. |
| **Compression Ratio**| The compression ratio is **1.25:1**.                             | The compression ratio is **2.6:1** and size is 24.5 bytes.                               |
| **Key Principle** | Statistical redundancy (entropy encoding).                    | Perceptual redundancy (discards what the human eye can't see).  |

---
