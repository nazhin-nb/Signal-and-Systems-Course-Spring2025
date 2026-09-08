# Computer Assignment 2: 2D Signal Processing, Template Matching & Number Plate Recognition (ANPR)

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Assignment](https://img.shields.io/badge/Assignment-CA%20%232-107C41?style=for-the-badge)](#)
[![Domain](https://img.shields.io/badge/Domain-2D%20Signal%20Processing%20%26%20OCR-purple?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical & Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Overview

This project implements an **Automatic Number Plate Recognition (ANPR)** and vehicle analysis system using **2D Signal Processing** and **Template Matching** in MATLAB. All core image processing primitives (grayscale conversion, binarization, connected component labeling, and noise filtering) were developed from scratch without relying on MATLAB's built-in toolbox equivalents.

---

## 📁 Directory Structure

```text
CA2/
├── codes/
│   ├── functions/
│   │   ├── mygrayfun.m           # Custom RGB-to-grayscale conversion (0.299R + 0.578G + 0.114B)
│   │   ├── mybinaryfun.m         # Custom global threshold binarization
│   │   ├── find_any.m            # First foreground pixel locator for component seeding
│   │   ├── detect_parts.m        # 8-connectivity Breadth-First Search (BFS) component extraction
│   │   ├── myremovecom.m         # Component size filtering (scratch equivalent of bwareaopen)
│   │   └── mysegmentation.m      # Connected component labeling (scratch equivalent of bwlabel)
│   ├── Map Set/                  # English alphanumeric template dataset (A-Z, 0-9)
│   ├── PersianMapSet/            # Custom Persian template dataset (letters and digits)
│   ├── PersianTestPlate/         # Persian license plate test images
│   ├── Test Images/              # English license plate test images
│   ├── p1.m                      # English plate processing pipeline & batch testing
│   ├── p2.m                      # Persian plate segmentation & OCR pipeline
│   ├── p3.m                      # Vehicle front plate localization & end-to-end OCR
│   ├── p4.m                      # Vehicle speed estimation pipeline script
│   ├── p2/                       # Sample Persian plate images
│   └── p3/                       # Full car front test images
├── ca2.pdf                       # Official assignment description
├── CA2-Report.pdf                # Technical project report
├── output.txt                    # Recognized plate text outputs
└── README.md                     # Project documentation
```

---

## 🔬 Core Implementations

### 1. Part 1: English Plate Recognition & Custom Image Processing Functions
- **From-Scratch Primitives:**
  - **Grayscale Conversion ([mygrayfun.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA2/codes/functions/mygrayfun.m)):** Weighted luminance sum ($0.299R + 0.578G + 0.114B$).
  - **Binarization ([mybinaryfun.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA2/codes/functions/mybinaryfun.m)):** Intensity thresholding ($T = 100$).
  - **8-Connected BFS Component Search ([detect_parts.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA2/codes/functions/detect_parts.m)):** Queue-based connected component extraction.
  - **Dual-Threshold Denoising ([myremovecom.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA2/codes/functions/myremovecom.m)):** Separates small noise ($\text{area} < 300\,\text{px}$) and large background frames ($\text{area} \ge 2300\,\text{px}$) to isolate characters via subtraction.
  - **Segmentation ([mysegmentation.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA2/codes/functions/mysegmentation.m)):** Custom object labeling replacing `bwlabel`.
- **2D Cross-Correlation Matching:** Matches extracted character segments resized to $42 \times 24$ against `Map Set/` templates using normalized cross-correlation (`corr2`).

### 2. Part 2: Persian License Plate OCR
- **Custom Persian Map Set (`PersianMapSet/`):** Created a dedicated reference library for Persian digits and plate letters.
- **Typographic Normalization:** Resized character candidates to $100 \times 80$ pixels to preserve distinctive Persian typographic features (dots and curves) during `corr2` evaluation.

### 3. Part 3: Front-Vehicle Plate Localization & Recognition
- **Anchor-Based Feature Matching:** Uses the blue national badge on the left margin of Iranian plates as an anchor template.
- **Multi-Channel Cross-Correlation:** Computes `normxcorr2` across R, G, and B channels independently and averages them to identify the global correlation peak.
- **Geometric Bounding Box & OCR:** Projects a standard plate aspect ratio window ($7 \times \text{Height}, 2 \times \text{Height}$) from the anchor, crops the plate with `imcrop`, and feeds it into the recognition pipeline.

### 4. Part 4: Vehicle Speed Estimation via Video Processing
- **Spatiotemporal Tracking:** Tracks plate position across consecutive video frames using 2D cross-correlation peak shifts $(\Delta x, \Delta y)$.
- **Metric Calibration & Velocity:** Calibrates pixel displacement against standard physical plate width ($52\,\text{cm}$) to calculate vehicle speed: $v = \frac{\Delta d}{\Delta t}$.

---

## 🎯 Key Results & Technical Insights

- **Scratch BFS vs. Built-in Functions:** The custom 8-connected BFS queue algorithm (`detect_parts.m`) accurately extracted all connected components without needing MATLAB's Image Processing Toolbox primitives (`bwlabel`, `bwareaopen`).
- **Dual-Threshold Frame Subtraction:** Subtracting the large background frame from the filtered image ($\text{characters} = \text{filtered} - \text{background}$) effectively decoupled alphanumeric characters from enclosing plate borders.
- **Anchor Template Matching:** Multi-spectral cross-correlation on the blue flag badge proved robust for plate localization across different vehicle models, grilles, and lighting conditions.
- **Cross-Correlation Confidence:** 2D normalized cross-correlation (`corr2`) reliably distinguished similar characters when normalized to consistent aspect ratios.

---

## 🚀 How to Run

```matlab
cd('CA2/codes');
addpath('functions');

% English Plate Recognition
run('p1.m');

% Persian Plate Recognition
run('p2.m');

% Vehicle Front Plate Detection & OCR
run('p3.m');
```
