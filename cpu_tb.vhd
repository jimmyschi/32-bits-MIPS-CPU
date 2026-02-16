----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2022 09:44:10 AM
-- Design Name: 
-- Module Name: cpu_tb - Behavioral
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

entity cpu_tb is
 Port (clock, reset : in std_logic );
end cpu_tb;

architecture Behavioral of cpu_tb is
component datapath is
Port (Reset, Clock : in std_logic;
        MemoryDataIn : in std_logic_vector(31 downto 0);
        MemoryAddress, MemoryDataOut : out std_logic_vector(31 downto 0);
        MemWrite : out std_logic
    );
end component;
component CPU_memory is
PORT( 
      Clk      : IN     std_logic;
      MemWrite : IN     std_logic;
      addr     : IN     std_logic_vector (31 DOWNTO 0);
      dataIn   : IN     std_logic_vector (31 DOWNTO 0);
      dataOut  : OUT    std_logic_vector (31 DOWNTO 0)
   );
end component;
signal MemoryDataIn : std_logic_vector(31 downto 0);
signal MemoryAddress, MemoryDataOut : std_logic_vector(31 downto 0);
signal MemWrite : std_logic;

begin
data: datapath port map(reset,clock,MemoryDataIn,MemoryAddress,MemoryDataOut,MemWrite);
U_1: CPU_memory port map(clock, MemWrite,MemoryAddress,MemoryDataOut,MemoryDataIn);
end Behavioral;
