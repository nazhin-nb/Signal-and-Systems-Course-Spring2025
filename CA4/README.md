# Computer Assignment 4: Multi-Level ASK Modulation, Correlation Detection & AWGN Channel Analysis

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Assignment](https://img.shields.io/badge/Assignment-CA%20%234-107C41?style=for-the-badge)](#)
[![Domain](https://img.shields.io/badge/Domain-Digital%20Communications%20%26%20ASK-purple?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical & Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Overview

This project explores digital baseband transmission over AWGN channels using **Multi-Level Amplitude Shift Keying (M-ASK / PAM)** and synchronous **Correlation / Matched Filter Detection** in MATLAB. It quantifies the fundamental communication trade-off between spectral efficiency (bit rate) and noise margin under fixed peak transmit power constraints.

---

## 📁 Directory Structure

```text
CA4/
├── Signal&Systems_CA4_Codes_810102530/
│   ├── functions/
│   │   ├── create_mapset.m       # 32-character to 5-bit binary dictionary generator
│   │   ├── coding_amp.m          # M-ASK waveform modulator for arbitrary bit rates
│   │   └── decoding_amp.m        # Correlation receiver & midpoint threshold demodulator
│   └── codes.m                   # Full simulation runner (modulation, AWGN sweep, decoding)
├── ca4.pdf                       # Official assignment description
├── Signal&Systems_CA4_Report_810102530.pdf  # Technical project report
└── README.md                     # Project documentation
```

---

## 🔬 Core Implementations

### 1. Symbol Mapping & Modulation Pipeline
- **Binary Codebook ([create_mapset.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA4/Signal&Systems_CA4_Codes_810102530/functions/create_mapset.m)):**
  Maps 32 alphanumeric characters and punctuation symbols to unique 5-bit binary codewords using `dec2bin(i-1, 5)`.
- **M-ASK Waveform Synthesis ([coding_amp.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA4/Signal&Systems_CA4_Codes_810102530/functions/coding_amp.m)):**
  - Groups binary stream into symbols of length $R_b \in \{1, 2, 3\}$ bits/sec ($M = 2^{R_b}$ constellation levels).
  - Normalizes amplitudes to $[0, 1]$ under a peak amplitude constraint:
    $$A_k = \frac{k}{M - 1}, \quad k \in \{0, 1, \dots, M-1\}$$
  - Synthesizes 1-second sinusoidal symbol bursts at sampling frequency $f_s = 100\,\text{Hz}$:
    $$s(t) = A_k \sin(2\pi t), \quad t \in [0, 1)\,\text{s}$$

### 2. Synchronous Correlation Detection
- **Matched Filter Demodulation ([decoding_amp.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA4/Signal&Systems_CA4_Codes_810102530/functions/decoding_amp.m)):**
  Evaluates discrete cross-correlation against a synchronized reference template $r(t) = 2\sin(2\pi t)$:
  $$\rho = \frac{1}{f_s} \sum_{n=1}^{100} s_{\text{recv}}[n] \cdot 2\sin(2\pi n / f_s) \approx A_k$$
- **Optimal Decision Thresholds:**
  Places decision boundaries midway between adjacent constellation amplitudes:
  $$\tau_k = \frac{2k - 1}{2(M - 1)}, \quad k = 1, \dots, M-1$$
  - $R_b = 1\,\text{bps}$ ($M=2$): $\tau = 0.5$
  - $R_b = 2\,\text{bps}$ ($M=4$): $\tau \in \{1/6, 3/6, 5/6\}$
  - $R_b = 3\,\text{bps}$ ($M=8$): $\tau \in \{1/14, 3/14, \dots, 13/14\}$

### 3. AWGN Channel & Noise Robustness Benchmarking
- Injected zero-mean Additive White Gaussian Noise $w(t) \sim \mathcal{N}(0, \sigma^2)$ across a spectrum of standard deviations ($\sigma \in [0.01, 5.0]$).
- Tracked bit error degradation and message corruption thresholds across each bit rate setting.

---

## 🎯 Key Results & Technical Insights

- **Bit Rate vs. Noise Margin Trade-Off:**
  As bit rate increases from 1 to 3 bps with peak amplitude capped at 1, the Euclidean distance between adjacent signal levels shrinks from $\Delta A = 1.0$ (1 bps) down to $\Delta A = 0.333$ (2 bps) and $\Delta A = 0.143$ (3 bps). Consequently, higher bit rates exhibit substantially higher sensitivity to noise.
- **Empirical Breakdown Thresholds:**
  - $R_b = 1\,\text{bps}$: Tolerates large noise amplitudes up to $\sigma \approx 2.0$ with accurate recovery.
  - $R_b = 2\,\text{bps}$: Reliable up to $\sigma \approx 0.5$; begins failing as noise peaks cross threshold spacing $\Delta \tau \approx 0.167$.
  - $R_b = 3\,\text{bps}$: Highly vulnerable; degrades significantly when $\sigma > 0.3$.
- **Transmit Power Scaling:**
  To maintain a constant Bit Error Rate (BER) while increasing transmission rate, peak transmit power must scale with $M^2$, reinforcing that power efficiency and spectral efficiency are inherently coupled.
- **Receiver Gain Invariance:**
  Scaling the correlation template amplitude (e.g., using $10\sin(2\pi t)$ instead of $2\sin(2\pi t)$) amplifies signal and noise equally, yielding zero gain in effective SNR or detection accuracy.

---

## 🚀 How to Run

```matlab
cd('CA4/Signal&Systems_CA4_Codes_810102530');
addpath('functions');

% Run full ASK simulation (modulate, add AWGN, decode & benchmark)
run('codes.m');
```
