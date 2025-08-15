# Experiment 3 - Image Compression using Shannon and Huffman Coding

## Author
**Name:** Chilla Vivek Reddy<br>
**Roll No.:** BT23ECI037
---

## Overview
This experiment demonstrates the process of compressing a grayscale image using **Shannon-Fano** and **Huffman** coding techniques.  
The objective is to reduce the storage requirements by encoding pixel values more efficiently while retaining the image quality.  

---

## Algorithms Used

### Shannon-Fano Coding
- Shannon-Fano is an entropy-based compression method.
- It assigns shorter codes to frequent symbols and longer codes to less frequent symbols.
- The symbol set is divided into two parts of approximately equal probabilities, and the process is repeated recursively.

### Huffman Coding
- Huffman coding creates an optimal variable-length code based on symbol frequencies.
- It builds a binary tree where each symbol is a leaf, and the path to each leaf gives the code.
- Huffman coding generally produces better compression than Shannon-Fano.

---

## Note
In MATLAB, when an **8-bit grayscale image** (e.g., 256×256 pixels, ~8 KB on disk) is read using `imread`, it is stored as raw pixel data in memory, resulting in a size of **64 KB** before compression. The compression ratio is calculated based on this in-memory size.

---

## Output
- Compressed bitstream for both Shannon-Fano and Huffman coding.
- Compression ratio achieved.
- Comparison of efficiency between the two methods.

---

## Conclusion
- Huffman coding often achieves slightly better compression than Shannon-Fano for natural images.
- The performance depends on the image’s symbol distribution.
- Entropy coding is lossless — the original image can be reconstructed exactly from the compressed data.
