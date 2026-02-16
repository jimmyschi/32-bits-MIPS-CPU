----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2022 09:24:20 AM
-- Design Name: 
-- Module Name: datapath - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
  Port (Reset, Clock : in std_logic;
        MemoryDataIn : in std_logic_vector(31 downto 0);
        MemoryAddress, MemoryDataOut : out std_logic_vector(31 downto 0);
        MemWrite : out std_logic
    );
end datapath;

architecture Behavioral of datapath is
component Ext is
Port (a : in std_logic_vector(15 downto 0);
        zero_ext : in std_logic;
        r : out std_logic_vector(31 downto 0)
  );
end component;
component Shift_L is 
Port (a: in std_logic_vector(31 downto 0);
        r: out std_logic_vector(31 downto 0)
  );
end component;
component Shift_L2 is
Port (a : in std_logic_vector(25 downto 0);
        r : out std_logic_vector(27 downto 0)
  );
end component;  
-- multiplier is top level from lab3
component Multiplier is
Port (A,B : in std_logic_vector(31 downto 0);
        clk, rst : in std_logic;
        R : out std_logic_vector(63 downto 0);
        done : out std_logic
  );
end component;
component mux1 is
generic(
            k : integer := 5
  );
  Port (a,b : in std_logic_vector(k -1 downto 0);
        sel : in std_logic;
        r : out std_logic_vector(k -1 downto 0)
   );
