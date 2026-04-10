# 🚀 8-Point Complex FFT Processor on Nexys A7 FPGA

Turn your Nexys A7 into a real-time frequency analyzer. This project features a 16-bit Complex FFT processor designed in VHDL that transforms complex "corkscrew" time-domain signals into the frequency domain with hardware-level precision.

![Timing Simulation](images/fft_timing_simulation_waveforms.png)

## 📋 Project Overview
This implementation features a hardware-accelerated **8-Point Fast Fourier Transform (FFT)** engine on a Xilinx Artix-7 FPGA. Unlike software-based FFTs, this processor utilizes a dedicated data-path and a Finite State Machine (FSM) to achieve deterministic, low-latency frequency analysis.

### Key Features:
- **Architecture**: Radix-2 Decimation-in-Time (DIT) algorithm.
- **Complex Handling**: Simultaneous processing of Real ($Re$) and Imaginary ($Im$) components.
- **Hardware Interfacing**: Real-time signal manipulation via onboard switches and visualization on 7-segment displays.

## 🏗 Hardware Architecture & Verification
The processor is built with a modular VHDL approach, ensuring efficient resource mapping on the Artix-7 fabric.

### Core RTL Hierarchy
The design is split into a dedicated control path (FSM) and a data path (Butterfly units and Memory).
![Full RTL Hierarchy](images/fft_full_rtl_hierarchy.png)

### Control Logic (FSM) & Memory
A robust **Finite State Machine** manages the multi-stage butterfly execution and dual-port memory addressing, ensuring synchronized data flow between stages.
![FSM Logic](images/fft_control_fsm_logic.png)
![Dual Port Memory Map](images/fft_dual_port_memory_map.png)

## 🛠 Hardware Interfacing (Nexys A7)

### 1. Input Mapping (Time Domain)
The 16 switches represent 8 samples ($x(0)$ to $x(7)$), split into two channels:
* **Switches [7:0] (Real Part):** Controls the amplitude of the "In-phase" (Cosine) component.
* **Switches [15:8] (Imaginary Part):** Controls the amplitude of the "Quadrature" (Sine) component.
* **Button (btnC):** Sampling trigger to latch switch states into the FFT core.

### 2. Output Visualization
Results are displayed on the **8-digit 7-segment display** in Hexadecimal format:
* **Left 4 Digits:** Imaginary part of the frequency bin ($Bin_k$).
* **Right 4 Digits:** Real part of the frequency bin ($Bin_k$).

## 📐 Mathematical Concept: The "Corkscrew" Signal
The processor handles **Analytic Signals**. By defining both Real and Imaginary inputs, the user creates a signal that rotates in the complex plane. The FFT calculates the energy and phase of this 3D rotation, providing a deeper analysis than real-only transforms.

## 📊 Signal Analysis Examples (Bin 0)

| Signal Type | Switches [7:0] | Description | Hex Output (Bin 0) |
| :--- | :--- | :--- | :--- |
| **Step Signal** | `1111 0000` | 4 samples ON, 4 samples OFF | `0000 0004` |
| **Unit Impulse** | `0000 0001` | Only $t=0$ is active | `0000 0001` |
| **Full DC** | `1111 1111` | All 8 samples are active | `0000 0008` |
| **High Freq** | `1010 1010` | Rapid oscillation | `0000 0004` |

## 📂 Repository Structure
- `/src`: VHDL source files (Top module, FFT Core, Butterfly units, 7-Segment Driver).
- `/sim`: Testbenches for functional verification.
- `/constraints`: `.xdc` file for Nexys A7-100T.
- `/images`: RTL Schematics and Simulation waveforms.

## 🚀 Getting Started
1. Open Xilinx Vivado and source the files in the `/src` directory.
2. Run the **Behavioral Simulation** to verify the FFT butterfly stages.
3. Synthesize and Program the Nexys A7 board.
4. Toggle the switches and press **btnC** to see the frequency domain transformation in real-time.
