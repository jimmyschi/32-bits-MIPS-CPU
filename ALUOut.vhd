----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/19/2022 12:48:15 PM
-- Design Name: 
-- Module Name: ALUOut - Behavioral
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

entity ALUOut is
  Port (clk, reset : in std_logic;
        sel : in std_logic;
        ALU_Res: in std_logic_vector(31 downto 0);
        Jump_Address : out std_logic_vector(31 downto 0)
  );
end ALUOut;

architecture Behavioral of ALUOut is
begin
process(clk, reset) 
begin
if(reset = '1') then
    Jump_Address <= (others => '0');
elsif(rising_edge(clk)) then
    if(sel = '1') then
        Jump_Address <= ALU_Res;
    end if;
end if;
end process;

end Behavioral;
