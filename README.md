# 32-bits-MIPS-CPU
This project implements a 32-bit multicycle MIPS processor in VHDL, designed and simulated in Vivado. The CPU follows the classic multicycle architecture described in Patterson & Hennessy, separating instruction execution into multiple FSM-controlled stages to reduce hardware duplication and improve control clarity.

The design includes:

-Full datapath implementation

Finite State Machine (FSM) controller

ALU + ALU control unit

Register file

Memory interface

Automated TCL-based verification framework

Simulation waveform validation

#Multi-cycle Datapath
The CPU is based on the standard multicycle MIPS datapath architecture:

Single ALU reused across cycles

Separate instruction and data phases

Intermediate registers (A, B, ALUOut, MDR)

Sign-extension and shift-left-2 units

PC update logic with PCWrite / PCWriteCond

IorD memory addressing mux

The datapath supports:

R-type instructions (ADD, SUB, AND, OR, SLL, SRA)

I-type instructions (ADDI, ORI, SLTI, LW, SW)

Control flow (BEQ, J)

The multicycle design reduces hardware duplication by:

Sharing ALU for address calculation, arithmetic, and branch comparison

Using FSM-controlled sequencing instead of parallel hardware paths

<img width="1486" height="1222" alt="image" src="https://github.com/user-attachments/assets/16419091-8210-4dab-85ec-98fb51656505" />

#FSM Controller
The control logic is implemented as a finite state machine in control.vhd.

States include:

Instruction Fetch

Instruction Decode / Register Fetch

Memory Address Computation

Memory Access (LW)

Memory Access (SW)

Execution (R-type)

R-type Completion

Branch Completion

Jump Completion

The controller generates the following control signals:

PCWrite

PCWriteCond

IorD

MemRead

MemWrite

IRWrite

MemtoReg

RegDst

RegWrite

ALUSrcA

ALUSrcB

ALUOp

PCSource

Each instruction transitions through multiple states depending on opcode.

Example:

R-type: IF → ID → EX → WB

LW: IF → ID → AddrCalc → MemRead → WB

SW: IF → ID → AddrCalc → MemWrite

<img width="1086" height="1536" alt="image" src="https://github.com/user-attachments/assets/b405ae12-b1b7-4d3d-96ee-669a514f0cc4" />

#Block Design Integration
The CPU is integrated into a Vivado block design that includes:

Zynq Processing System

AXI Interconnect

AXI BRAM Controller

Block Memory Generator

Custom datapath module

The custom datapath is connected to BRAM for instruction/data memory access.

This demonstrates:

AXI-based integration

Memory-mapped CPU execution

Practical FPGA system-level design

<img width="1217" height="423" alt="image" src="https://github.com/user-attachments/assets/fee94639-08d4-4916-822d-9a5ddfdf37f2" />

#Automated Testbench
Verification is handled using a TCL-based simulation framework (CPU_tb.tcl).

The script:

Forces instruction memory contents

Applies reset sequencing

Runs simulation for required cycles

Reads memory outputs

Automatically checks expected values

Tracks number of passed tests (10/10 test cases passing shown below)

<img width="1637" height="875" alt="image" src="https://github.com/user-attachments/assets/c8b53aca-80cb-47ed-bd50-43a555b084e5" />

#Waveform verification
The final waveform screenshot shows correct execution of Test 9:

Memory location /cpu_tb/U_1/mw_U_0ram_table[8]

Value correctly written: 0x00000064

This confirms:

ALU operation correctness

Proper memory write control

Correct state sequencing

Successful end-to-end instruction execution

The waveform demonstrates:

Correct PC progression

Proper register updates

Valid memory write timing

Accurate data path propagation
<img width="660" height="536" alt="image" src="https://github.com/user-attachments/assets/93ff3c18-a15d-494a-8433-ffb54af42484" />

