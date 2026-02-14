# NexysA7-Complex-FFT
Turn your Nexys A7 switches into a frequency analyzer. A 16-bit Complex FFT processor that transforms 'corkscrew' time-domain signals into the frequency domain.
# 🚀 8-Point Complex FFT Processor on Nexys A7 FPGA

### **Overview**
This project implements a hardware-accelerated **8-Point Fast Fourier Transform (FFT)** engine on a Xilinx Artix-7 FPGA (Nexys A7-100T). The processor is designed to handle **complex-valued signals** (Re + jIm), transforming discrete time-domain inputs into their frequency-domain components.

By utilizing the onboard switches and 7-segment display, the system provides a real-time visualization of the **DC Component (Bin 0)** of any user-defined complex waveform.



---

## 🛠 Hardware Interfacing

The project uses the physical components of the Nexys A7 board to interact with the FFT core:

### 1. Input Mapping (Time Domain)
We treat the 16 switches as 8 samples ($x(0)$ to $x(7)$), split into Real and Imaginary channels:
* **Switches [7:0] (Real Part):** Controls the amplitude of the "In-phase" (Cosine) component.
* **Switches [15:8] (Imaginary Part):** Controls the amplitude of the "Quadrature" (Sine) component.
* **Central Button (btnC):** Acts as the sampling trigger to latch the switch states into the processor.

### 2. Output Visualization (Frequency Domain)
The results are displayed on the **8-digit 7-segment display** in Hexadecimal format:
* **Left 4 Digits:** Imaginary part of the frequency bin.
* **Right 4 Digits:** Real part of the frequency bin.



---

## 📐 Mathematical Concept: The "Corkscrew" Signal
Unlike simple real-only transforms, this project processes **Analytic Signals**. By providing both Real and Imaginary inputs, the user can define a signal that rotates in the complex plane—much like a **3D Corkscrew**. 
* **Real Switches** define the "Up/Down" projection.
* **Imaginary Switches** define the "Left/Right" projection.
The FFT calculates the energy and phase of this rotation.

---

## 📊 Signal Analysis Examples (Bin 0)

| Signal Type | Switches [7:0] | Description | Hex Output (Bin 0) | Decimal |
| :--- | :--- | :--- | :--- | :--- |
| **Step Signal** | `1111 0000` | 4 samples ON, 4 samples OFF | `0000 0004` | **4** |
| **Unit Impulse** | `0000 0001` | Only $t=0$ is active | `0000 0001` | **1** |
| **Full DC** | `1111 1111` | All 8 samples are active | `0000 0008` | **8** |
| **High Freq** | `1010 1010` | Rapid ON/OFF oscillation | `0000 0004` | **4** |



---

## 🏗 Project Structure
* `/src`: VHDL source files (Top module, FFT Core, 7-Segment Driver).
* `/constraints`: `.xdc` file for Nexys A7 - 100t
