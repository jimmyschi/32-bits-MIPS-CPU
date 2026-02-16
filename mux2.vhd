----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2022 08:46:17 AM
-- Design Name: 
-- Module Name: mux2 - Behavioral
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

entity mux2 is
generic(
            k : integer := 32
  );
  Port (a,b,c,d : in std_logic_vector(k -1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        r : out std_logic_vector(k -1 downto 0)
   );
end mux2;

architecture Behavioral of mux2 is
begin
p1: process(a,b,c,d,sel)
begin
if sel = "00" then
    r <= a;
elsif sel = "01" then
    r <= b;
elsif sel = "10" then
    r <= c;
else
    r <= d;
end if;
end process p1;
end Behavioral;
