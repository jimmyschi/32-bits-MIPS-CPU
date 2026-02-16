----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2022 09:30:27 AM
-- Design Name: 
-- Module Name: B_reg - Behavioral
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

entity B_reg is
  Port (clk, reset : in std_logic;
        sel : in std_logic;
        input : in std_logic_vector(31 downto 0);
        output : out std_logic_vector(31 downto 0)
   );
end B_reg;

architecture Behavioral of B_reg is
begin
process(clk,reset)
begin
    if(reset = '1') then
        output <= (others => '0');
    elsif(rising_edge(clk)) then       
      if(sel = '1') then
        output <= input;
     end if;
end if;
end process;

end Behavioral;
