----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2022 01:04:49 PM
-- Design Name: 
-- Module Name: Instruction_Reg - Behavioral
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

entity Instruction_Reg is
  Port (clk, reset : in std_logic;
        MemData : in std_logic_vector(31 downto 0);
        IRWrite: in std_logic;
        IR1 : out std_logic_vector(5 downto 0);
        IR2, IR3 : out std_logic_vector(4 downto 0);
        IR4 : out std_logic_vector(15 downto 0)
  );
end Instruction_Reg;

architecture Behavioral of Instruction_Reg is
begin
process(clk,reset)
begin
    if(reset = '1') then
        IR1 <= "000000";
        IR2 <= "00000";
        IR3 <= "00000";
        IR4 <= "0000000000000000";
    elsif(rising_edge(clk)) then       
      if(IRWrite = '1') then
        IR1 <= MemData(31 downto 26);
        IR2 <= MemData(25 downto 21);
        IR3 <= MemData(20 downto 16);
        IR4 <= MemData(15 downto 0);
     end if;
end if;
end process;
end Behavioral;
