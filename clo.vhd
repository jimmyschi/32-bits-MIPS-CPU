----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2022 08:54:40 AM
-- Design Name: 
-- Module Name: clo - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity num_ones_for is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           ones : out  STD_LOGIC_VECTOR (4 downto 0));
end num_ones_for;

architecture Behavioral of num_ones_for is

begin

process(A)
variable count : unsigned(4 downto 0) := "00000";
begin
    count := "00000";   --initialize count variable.
    for i in 0 to 31 loop   --check for all the bits.
        if(A(i) = '1') then --check if the bit is '1'
            count := count + 1; --if its one, increment the count.
        end if;
    end loop;
    ones <= std_logic_vector(count);    --assign the count to output.
end process;

end Behavioral;