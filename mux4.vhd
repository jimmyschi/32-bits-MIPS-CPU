----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2022 08:26:11 AM
-- Design Name: 
-- Module Name: mux4 - Behavioral
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

entity mux4 is
generic(
            k : integer := 5
  );
  Port (a,b,c,d : in std_logic_vector(k -1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        r : out std_logic_vector(k -1 downto 0)
   );
end mux4;

architecture Behavioral of mux4 is

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
