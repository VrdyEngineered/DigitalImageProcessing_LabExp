# Experiment 2B – Bit Slicing in Digital Image Processing

## 📌 Description

This experiment demonstrates **bit-plane slicing** on a grayscale image using MATLAB. Bit slicing is a technique used to analyze specific bits of pixel intensity values, which helps in image compression, enhancement, and feature extraction.

Each pixel in a grayscale image is typically represented using 8 bits (values from 0 to 255). Bit slicing helps isolate individual bit-planes from these 8-bit representations.

---

## 🎯 Objectives

- Understand and implement the concept of **bit-plane slicing**.
- Extract all 8 bit-planes from an image manually using custom logic.
- Display the contribution of each bit to the image quality.

---

## ⚙️ Logic (Manual Implementation)

1. Read the input grayscale image.
2. Check if the image is RGB; if so, convert it to grayscale.
3. Store the image dimensions.
4. Initialize an array of 8 matrices to store bit-planes (all zeros).
5. Loop through each pixel:
    - Get the intensity value (0–255).
    - Convert it to binary (8-bit).
    - Extract bits from **MSB (bit 8)** to **LSB (bit 1)**.
    - Store each bit in the corresponding `bit_planes(:,:,count)` matrix.
6. Display each bit-plane as a grayscale image.

---

## 🖼️ Sample Output

Each bit-plane will be displayed as an 8-bit grayscale image.

- **Bit-plane 8 (MSB)** shows the most significant details.
- **Bit-plane 1 (LSB)** shows the least significant details (mostly noise).

---


## ✍️ Author
**Name:** Chilla Vivek Reddy<br>
**Roll No.:** BT23ECI037
