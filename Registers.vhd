----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2022 08:42:17 AM
-- Design Name: 
-- Module Name: Registers - Behavioral
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

entity Registers is
  Port (clk, rst : in std_logic;
        rd1, rd2, wr : in std_logic_vector(4 downto 0);
        regw : in std_logic;
        data : in std_logic_vector(31 downto 0);
        rd1_out, rd2_out : out std_logic_vector(31 downto 0)
        );
end Registers;

architecture Behavioral of Registers is
component flipflop IS
   PORT( 
      CLK : IN     std_logic;
      D   : IN     std_logic_vector(31 downto 0);
      EN  : IN     std_logic;
      RST : IN     std_logic;
      Q   : OUT    std_logic_vector(31 downto 0)
   );
end component;
signal e : std_logic_vector(31 downto 0);
type dataArray is array(31 downto 0) of std_logic_vector(31 downto 0);
signal q : dataArray;
begin
r0:
for i in 0 to 31 generate
    f0: flipflop port map(clk, data,e(i), rst, q(i)); --???
end generate r0;    

rd1_out <= q(0) when rd1 = "00000" else
           q(1) when rd1 = "00001"  else
           q(2) when rd1 = "00010" else
           q(3) when rd1 = "00011" else
           q(4) when rd1 = "00100"  else
           q(5) when rd1 = "00101"  else
           q(6) when rd1 = "00110" else
           q(7) when rd1 = "00111"  else
           q(8) when rd1 = "01000"  else
           q(9) when rd1 = "01001"  else
           q(10) when rd1 = "01010"  else
           q(11) when rd1 = "01011"  else
           q(12) when rd1 = "01100"  else
           q(13) when rd1 = "01101"  else
           q(14) when rd1 = "01110"  else
           q(15) when rd1 = "01111"  else
           q(16) when rd1 = "10000"  else
           q(17) when rd1 = "10001"  else
           q(18) when rd1 = "10010"  else
           q(19) when rd1 = "10011"  else
           q(20) when rd1 = "10100"  else
           q(21) when rd1 = "10101"  else
           q(22) when rd1 = "10110"  else
           q(23) when rd1 = "10111"  else
           q(24) when rd1 = "11000"  else
           q(25) when rd1 = "11001"  else
           q(26) when rd1 = "11010"  else
           q(27) when rd1 = "11011"  else
           q(28) when rd1 = "11100"  else
           q(29) when rd1 = "11101"  else
           q(30) when rd1 = "11110"  else
           q(31) when rd1 = "11111";
           
rd2_out <= q(0) when rd2 = "00000" else
           q(1) when rd2 = "00001"  else
           q(2) when rd2 = "00010" else
           q(3) when rd2 = "00011"  else
           q(4) when rd2 = "00100"  else
           q(5) when rd2 = "00101"  else
           q(6) when rd2 = "00110"  else
           q(7) when rd2 = "00111"  else
           q(8) when rd2 = "01000"  else
           q(9) when rd2 = "01001"  else
           q(10) when rd2 = "01010"  else
           q(11) when rd2 = "01011"  else
           q(12) when rd2 = "01100"  else
           q(13) when rd2 = "01101"  else
           q(14) when rd2 = "01110"  else
           q(15) when rd2 = "01111"  else
           q(16) when rd2 = "10000"  else
           q(17) when rd2 = "10001"  else
           q(18) when rd2 = "10010"  else
           q(19) when rd2 = "10011"  else
           q(20) when rd2 = "10100"  else
           q(21) when rd2 = "10101"  else
           q(22) when rd2 = "10110"  else
           q(23) when rd2 = "10111"  else
           q(24) when rd2 = "11000"  else
           q(25) when rd2 = "11001"  else
           q(26) when rd2 = "11010"  else
           q(27) when rd2 = "11011"  else
           q(28) when rd2 = "11100"  else
           q(29) when rd2 = "11101"  else
           q(30) when rd2 = "11110"  else
           q(31) when rd2 = "11111";
           
e(0) <= '1' when wr = "00000" and regw = '1' else '0';
e(1) <= '1' when wr = "00001" and regw = '1' else '0';  
e(2) <= '1' when wr = "00010" and regw = '1' else '0';  
e(3) <= '1' when wr = "00011" and regw = '1' else '0';  
e(4) <= '1' when wr = "00100" and regw = '1' else '0';  
e(5) <= '1' when wr = "00101" and regw = '1' else '0';
e(6) <= '1' when wr = "00110" and regw = '1' else '0';
e(7) <= '1' when wr = "00111" and regw = '1' else '0';
e(8) <= '1' when wr = "01000" and regw = '1' else '0';
e(9) <= '1' when wr = "01001" and regw = '1' else '0';  
e(10) <= '1' when wr = "01010" and regw = '1' else '0';  
e(11) <= '1' when wr = "01011" and regw = '1' else '0';  
e(12) <= '1' when wr = "01100" and regw = '1' else '0';  
e(13) <= '1' when wr = "01101" and regw = '1' else '0';
e(14) <= '1' when wr = "01110" and regw = '1' else '0';
e(15) <= '1' when wr = "01111" and regw = '1' else '0'; 
e(16) <= '1' when wr = "10000" and regw = '1' else '0';
e(17) <= '1' when wr = "10001" and regw = '1' else '0';  
e(18) <= '1' when wr = "10010" and regw = '1' else '0';  
e(19) <= '1' when wr = "10011" and regw = '1' else '0';  
e(20) <= '1' when wr = "10100" and regw = '1' else '0';  
e(21) <= '1' when wr = "10101" and regw = '1' else '0';
e(22) <= '1' when wr = "10110" and regw = '1' else '0';
e(23) <= '1' when wr = "10111" and regw = '1' else '0'; 
e(24) <= '1' when wr = "11000" and regw = '1' else '0';
e(25) <= '1' when wr = "11001" and regw = '1' else '0';  
e(26) <= '1' when wr = "11010" and regw = '1' else '0';  
e(27) <= '1' when wr = "11011" and regw = '1' else '0';  
e(28) <= '1' when wr = "11100" and regw = '1' else '0';  
e(29) <= '1' when wr = "11101" and regw = '1' else '0';
e(30) <= '1' when wr = "11110" and regw = '1' else '0';
e(31) <= '1' when wr = "11111" and regw = '1' else '0';               

end Behavioral;
