----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2022 09:04:14 AM
-- Design Name: 
-- Module Name: Ext - Behavioral
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

entity Ext is
  Port (a : in std_logic_vector(15 downto 0);
        zero_ext : in std_logic;
        r : out std_logic_vector(31 downto 0)
  );
end Ext;

architecture Behavioral of Ext is
begin
r <= X"0000" & a when zero_ext = '1' or a(15) = '0' else
     X"FFFF" & a;
end Behavioral;