end component;
component mux2 is 
generic(
            k : integer := 32
  );
  Port (a,b,c,d : in std_logic_vector(k -1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        r : out std_logic_vector(k -1 downto 0)
   );
end component;
component mux3 is
generic(
            k : integer := 32
  );
  Port (a,b : in std_logic_vector(k -1 downto 0);
        sel : in std_logic;
        r : out std_logic_vector(k -1 downto 0)
   );
end component;
component mux4 is 
generic(
            k : integer := 5
  );
  Port (a,b,c,d : in std_logic_vector(k -1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        r : out std_logic_vector(k -1 downto 0)
   );
end component;
component control is
Port (clk, reset : in std_logic;
        IR4 : in std_logic_vector(5 downto 0);
        Op : in std_logic_vector(5 downto 0);
        done : in std_logic;
        shamt_sel : out std_logic_vector(1 downto 0);
        PCWriteCond, PCWrite : out std_logic;
        ALUOp : out std_logic_vector(3 downto 0);
        IorD: out std_logic;
        MemRead : out std_logic;
        MemWrite : out std_logic;
        MemToReg : out std_logic;
        IRWrite : out std_logic;
        ALUSrcA : out std_logic;
        RegWrite : out std_logic;
        RegDest : out std_logic;
        A_en, B_en, ALUOut_en, MemData_en : out std_logic;
        PCSource : out std_logic_vector(1 downto 0); --is this supposed to be 2 bits? 
        ALUSrcB : out std_logic_vector(1 downto 0);   --is this supposed to be 2 bits?
        State_Out : out std_logic_vector(2 downto 0);
        zero_ext : out std_logic
    );
end component;
component Registers is 
Port (clk, rst : in std_logic;
        rd1, rd2, wr : in std_logic_vector(4 downto 0);
        regw : in std_logic;
        data : in std_logic_vector(31 downto 0);
        rd1_out, rd2_out : out std_logic_vector(31 downto 0)
        );
end component;
component Instruction_Reg is
Port (clk, reset : in std_logic;
        MemData : in std_logic_vector(31 downto 0);
        IRWrite: in std_logic;
        IR1 : out std_logic_vector(5 downto 0);
        IR2, IR3 : out std_logic_vector(4 downto 0);
        IR4 : out std_logic_vector(15 downto 0)
  );
end component; 

component ALU is
  Port (A, B : in std_logic_vector(31 downto 0);
        ALUOp : in std_logic_vector(3 downto 0);
        SHAMT : in std_logic_vector(4 downto 0);
        Overflow, Zero : out std_logic;
        R : out std_logic_vector(31 downto 0)
  );
end component;
component ALUOut is
Port (clk, reset : in std_logic;
      sel : in std_logic;
      ALU_Res: in std_logic_vector(31 downto 0);
      Jump_Address : out std_logic_vector(31 downto 0)
  );
end component;
component Mem_Data_Reg is
Port (clk, reset : in std_logic;
      sel : in std_logic;
      a : in std_logic_vector(31 downto 0);
      r : out std_logic_vector(31 downto 0)
);
end component;
component PC is 
Port (clk, reset : in std_logic;
      input : in std_logic_vector(31 downto 0);
        sel : in std_logic;
        output : out std_logic_vector(31 downto 0)
  );
end component;
component B_reg is
  Port (clk, reset : in std_logic;
        sel : in std_logic;
        input : in std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
   );
end component;
component A_reg is
  Port (clk, reset : in std_logic;
        sel : in std_logic;
        input : in std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
   );
end component;
component Mult is
  Port (A,B : in std_logic_vector(31 downto 0);
        clk, rst : in std_logic;
        R : out std_logic_vector(63 downto 0);
        done : out std_logic
  );
end component;
signal PCWriteCond, PCWrite : std_logic;
signal IorD:  std_logic;
signal MemRead : std_logic;
signal MemToReg : std_logic;
signal IRWrite :  std_logic;
signal ALUSrcA :  std_logic;
signal RegWrite :  std_logic;
signal RegDest :  std_logic;
signal PCSource :  std_logic_vector(1 downto 0);
signal ALUOp :  std_logic_vector(3 downto 0);
signal ALUSrcB : std_logic_vector(1 downto 0);

signal addr, dataIn, dataOut : std_logic_vector(31 downto 0);

signal jump_addr : std_logic_vector(31 downto 0);
signal PC_In, PC_out : std_logic_vector(31 downto 0);

signal Write_Reg : std_logic_vector(4 downto 0);
signal Write_data : std_logic_vector(31 downto 0);
signal A, B : std_logic_vector(31 downto 0);
signal A_en, B_en : std_logic;

signal IR1 : std_logic_vector(5 downto 0);
signal IR2, IR3 : std_logic_vector(4 downto 0);
signal IR4 : std_logic_vector(15 downto 0);

signal Memory_Data_Out : std_logic_vector(31 downto 0);
        
signal Extend_Out, Shift_Out : std_logic_vector(31 downto 0);

signal ALU_A, ALU_B, ALU_Result, ALU_Out : std_logic_vector(31 downto 0);

signal Inst : std_logic_vector(25 downto 0);
signal Shift_Out2 : std_logic_vector(27 downto 0);

signal Overflow, Zero : std_logic;

signal Comb_Logic, Comb_Logic_Temp : std_logic;

signal ALUOut_en, MemData_en : std_logic;

signal ALU_A_In, ALU_B_In : std_logic_vector(31 downto 0);

signal State_Out : std_logic_vector(2 downto 0);

signal zero_ext : std_logic;

signal shamt_out : std_logic_vector(4 downto 0);
signal shamt_sel : std_logic_vector(1 downto 0);

signal mult_out : std_logic_vector(63 downto 0);
signal done : std_logic;
begin
jump_addr <= PC_out(31 downto 28) & Shift_Out2;
Comb_Logic_Temp <= Zero and PCWriteCond;
Comb_Logic <= Comb_Logic_Temp or PCWrite;
PC0: PC port map(Clock, Reset, PC_In,Comb_Logic,PC_out);
Mux3_1: mux3 port map(PC_out,ALU_Out,IorD,MemoryAddress);
Inst_Reg: Instruction_Reg port map(Clock, Reset, MemoryDataIn, IRWrite,IR1,IR2,IR3,IR4);
Reg: Registers port map(Clock, Reset, IR2, IR3, Write_Reg,RegWrite,Write_Data,A, B);
Mux1_1: mux1 port map(IR3,IR4(15 downto 11), RegDest, Write_Reg);
Mem_Data: Mem_Data_Reg port map(Clock, Reset, MemData_en,MemoryDataIn,Memory_Data_Out);
Mux3_2: mux3 port map(ALU_Out,Memory_Data_Out, MemToReg, Write_Data);
Extend: Ext port map(IR4,zero_ext,Extend_Out);
Shift: Shift_L port map(Extend_Out, Shift_Out);
A0: A_reg port map(Clock,Reset,A_en,A,ALU_A);
B0: A_reg port map(Clock,Reset,B_en,B,ALU_B);
MemoryDataOut <= ALU_B;
Mux3_3: mux3 port map(PC_out,ALU_A,ALUSrcA,ALU_A_In);
Mux2_1: mux2 port map(ALU_B,X"00000004",Extend_Out,Shift_Out,ALUSrcB,ALU_B_In);
--Add mux for shamt
Mux4_1: mux4 port map(IR4(10 downto 6),ALU_A(4 downto 0),"10000","00000",shamt_sel,shamt_out);
ALU0: ALU port map(ALU_A_In,ALU_B_In,ALUOp,shamt_out,Overflow,Zero,ALU_Result); --is shamt 00000?
ALU_Output: ALUOut port map(Clock, Reset,ALUOut_en,ALU_Result,ALU_Out); 
Inst <= IR2 & IR3 & IR4;
Shift2: Shift_L2 port map(Inst, Shift_Out2);
Mux2_2: mux2 port map(ALU_Result,ALU_Out,jump_addr,X"00000000",PCSource,PC_In);
Cont: control port map(Clock, Reset, IR4(5 downto 0),IR1,done,shamt_sel,PCWriteCond,PCWrite,ALUOp,IorD,MemRead,MemWrite,MemToReg,IRWrite,ALUSrcA,RegWrite,RegDest,A_en,B_en, ALUOut_en,MemData_en,PCSource,ALUSrcB,State_Out);
Mul: Mult port map(ALU_A,ALU_B,Clock,Reset,mult_out, done);
end Behavioral;
