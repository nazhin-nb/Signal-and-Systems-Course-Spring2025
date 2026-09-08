# Computer Assignment 3: LSB Steganography, Nonlinear Optimization, ML Classification & Signal Convolution

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Assignment](https://img.shields.io/badge/Assignment-CA%20%233-107C41?style=for-the-badge)](#)
[![Domain](https://img.shields.io/badge/Domain-Steganography%20%26%20Optimization-purple?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical & Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Overview

This computer assignment covers four applied signal processing and computational topics in MATLAB:
1. **Adaptive Image Steganography:** Texture-aware Least Significant Bit (LSB) embedding and extraction in high-variance image blocks.
2. **Nonlinear Model Fitting & Optimization:** Comparative evaluation of Exhaustive Grid Search, Multi-Resolution Search, and Analytical Gradient Descent on a sinusoidal loss surface.
3. **Medical Data Classification:** Training and evaluation of a Linear SVM classifier for diabetes diagnosis with feature importance ranking.
4. **Continuous-Time Signal Convolution:** Verification of convolution algebra and output waveforms across piecewise signal pairs.

---

## 📁 Directory Structure

```text
CA3/
├── codes/
│   ├── functions/
│   │   ├── blocking_image.m      # Image partitioning & variance-based block sorting (5x5 blocks)
│   │   ├── coding.m              # Texture-guided LSB bit embedding function
│   │   └── decoding.m            # Blind message extraction from high-variance blocks
│   ├── DataFit.mat               # Noisy sinusoidal observations x and y for curve fitting
│   ├── diabetes-training.csv     # Training dataset (600 instances, 6 features + target)
│   ├── diabetes-validation.csv   # Unseen test dataset (100 instances)
│   ├── flower.jpg                # Carrier cover image for steganography
│   ├── p1.m                      # Steganography pipeline (encoding, visual check, decoding)
│   ├── p2.m                      # Optimization algorithms benchmark (Grid, Coarse-to-Fine, Gradient Descent)
│   ├── p3.m                      # Machine learning training & validation accuracy evaluation
│   └── p4.m                      # Optimization runner script
├── ca3.pdf                       # Official assignment description
├── report/
│   └── ca3-report-810102530.pdf  # Technical project report
└── README.md                     # Project documentation
```

---

## 🔬 Core Implementations

### 1. Part 1: Variance-Adaptive LSB Steganography
- **Symbol Mapping:** Encodes 32 standard alphanumeric and punctuation characters into 5-bit words (`dec2bin(i-1, 5)`), using `;` as the termination delimiter.
- **Texture-Guided Block Selection ([blocking_image.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA3/codes/functions/blocking_image.m)):** Decomposes the cover image into $5 \times 5$ blocks, calculates block-wise variance $\sigma^2$, and sorts blocks in descending order. Embedding into busy/high-variance areas ensures high imperceptibility.
- **LSB Embedding & Blind Extraction ([coding.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA3/codes/functions/coding.m) / [decoding.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA3/codes/functions/decoding.m)):**
  Replaces the least significant bit of cover pixels with message bits. The decoder replicates the deterministic variance ranking to extract bits sequentially until the `;` delimiter is reached.

### 2. Part 2: Nonlinear Model Parameter Estimation
Fits the nonlinear model $y_i = a_0 \sin(\omega_0 x_i + \varphi_0)$ by minimizing the sum of squared errors $f(a, \omega, \varphi) = \sum_{i=1}^N (y_i - a \sin(\omega x_i + \varphi))^2$:
- **Exhaustive Grid Search:** Evaluates full parameter space ($100 \times 100 \times 200$ combinations). Guaranteed global optimum but computationally expensive.
- **Multi-Resolution Search:** Coarse search with 10x larger step sizes followed by refined fine-grid search within the localized candidate neighborhood.
- **Gradient Descent:** Iteratively updates parameter vector $\mathbf{z} = [a, \omega, \varphi]^T$ via analytical partial derivatives:
  $$\mathbf{z}^{(k+1)} = \mathbf{z}^{(k)} - \mu \nabla f(\mathbf{z}^{(k)})$$
  Stopping criteria: gradient norm $\|\nabla f\| < 10^{-5}$ or parameter update change $\|\Delta \mathbf{z}\| < 10^{-5}$.

### 3. Part 3: Supervised Classification on Medical Data
- **Linear SVM Modeling:** Trained on `diabetes-training.csv` (6 clinical features, 600 records) using MATLAB's Classification Learner.
- **Feature Importance Analysis:** Evaluated isolated single-feature predictive accuracy across all 6 features to quantify correlation with the diabetic outcome.
- **Model Deployment & Evaluation:** Exported model evaluated via `predictFcn` on training data and unseen test samples (`diabetes-validation.csv`).

### 4. Part 4: Piecewise Signal Convolution
- Synthesized and analyzed continuous-time signals: ramp $a(t) = t$, inverted ramp $b(t) = 1-t$, and pulse $c(t) = 0.5$ over $[0, 1)$.
- Computed all $3 \times 3$ pairwise convolutions using `conv(..., 'same') * dt`, verifying commutativity ($x * y = y * x$) and piecewise polynomial transitions.

---

## 🎯 Key Results & Technical Insights

- **Visual Imperceptibility vs. Noise Sensitivity:** Hiding LSB bits inside high-variance textures leaves the carrier image visually indistinguishable from the original. However, LSB encoding is vulnerable to transmission noise in texture regions, which can corrupt bit values or the stopping flag.
- **Multi-Resolution Efficiency:** Coarse-to-Fine multi-resolution search matched the exact parameter accuracy of exhaustive search while reducing execution runtime by over an order of magnitude.
- **Non-Convex Loss Surface & Local Minima:** The sinusoidal error surface contains numerous local minima. Gradient Descent converges rapidly when initialized near the basin of attraction, but fails on poor initializations, demonstrating the necessity of global or hybrid search strategies.
- **Clinical Feature Dominance:** Single-feature experiments demonstrated that **Glucose Level** and **BMI (Body Mass Index)** have the highest individual predictive power for diabetes classification.

---

## 🚀 How to Run

```matlab
cd('CA3/codes');
addpath('functions');

% 1. Run LSB Steganography Pipeline
run('p1.m');

% 2. Run Nonlinear Curve Fitting & Optimization Benchmark
run('p2.m');

% 3. Run Classification Accuracy Evaluation
run('p3.m');
```
