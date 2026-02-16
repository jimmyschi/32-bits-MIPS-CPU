----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2022 08:36:49 AM
-- Design Name: 
-- Module Name: mux1 - Behavioral
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

entity mux1 is
  generic(
            k : integer := 5
  );
  Port (a,b : in std_logic_vector(k -1 downto 0);
        sel : in std_logic;
        r : out std_logic_vector(k -1 downto 0)
   );
end mux1;

architecture Behavioral of mux1 is
begin
p1: process(a,b,sel)
begin
if sel = '0' then
    r <= a;
else 
    r <= b;
end if;
end process p1;
end Behavioral;
