# Computer Assignment 1: Introduction to MATLAB, System Modeling & Radar Signal Processing

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Assignment](https://img.shields.io/badge/Assignment-CA%20%231-107C41?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical & Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Overview

This assignment covers foundational computational concepts in **Signals and Systems** using MATLAB, divided into three key areas:
1. **MATLAB Fundamentals:** Matrix manipulation, vectorization, indexing, and multi-signal visualization.
2. **System Parameter Estimation:** Modeling noisy linear systems and deriving parameters $(\alpha, \beta)$ using Ordinary Least Squares (OLS) regression.
3. **Radar Ranging & Signal Detection:** Simulating pulse propagation, round-trip echo delay, and estimating target distance via **Template Matching / Cross-Correlation** under varying AWGN noise conditions.

---

## 📁 Directory Structure

```text
CA1/
├── codes/
│   ├── part1/
│   │   ├── shortProblems.m       # Basic operations, matrices, indexing & condition filtering
│   │   └── twolinePlot.m         # Customized plotting of sine and cosine waveforms
│   ├── part2/
│   │   ├── Part2.m               # Analysis of linear input-output system with data visualization
│   │   ├── p2_4.m                # Closed-form Least Squares regression function: [alpha, beta] = p2_4(x, y)
│   │   ├── p2_4_checking.m       # Function verification on clean vs. noisy synthetic data
│   │   └── p2.mat                # Dataset containing time vector t, input x, and noisy output y
│   └── part3/
│       ├── part3.m               # Radar pulse generation, delay extraction & Monte Carlo noise sweep
│       └── p3_corfunc.m          # Custom sliding cross-correlation / template matching algorithm
├── ca1.pdf                       # Official assignment description
├── p2.mat                        # Root dataset file for Part 2
├── report.pdf                    # Complete Persian technical project report
└── README.md                     # Project documentation
```

---

## 🔬 Key Modules & Implementation

### 1. Part 1: MATLAB Basics & Visualization
- **Data Types & Matrices:** Constructed diagonal, random, special matrices (`ones`, `nan`), and demonstrated logical indexing (`r(r < 0.5) = 0`).
- **Signal Plotting (`twolinePlot.m`):** Generated dual waveform plot of $\sin(t)$ and $\cos(t)$ over $[0, 2\pi]$ with custom styling, line formats, labels, and limits.

---

### 2. Part 2: Linear System Parameter Estimation
Models a memoryless linear system corrupted by noise:
$$y(t) = \alpha \cdot x(t) + \beta + \eta(t)$$

- **Dataset Exploration:** Loaded `p2.mat` ($N=1001$ samples over $t \in [0, 1]\,\text{s}$). A scatter plot of $x(t)$ vs. $y(t)$ highlights a linear trend with additive noise.
- **Ordinary Least Squares (OLS) Implementation (`p2_4.m`):** Formulated in matrix form $\mathbf{y} = \mathbf{A} \boldsymbol{\theta}$ with $\mathbf{A} = [\mathbf{x} \quad \mathbf{1}]$ and solved via the Normal Equation:
  $$\boldsymbol{\theta} = \begin{bmatrix} \alpha \\ \beta \end{bmatrix} = (\mathbf{A}^T \mathbf{A})^{-1} \mathbf{A}^T \mathbf{y}$$
- **Validation (`p2_4_checking.m`):** Tested on synthetic targets ($\alpha=2.5, \beta=-1.0$). Recovered exact parameters in noiseless conditions and demonstrated robust estimation under additive Gaussian noise, cross-verified with MATLAB's `cftool`.

---

### 3. Part 3: Radar Target Detection & Ranging
Calculates target distance by transmitting a pulse and correlating the delayed, attenuated echo.

- **Signal Specifications:**
  - Sampling interval: $t_s = 1\,\text{ns}$ ($f_s = 1\,\text{GHz}$)
  - Observation window: $T = 10\,\mu\text{s}$
  - Pulse width: $\tau = 1\,\mu\text{s}$
  - Target distance: $R = 450\,\text{m}$ ($c = 3 \times 10^8\,\text{m/s}$)
- **Propagation Model:**
  $$t_d = \frac{2R}{c} = \frac{2 \times 450}{3 \times 10^8} = 3\,\mu\text{s}$$
  $$x_2(t) = \alpha \cdot x_1(t - t_d), \quad (\alpha = 0.5)$$
- **Template Matching / Cross-Correlation (`p3_corfunc.m`):** Slides a rectangular template window over the received signal:
  $$\rho(i) = \sum_{k=0}^{\tau / t_s - 1} x_2(i + k)$$
  The peak index yields delay estimate $\hat{t}_d = \arg\max_t \rho(t)$, giving distance $\hat{R} = \frac{c \cdot \hat{t}_d}{2} = 450.00\,\text{m}$.
- **Monte Carlo Noise Sensitivity Analysis:** Evaluated estimator performance against AWGN noise with step size $0.1$ and $100$ iterations per noise level. Ranging remains stable until average estimation error reaches the stopping threshold ($\ge 10\,\text{m}$).

---

## 📊 Summary of Results

| Problem | Objective | Methodology | Key Output / Accuracy |
| :--- | :--- | :--- | :--- |
| **Part 1** | Language mastery & plotting | Vectorization & Matplotlib-style figures | Verified matrix ops & clean dual waveform plot |
| **Part 2** | Linear model identification | Least Squares / Normal Equation | Exact parameter recovery without noise; minimal error with AWGN |
| **Part 3 (Noiseless)** | Target distance estimation | Cross-correlation peak detection | $\hat{R} = 450.00\,\text{m}$ (Error: $0.00\,\text{m}$) |
| **Part 3 (Noisy)** | Robustness & failure limit | Monte Carlo sweep ($N=100$ trials/step) | Quantified breakdown threshold where error exceeds $10\,\text{m}$ |

---

## 🚀 How to Run

1. Open **MATLAB** (R2021a or newer recommended).
2. Set current working directory to `CA1/codes/<part>`:
   ```matlab
   % Part 1
   run('part1/shortProblems.m');
   run('part1/twolinePlot.m');

   % Part 2
   run('part2/Part2.m');
   run('part2/p2_4_checking.m');

   % Part 3
   run('part3/part3.m');
   ```
