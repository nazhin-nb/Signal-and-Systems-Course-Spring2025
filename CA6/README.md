# Computer Assignment 6: Doppler Radar Target Tracking & Audio Melody Synthesis

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Assignment](https://img.shields.io/badge/Assignment-CA%20%236-107C41?style=for-the-badge)](#)
[![Domain](https://img.shields.io/badge/Domain-Radar%20Signal%20Processing%20%26%20Audio-purple?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical & Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Overview

This computer assignment investigates two applications of **Discrete-Time Fourier Analysis**:
1. **Doppler Radar Ranging & Velocimetry:** Extracting target velocity ($V$) and range ($R$) from reflected echoes via spectral peak detection and phase estimation, with multi-target resolution limits and AWGN sensitivity analysis.
2. **Audio Frequency Synthesis:** Generating musical notes from discrete sinusoids, composing structured melodies with pause intervals, and rendering audio waveforms to WAV files.

---

## 📁 Directory Structure

```text
CA6/
├── CA6-codes/
│   ├── part1_1.m                 # Transmitted radar pulse generation (fc = 5 Hz)
│   ├── part1_2.m                 # Echo synthesis with Doppler shift (fd) and propagation delay (td)
│   ├── part1_3.m                 # FFT-based velocity and distance estimator
│   ├── part1_4.m                 # AWGN noise sweep on radar parameter estimation
│   ├── part1_5.m                 # Multi-target echo superposition synthesis (2 moving targets)
│   ├── part1_6.m                 # Multi-target parameter extraction using maxk spectral peak search
│   ├── p2_1and3.m                # Musical note frequency generation and melody composition
│   ├── p2_2.m                    # Audio synthesis of "Twinkle, Twinkle, Little Star" & WAV export
│   └── mysong.wav                # Synthesized audio file output (8 kHz sampling rate)
├── ca6.pdf                       # Official assignment description
├── CA6-report-810102530.pdf      # Technical project report
└── README.md                     # Project documentation
```

---

## 🔬 Core Implementations

### 1. Part 1: Doppler Radar Velocity & Range Estimation
- **Physical Signal Model:**
  Transmitted signal: $x(t) = \cos(2\pi f_c t)$.  
  Reflected echo affected by Doppler shift $f_d = \beta V$ and propagation delay $t_d = \frac{2R}{c}$:
  $$y(t) = \alpha \cos(2\pi(f_c + f_d)(t - t_d)) = \alpha \cos(2\pi f_{\text{new}} t + \varphi_{\text{new}})$$
  where $f_{\text{new}} = f_c + f_d$ and phase $\varphi_{\text{new}} = -2\pi f_{\text{new}} t_d$.
- **Parameter Extraction ([part1_3.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA6/CA6-codes/part1_3.m)):**
  - Evaluates `fftshift(fft(y))` to locate the dominant spectral peak frequency $f_{\text{new}}$.
  - Computes velocity: $V = \frac{f_{\text{new}} - f_c}{\beta}$.
  - Extracts spectral phase at peak bin to compute target range: $R = \frac{|\varphi|}{2\pi f_{\text{new}} \cdot (2/c)}$.
- **Multi-Target Detection ([part1_6.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA6/CA6-codes/part1_6.m)):**
  - Utilizes `maxk(abs(fourier), 4)` to isolate symmetric spectral lobes for 2 distinct targets.
  - Successfully recovers individual velocities ($V_1 = 180\,\text{km/h}, V_2 = 216\,\text{km/h}$) and distances ($R_1 = 250\,\text{km}, R_2 = 200\,\text{km}$).

### 2. Part 2: Harmonic Audio Synthesis
- **Musical Note Generation:** Synthesizes standard musical frequencies ($C4 = 261.63\,\text{Hz}$ to $C5 = 523.25\,\text{Hz}$) at $f_s = 8000\,\text{Hz}$.
- **Temporal Sequencing & Pauses ([p2_2.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA6/CA6-codes/p2_2.m)):** Concatenates tone bursts ($T_1 = 0.5\,\text{s}, T_2 = 0.25\,\text{s}$) with 200-sample zero-padding pauses to articulate distinct notes for "Twinkle, Twinkle, Little Star".
- **Audio Output:** Plays sound via `sound(melody, Fs)` and exports to `mysong.wav`.

---

## 🎯 Key Results & Technical Insights

- **Asymmetric Noise Sensitivity (Velocity vs. Distance):**
  - **Velocity ($V$)** depends on spectral magnitude peak index and exhibits high resilience, maintaining accurate detection up to noise levels of $\sigma \approx 0.31$.
  - **Distance ($R$)** depends on phase angle $\varphi$, which is extremely susceptible to small perturbations, suffering degradation even at low noise levels ($\sigma = 0.01$).
- **Minimum Resolvable Velocity Difference:**
  Two targets with identical velocity cannot be resolved via FFT because their spectral peaks merge, obscuring individual phases. Separation requires Doppler shift difference to exceed the fundamental Rayleigh frequency resolution:
  $$\Delta f_d > \delta f = \frac{1}{T} = 1\,\text{Hz} \implies \Delta V > \frac{1}{\beta} = 3.33\,\text{m/s} = 12\,\text{km/h}$$
- **Target Count Discovery:**
  For an unknown environment, the number of targets equals half the count of prominent spectral peaks across the two-sided FFT spectrum ($K = N_{\text{peaks}} / 2$).

---

## 🚀 How to Run

```matlab
cd('CA6/CA6-codes');

% 1. Run Single-Target Radar Simulation
run('part1_1.m');
run('part1_2.m');
run('part1_3.m');

% 2. Run Multi-Target Radar Estimator
run('part1_5.m');
run('part1_6.m');

% 3. Run Audio Synthesis & WAV Export
run('p2_2.m');
```
