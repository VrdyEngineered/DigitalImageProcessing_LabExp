# 🎯 Digital Image Processing Laboratory

This repository contains lab experiments and assignments for the **Digital Image Processing (DIP)** course, completed as part of the academic curriculum.

---

## 📁 Folder Structure

Each experiment is organized in a separate folder and includes source code, input/output images, and function descriptions.

---

## 🧪 Experiments 

| No. | Title                                 | Status       |
|-----|---------------------------------------|--------------|
| 1   | RGB to Grayscale, RGB Planes, BW      | ✅ Completed |


---

## 🔬 Experiment 1: RGB to Grayscale, RGB Planes, BW

### 📌 Objective

To process a given color image using three different techniques:
- **1a:** Convert RGB image to **Grayscale**
- **1b:** Extract and display **Red, Green, and Blue planes**
- **1c:** Convert RGB image to **Black and White** using thresholding

---

### ⚙️ How to Use

Run the combined function file in MATLAB:

```matlab
vivek_RGBtoGray_RGBPlanes_RGBtoBW('color1.png', choice);
Examples:
vivek_RGBtoGray_RGBPlanes_RGBtoBW('color1.png', 1); % gives you Grayscale Image
vivek_RGBtoGray_RGBPlanes_RGBtoBW('color1.png', 2/3/4); % RGB Planes (2 for RED Plane , 3 for GREEN Plane , 4 for BLUE PLane)
vivek_RGBtoGray_RGBPlanes_RGBtoBW('color1.png', 5); % gives you Black and White Image



