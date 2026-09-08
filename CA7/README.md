# Computer Assignment 7: Laplace Transform, System Dynamics & Simulink Modeling

[![Course](https://img.shields.io/badge/Course-Signals%20%26%20Systems-0052CC?style=for-the-badge&logo=openaccess&logoColor=white)](#)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-ED8B00?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Simulink](https://img.shields.io/badge/Simulink-Enabled-orange?style=for-the-badge&logo=mathworks&logoColor=white)](#)
[![Assignment](https://img.shields.io/badge/Assignment-CA%20%237-107C41?style=for-the-badge)](#)
[![Domain](https://img.shields.io/badge/Domain-Laplace%20Transform%20%26%20Control-purple?style=for-the-badge)](#)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

> **Author:** Nazhin Nikkhah Bahrami  
> **Student ID:** 810102530  
> **Instructor:** Dr. Akhavan  
> **Institution:** University of Tehran — Department of Electrical & Computer Engineering  
> **Semester:** Spring 2025  

---

## 📌 Overview

This computer assignment focuses on **Continuous-Time System Modeling** using the **Bilateral and Unilateral Laplace Transforms** and **MATLAB / Simulink**:
1. **RLC Circuit Analysis:** Transfer function derivation, state-space block diagram implementation in Simulink, and step response validation.
2. **Vehicle Suspension System Dynamics:** Mass-spring-damper model evaluation under undamped, critically damped, and overdamped regimes to analyze shock absorption and ride comfort.
3. **Unilateral Laplace Transform:** Analytical and symbolic decomposition of differential equations into Zero-Input Response (ZIR) and Zero-State Response (ZSR) under non-zero initial conditions.

---

## 📁 Directory Structure

```text
CA7/
├── codes/
│   ├── plot1.m                   # Analytical step response plot for RLC circuit
│   ├── plot2_1.m                 # Impulse response plot for undamped suspension (B = 0)
│   ├── plot2_2.m                 # Impulse response plot for critically damped suspension (B = 2)
│   ├── plot2_3.m                 # Impulse response plot for overdamped suspension (B = 100)
│   └── p3.m                      # Symbolic ODE solver (dsolve) & analytical verification for non-zero ICs
├── simulink/
│   ├── test1.slx                 # Simulink integrator block diagram for RLC circuit step response
│   ├── test2.slx                 # Simulink model for undamped suspension impulse response
│   └── test3.slx                 # Simulink model for critically damped suspension impulse response
├── ca7.pdf                       # Official assignment description
├── report/
│   └── SS-CA7 report-810102530.pdf # Technical project report
└── README.md                     # Project documentation
```

---

## 🔬 Core Implementations

### 1. Problem 1: Series RLC Circuit Modeling & Step Response
- **Transfer Function Derivation:**
  Applying KVL and capacitor voltage output $y(t) = v_C(t)$ with input $x(t) = v_{\text{in}}(t)$:
  $$H(s) = \frac{Y(s)}{X(s)} = \frac{1/LC}{s^2 + \frac{R}{L}s + \frac{1}{LC}}$$
  For circuit parameters $R = 1\,\Omega, L = 0.25\,\text{H}, C = 4/3\,\text{F}$:
  $$H(s) = \frac{3}{s^2 + 4s + 3} = \frac{3}{(s + 1)(s + 3)}$$
- **Analytical Step Response:**
  $$Y(s) = H(s) \cdot \frac{1}{s} = \frac{1}{s} - \frac{1.5}{s + 1} + \frac{0.5}{s + 3} \implies y(t) = \left(1 - 1.5e^{-t} + 0.5e^{-3t}\right) u(t)$$
- **Simulink Implementation ([test1.slx](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/simulink/test1.slx)):**
  Constructed using pure Integrator (`1/s`), Gain, and Sum blocks. Simulation matches theoretical output from [plot1.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/codes/plot1.m) exactly.

### 2. Problem 2: Vehicle Suspension Dynamics & Damping Regimes
Models vertical chassis displacement $y(t)$ resulting from road disturbance $x(t)$ ($M = K = 1$):
$$\ddot{y}(t) + B \dot{y}(t) + y(t) = B \dot{x}(t) + x(t) \implies H(s) = \frac{Bs + 1}{s^2 + Bs + 1}$$
- **Undamped Regime ($B = 0$):**
  $H(s) = \frac{1}{s^2 + 1} \implies h(t) = \sin(t) u(t)$ ([plot2_1.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/codes/plot2_1.m) & [test2.slx](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/simulink/test2.slx)). Infinite harmonic oscillations without energy dissipation.
- **Critically Damped Regime ($B = 2$):**
  Smallest $B > 0$ yielding real repeated poles at $s = -1$:
  $$H(s) = \frac{2s + 1}{(s + 1)^2} \implies h(t) = (2e^{-t} - te^{-t}) u(t)$$
  ([plot2_2.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/codes/plot2_2.m) & [test3.slx](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/simulink/test3.slx)). Complete suppression of oscillation with rapid decay.
- **Overdamped Regime ($B = 100$):**
  Poles split to $s \approx -100$ and $s \approx -0.01 \implies h(t) \approx 100e^{-100t}$ ([plot2_3.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/codes/plot2_3.m)). Excessive stiffness transmits an abrupt initial acceleration spike to passengers.

### 3. Problem 3: Unilateral Laplace Transform with Non-Zero Initial Conditions
- **Differential Equation:**
  $$\ddot{y}(t) + 3\dot{y}(t) + 2y(t) = 5u(t), \quad y(0^-) = 1, \; \dot{y}(0^-) = 1$$
- **Analytical Decomposition:**
  $$(s^2 + 3s + 2)Y(s) = (s + 4) + \frac{5}{s}$$
  - **Zero-Input Response (ZIR):** $y_{\text{zi}}(t) = (3e^{-t} - 2e^{-2t}) u(t)$
  - **Zero-State Response (ZSR):** $y_{\text{zs}}(t) = (2.5 - 5e^{-t} + 2.5e^{-2t}) u(t)$
  - **Total Response:** $y(t) = \left(2.5 - 2e^{-t} + 0.5e^{-2t}\right) u(t)$
- **Symbolic Verification ([p3.m](file:///d:/Antigravity/Signal-and-Systems-Course-Spring2025/CA7/codes/p3.m)):**
  Verified using MATLAB Symbolic Math Toolbox (`dsolve`), yielding exact matching trajectories.

---

## 🎯 Key Results & Technical Insights

- **Simulink State-Space Equivalence:**
  Integrating feedback loops of $1/s$ blocks in Simulink directly reproduces the differential equations without algebraic loop singularities, fully verifying analytical Laplace solutions.
- **Optimal Suspension Damping:**
  Critical damping ($B = 2$) represents the optimal engineering design for automotive suspensions. It prevents indefinite vibration (undamped $B=0$) while avoiding severe impact shock transmission caused by over-stiffness ($B=100$).
- **Superposition of ZIR and ZSR:**
  The unilateral Laplace transform cleanly separates natural system decay (ZIR governed by initial energy in reactive components) from forced transient behavior (ZSR driven by external inputs), confirming the linearity of LTI system solutions.

---

## 🚀 How to Run

```matlab
cd('CA7/codes');

% 1. Plot RLC Circuit Step Response
run('plot1.m');

% 2. Plot Vehicle Suspension Impulse Responses (Undamped, Critical, Overdamped)
run('plot2_1.m');
run('plot2_2.m');
run('plot2_3.m');

% 3. Run Symbolic ODE Solution & Verification
run('p3.m');

% 4. Open and Simulate Simulink Models
open('../simulink/test1.slx');
open('../simulink/test2.slx');
open('../simulink/test3.slx');
```
