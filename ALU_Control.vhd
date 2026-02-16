----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2022 01:39:05 PM
-- Design Name: 
-- Module Name: ALU_Control - Behavioral
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

entity ALU_Control is
  Port (input : in std_logic_vector(5 downto 0);
        ALUOp_in : in std_logic_vector(5 downto 0);
        ALUOp_out : out std_logic_vector(3 downto 0)
   );
end ALU_Control;

architecture Behavioral of ALU_Control is
begin
    ALUOp_out <= "0101" when ALUOp_in <= "000000" and input <= "100001" else --ADDU
                 "0000" when ALUOp_in <= "000000" and input <= "100100" else --AnD
                 "1010" when ALUOp_in <= "001010" else --SLTI
                 "1111" when ALUOp_in <= "000000" and input <= "000011" else --SRA
                 "0110" when ALUOp_in <= "000000" and input <= "100010" else --SUB
                 "0101" when ALUOp_in <= "001000" else --ADDI
                 "0001" when ALUOp_in <= "001101" else --ORI
                 "0101" when ALUOp_in <= "100011" else --LW
                 "1110" when ALUOp_in <= "000000" and input <= "000000" else --SLL
                 "0000";

end Behavioral;
