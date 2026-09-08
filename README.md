# Signals and Systems — Spring 2025

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Simulink](https://img.shields.io/badge/Simulink-Enabled-orange?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Institution](https://img.shields.io/badge/University%20of%20Tehran-ECE-red?style=for-the-badge)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](./LICENSE)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical and Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Repository Overview

This repository contains the complete suite of **7 Computer Assignments (CAs)**, MATLAB source implementations, Simulink dynamic models, and technical reports for the **Signals and Systems** course. The projects bridge theoretical signal processing concepts with real-world computational applications, including 2D computer vision, digital communications, radar tracking, optimization, and control system modeling.

---

## 📑 Assignments Summary

| Assignment | Domain & Topic | Primary Methods / Algorithms | Documentation |
| :---: | :--- | :--- | :---: |
| **CA1** | System Identification & Radar Ranging | Ordinary Least Squares (OLS), Cross-Correlation, Monte Carlo AWGN sweep | [README.md](./CA1/README.md) |
| **CA2** | 2D Signal Processing & ANPR | Custom 8-connected BFS segmentation, Morphological filtering, 2D `corr2` OCR | [README.md](./CA2/README.md) |
| **CA3** | Steganography, Optimization & ML | Texture-guided LSB hiding, Multi-Resolution search, Gradient Descent, Linear SVM | [README.md](./CA3/README.md) |
| **CA4** | Digital Baseband Communication (ASK) | M-ary ASK modulation, Matched filter correlation receiver, Noise margin analysis | [README.md](./CA4/README.md) |
| **CA5** | Spectral Analysis & FSK Modulation | FFT frequency resolution limits ($\delta f = 1/T$), Orthogonal M-ary FSK | [README.md](./CA5/README.md) |
| **CA6** | Doppler Radar & Audio Synthesis | Doppler velocimetry, Rayleigh resolution limits, Sinusoidal melody synthesis | [README.md](./CA6/README.md) |
| **CA7** | Laplace Domain Systems & Simulink | RLC circuits, Vehicle suspension damping regimes, Unilateral Laplace & Simulink | [README.md](./CA7/README.md) |

---

## 🔬 Highlights of Completed Work

### [CA1: System Modeling & Radar Ranging](./CA1/README.md)
- **Least Squares Identification:** Analytical derivation and implementation of the Normal Equation ($\boldsymbol{\theta} = (\mathbf{A}^T \mathbf{A})^{-1} \mathbf{A}^T \mathbf{y}$) to extract gain $\alpha$ and offset $\beta$ from noisy linear systems.
- **Radar Target Detection:** Simulated pulse propagation delay ($t_d = 2R/c$) and recovered target distance ($R = 450\,\text{m}$) via sliding cross-correlation template matching, tracking noise tolerance with Monte Carlo simulations.

### [CA2: 2D Signal Processing & Automatic Plate Recognition (ANPR)](./CA2/README.md)
- **From-Scratch Primitives:** Queue-based 8-connectivity Breadth-First Search (BFS) component labeling (`detect_parts.m`) and dual-threshold noise/frame subtraction, replacing built-in toolbox functions.
- **English & Persian OCR:** Template matching using normalized 2D cross-correlation (`corr2`) with dedicated character libraries.
- **Vehicle Localization & Speed Modeling:** Multi-channel RGB correlation on blue badge anchor points to crop plates from full vehicle photos; spatiotemporal displacement tracking for velocity estimation.

### [CA3: LSB Steganography, Nonlinear Optimization & ML](./CA3/README.md)
- **Texture-Adaptive Steganography:** Cover image decomposition into $5 \times 5$ blocks; variance ranking to hide 5-bit character codewords imperceptibly inside high-variance textures.
- **Nonlinear Model Optimization:** Benchmark of Exhaustive Grid Search, Multi-Resolution Coarse-to-Fine Search (10x speedup), and Analytical Gradient Descent on a non-convex sinusoidal error surface.
- **Supervised Clinical Diagnosis:** Feature importance evaluation on diabetes data showing Glucose and BMI provide the strongest predictive accuracy.

### [CA4: Multi-Level ASK Modulation & AWGN Channel](./CA4/README.md)
- **M-ary ASK Modulation:** Synthesizing sinusoidal bursts for 1, 2, and 3 bps with peak amplitude constraints ($M \in \{2, 4, 8\}$).
- **Matched Filter Demodulation:** Synchronous correlation against reference template $2\sin(2\pi t)$ with Euclidean midpoint decision thresholds.
- **Trade-Off Analysis:** Demonstrates that increasing bit rate reduces constellation Euclidean distance ($\Delta A$), causing exponential sensitivity to channel noise.

### [CA5: Spectral Analysis & M-ary FSK Modulation](./CA5/README.md)
- **Resolution Limit Invariance:** Proved that frequency resolution $\delta f$ is strictly determined by observation window length ($1/T$) rather than sampling frequency $f_s$.
- **Orthogonal M-FSK System:** Tone allocation across positive spectrum and non-coherent FFT peak demodulation ($\arg\max |Y(f)|$).
- **Modulation Comparison:** Verified FSK's superior noise immunity over ASK under equal peak power constraints.

### [CA6: Doppler Radar Tracking & Audio Synthesis](./CA6/README.md)
- **Doppler Velocimetry & Ranging:** Single and multi-target tracking; extracted velocities from Doppler frequency shifts ($f_d = \beta V$) and ranges from phase angles.
- **Resolution & Sensitivity Limits:** Identified asymmetric noise vulnerability (phase-derived range degrades at $\sigma = 0.01$ while magnitude-derived velocity persists to $\sigma \approx 0.31$); established minimum resolvable speed difference ($\Delta V > 12\,\text{km/h}$).
- **Harmonic Melody Synthesis:** Audio waveform generation and WAV file rendering ("Twinkle, Twinkle, Little Star").

### [CA7: Laplace Transform & Simulink Modeling](./CA7/README.md)
- **RLC Circuit Simulation:** State-space block diagram in Simulink verifying 2nd-order step responses against analytical Laplace solutions.
- **Automotive Suspension Dynamics:** Evaluated mass-spring-damper responses across undamped ($B = 0$), critically damped ($B = 2$, optimal ride comfort), and overdamped ($B = 100$) regimes.
- **Non-Zero Initial Conditions:** Solved differential equations via unilateral Laplace transform, cleanly separating Zero-Input Response (ZIR) from Zero-State Response (ZSR).

---

## 📁 Repository Structure

```text
Signal-and-Systems-Course-Spring2025/
├── CA1/                          # System parameter estimation (OLS) & radar cross-correlation
├── CA2/                          # 2D signal processing, ANPR OCR & vehicle localization
├── CA3/                          # LSB steganography, optimization benchmarks & SVM classification
├── CA4/                          # Multi-level ASK modulation & AWGN channel matched filtering
├── CA5/                          # Fourier spectral resolution & orthogonal M-ary FSK communication
├── CA6/                          # Doppler radar velocity/range tracking & audio melody synthesis
├── CA7/                          # Laplace transform, suspension dynamics & Simulink models
├── LICENSE                       # MIT License
└── README.md                     # Main course documentation
```

---

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/nazhin-nb/Signal-and-Systems-Course-Spring2025.git
   cd Signal-and-Systems-Course-Spring2025
   ```
2. Open **MATLAB** (R2021a or newer recommended).
3. Navigate to any assignment directory (`CA1/` through `CA7/`) and refer to its individual `README.md` for specific script execution instructions.