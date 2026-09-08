# Computer Assignment 5: Fourier Analysis, Spectral Resolution & M-ary Frequency Shift Keying (FSK)

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Assignment](https://img.shields.io/badge/Assignment-CA%20%235-107C41?style=for-the-badge)](#)
[![Domain](https://img.shields.io/badge/Domain-Fourier%20Analysis%20%26%20FSK-purple?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical & Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Overview

This computer assignment focuses on **Fourier Transform Fundamentals**, **Spectral Resolution Limits**, and **Frequency Shift Keying (M-FSK)** modulation and demodulation in MATLAB:
1. **Fourier Spectral Analysis:** Sampling relationships, discrete frequency grids via `fftshift(fft(x))`, and experimental proof that frequency resolution is bounded by observation window duration ($\delta f = 1/T$).
2. **Multi-Tone FSK Communication:** Digital baseband modulation mapping bit streams into orthogonal carrier frequencies, paired with non-coherent FFT peak-detection demodulation and AWGN channel stress-testing.

---

## 📁 Directory Structure

```text
CA5/
├── functions/
│   ├── create_mapset.m           # 32-character to 5-bit binary dictionary generator
│   ├── coding_freq.m             # Multi-frequency FSK modulator
│   └── decoding_freq.m           # FFT spectral peak detection demodulator
├── codes.m                       # Complete runner script (resolution tests, FSK & AWGN benchmarks)
├── ca5.pdf                       # Official assignment description
├── Signal&Systems_CA5_Report_810102530.pdf  # Technical project report
└── README.md                     # Project documentation
```

---

## 🔬 Core Implementations

### 1. Part 1: Fourier Analysis & Frequency Resolution Limits
- **Discrete Frequency Axis Formulation:**
  For $N$ samples sampled at $f_s$ over duration $T = N / f_s$, the frequency axis spans:
  $$f \in \left[-\frac{f_s}{2}, \, \frac{f_s}{2} - \frac{f_s}{N}\right], \quad \Delta f = \frac{f_s}{N} = \frac{1}{T}$$
- **Resolution Limit Demonstration:**
  - When tone separation exceeds resolution ($\Delta f > 1/T$, e.g., $5\,\text{Hz}$ and $8\,\text{Hz}$ with $T = 1\,\text{s}$), the FFT clearly resolves two distinct peaks.
  - When tone separation is smaller than resolution ($\Delta f < 1/T$, e.g., $5\,\text{Hz}$ and $5.1\,\text{Hz}$ with $T = 1\,\text{s}$), the peaks merge into a single unresolved spectral lobe.
- **Harmonic Signals & Phase Recovery:**
  - $x_1(t) = \cos(10\pi t)$: Correctly yields symmetric impulses at $\pm 5\,\text{Hz}$.
  - $x_2(t) = \cos(30\pi t + \pi/4)$: Accurately extracts magnitude peaks at $\pm 15\,\text{Hz}$ and recovers phase $\pm \pi/4$ after numerical thresholding (`tol = 1e-6`).

### 2. Part 2: M-ary Frequency Shift Keying (M-FSK)
- **Frequency Modulator ([coding_freq.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA5/functions/coding_freq.m)):**
  - Encodes text into 5-bit codewords using [create_mapset.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA5/functions/create_mapset.m).
  - Groups stream into $R_b$-bit symbols and allocates orthogonal tone frequencies within the positive band $(0, f_s/2)$:
    $$f_k = k \cdot f_{\text{step}} + \text{offset}, \quad k \in \{0, \dots, 2^{R_b} - 1\}$$
  - Tested for $R_b = 1\,\text{bps}$ (binary FSK) and $R_b = 5\,\text{bps}$ (32-ary FSK transmitting a full character per second).
- **Non-Coherent FFT Peak Demodulator ([decoding_freq.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA5/functions/decoding_freq.m)):**
  - Evaluates 1-second segment spectra via $Y(f) = |\text{fftshift}(\text{fft}(s))|$.
  - Detects dominant carrier: $\hat{f} = \arg\max_f Y(f)$ and converts frequency index back to binary bits.
- **AWGN Robustness Sweep:**
  - Injected white Gaussian noise with standard deviations $\sigma \in [0.05, 5.0]$ to evaluate detection breakdown.

---

## 🎯 Key Results & Technical Insights

- **Sampling vs. Resolution Invariance:**
  Increasing sampling rate $f_s$ widens the observable frequency range $[-\frac{f_s}{2}, \frac{f_s}{2}]$ (Nyquist bandwidth), but does **not** improve frequency resolution $\delta f$. Resolution is strictly governed by the physical observation time $T$ ($\delta f = 1/T$).
- **Noise Immunity Advantage of FSK over ASK:**
  Unlike Amplitude Shift Keying (ASK), which depends on tight amplitude decision thresholds that degrade as levels increase, FSK encodes data into orthogonal frequency coordinates. Detection relies on spectral peak locations, rendering FSK significantly more resilient to additive amplitude noise under identical channel conditions.
- **Empirical Noise Threshold:**
  Both 1 bps and 5 bps FSK transmissions remained fully decodable up to noise levels of $\sigma \approx 1.4$, demonstrating strong robustness against channel corruption.

---

## 🚀 How to Run

```matlab
cd('CA5');
addpath('functions');

% Run resolution experiments, harmonic tests & FSK simulations
run('codes.m');
```
