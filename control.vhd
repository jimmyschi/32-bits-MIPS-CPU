----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2022 09:37:08 AM
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
  Port (clk, reset : in std_logic;
        IR4 : in std_logic_vector(5 downto 0);
        Op : in std_logic_vector(5 downto 0);
        done : in std_logic;
        shamt_sel : out std_logic_vector(1 downto 0);
        lui_sel : out std_logic;
        PCWriteCond, PCWrite : out std_logic;
        ALUOp : out std_logic_vector(3 downto 0);
        IorD: out std_logic;
        MemRead : out std_logic;
        MemWrite : out std_logic;
        MemToReg : out std_logic;
        IRWrite : out std_logic;
        ALUSrcA : out std_logic;
        RegWrite : out std_logic;
        RegDest : out std_logic;
        A_en, B_en, ALUOut_en, MemData_en : out std_logic;
        PCSource : out std_logic_vector(1 downto 0); --is this supposed to be 2 bits? 
        ALUSrcB : out std_logic_vector(1 downto 0);   --is this supposed to be 2 bits?
        State_Out : out std_logic_vector(2 downto 0);
        zero_ext : out std_logic
    );
end control;

architecture Behavioral of control is
-- Build an enumerated type for the state machine
type state_type is (s0, s1, s2, s3, s4);
	
-- Register to hold the current state
signal state   : state_type;
begin
-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=> --Fetch
					state <= s1;
				when s1=> --Decode
					state <= s2;
				when s2=> --Exec
					if Op = "000000" then --R-type
					   if IR4 = "011001" then
					       if done = '1' then
					           state <= s0;
					       end if;
					    else
						   state <= s3;
						end if;
					elsif Op = "100011" then --LW
						state <= s3;
					elsif Op = "101011" then --SW
					    state <= s3;
					elsif Op = "001000" then --addi
					    state <= s3;
					elsif Op = "001101" then --ori
					    state <= s3;
					elsif Op = "001010" then --slti
					    state <= s3;
					elsif Op = "001111" then --lui ???
					    state <= s3;
					else			
					    state <= s0;
					end if;
				when s3 => --Mem
					if Op = "000000" then --R-type
						state <= s0;
					elsif Op = "100011" then --LW
						state <= s4;
					elsif Op = "101011" then --SW
					    state <= s0;
					elsif Op = "001000" then --addi
					    state <= s0;
					elsif Op = "001101" then --ori
					    state <= s0;
					elsif Op = "001010" then --slti
					    state <= s0;
					elsif Op = "001111" then --lui
					    state <= s0;
					end if;
			    when s4 => --Writeback
			        state <= s0;
			end case;
		end if;
		if state<= s0 then
		  State_Out <= "001";
	   elsif state <= s1 then
	       State_Out <= "010";
	   elsif state <= s2 then
	       State_Out <= "011";
	   elsif state <= s3 then
	       State_Out <= "100";
	   elsif state <= s4 then
	       State_Out <= "101";
	   end if;
    end process;

    -- Determine the output based only on the current state
	-- and the input (do not wait for a clock edge).
	process (state,Op,IR4)
	begin
		case state is
			when s0=> --Fetch
			    ALUOp <= "0101";
				PCWriteCond <= '0';
				PCWrite <= '1';
				IorD <= '0';
				MemRead <= '0';
				A_en <= '1';
				B_en <= '1';
				ALUOut_en <= '0';
				MemData_en <= '0';
				MemWrite <= '0';
				MemToReg <= '0';
				IRWrite <= '1';
				ALUSrcA <= '0';
				RegWrite <= '0';
				RegDest <= '0';
				PCSource <= "00";
				ALUSrcB <= "01";
				zero_ext <= '0';
			when s1=> --Decode
			 if Op = "000000" then --R-type
			 --add en for each register in ports
			        ALUOp <= "0000";
				    PCWriteCond <= '0';
                    PCWrite <= '0';
                    IorD <= '0';
                    MemRead <= '0';
			       	A_en <= '1';
				    B_en <= '1';
				    ALUOut_en <= '0';
				    MemData_en <= '0';
                    MemWrite <= '0';
                    MemToReg <= '0';
                    IRWrite <= '0';
                    ALUSrcA <= '0';
                    RegWrite <= '0';
                    RegDest <= '0';
                    PCSource <= "00";
                    ALUSrcB <= "00";
					elsif Op <= "100011" then --LW
					   ALUOp <= "0000";
					   PCWriteCond <= '0';
                       PCWrite <= '0';
                       IorD <= '0';
                       MemRead <= '0';
			      	   A_en <= '1';
				       B_en <= '1';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "00";
					elsif Op = "101011" then --SW
				       ALUOp <= "0000";
					   PCWriteCond <= '0';
                       PCWrite <= '0';  
                       MemRead <= '0';                 
                       IorD <= '0';
                       A_en <= '1';
				       B_en <= '1';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "00";	
                    elsif Op = "000010" then --J
                       ALUOp <= "0000";
                       PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '0';
                       A_en <= '1';
				       B_en <= '1';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "00";
                     elsif Op = "000101" then --BnE
  				       ALUOp <= "0000";
                       PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '0';
                       A_en <= '1';
				       B_en <= '1';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "00";	
                     elsif Op = "000001" then --BLTZAL
                       ALUOp <= "0000";
                       PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '0';
                       A_en <= '1';
				       B_en <= '1';
				       ALUOut_en <= '1';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "00";
                     else 
                        ALUOp <= "0000";
                        PCWriteCond <= '0';
                        PCWrite <= '0';
                        IorD <= '0';
                        MemRead <= '0';
                        A_en <= '1';
                        B_en <= '1';
                        ALUOut_en <= '0';
                        MemData_en <= '0';
                        MemWrite <= '0';
                        MemToReg <= '0';
                        IRWrite <= '0';
                        ALUSrcA <= '1';
                        RegWrite <= '0';
                        RegDest <= '0';
                        PCSource <= "00";
                        ALUSrcB <= "10";	   
					end if;
			when s2=> --Exec
				if Op = "000000" then --R-type
					if IR4 = "100001" then
			             ALUOp <= "0101"; --addu
			        elsif IR4 = "100100" then
			             ALUOp <= "0000"; --and
			        elsif IR4 = "000011" then
			             ALUOp <= "1110"; --sra 
			             shamt_sel <= "00";
			        elsif IR4 = "100010" then
			             ALUOp <= "0110"; --sub
			        elsif IR4 = "001000" then -- jr
			             ALUOp <= "0101"; --???
			        elsif IR4 = "000000" then
			             ALUOp <= "1100"; --sll 
			             shamt_sel <= "00";
			        elsif IR4 = "000100" then
			             ALUOp <= "1100"; --sllv
			             shamt_sel <= "01";
			        elsif IR4 = "010000" then --mfhi
			             ALUOp <= "1100";
			        elsif IR4 = "010010" then --mflo
			             ALUOp <= "0000";
			        end if;
				    PCWriteCond <= '0';
                    PCWrite <= '0';
                    MemRead <= '0';
                    IorD <= '0';
                    A_en <= '0';
				    B_en <= '0';
				    ALUOut_en <= '1';
				    MemData_en <= '0';
                    MemWrite <= '0';
                    MemToReg <= '0';
                    IRWrite <= '0';
                    ALUSrcA <= '1';
                    RegWrite <= '0';
                    RegDest <= '0';
                    PCSource <= "00";
                    ALUSrcB <= "00";              
					elsif Op = "100011" then --LW
					   ALUOp <= "0000"; --???
					   PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '1';
                       A_en <= '0';
				       B_en <= '0';
				       ALUOut_en <= '1';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '1';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "10";
					elsif Op = "101011" then --SW
					   ALUOp <= "0101"; 
					   PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '1';
                       A_en <= '0';
				       B_en <= '0';
				       ALUOut_en <= '1';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '1';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "10";	
                     elsif Op = "000010" then --J
                       ALUOp <= "0000";
                       PCWriteCond <= '0';
                       PCWrite <= '1';
                       MemRead <= '0';
                       IorD <= '0';
                       A_en <= '0';
				       B_en <= '0';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "10";
                       ALUSrcB <= "00";
                     elsif Op = "000101" then --BnE
  				       ALUOp <= "0110";
                       PCWriteCond <= '1';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '0';
                       A_en <= '0';
				       B_en <= '0';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '1';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "01";
                       ALUSrcB <= "00";	
                     elsif Op = "000001" then --BLTZAL Countdown
                       ALUOp <= "0101"; --add???
                       PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '0';
                       A_en <= '0';
				       B_en <= '0';
				       ALUOut_en <= '1';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '1';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "01";
                       ALUSrcB <= "10"; 
                      else 
                        if Op = "001000" then
                            ALUOp <= "0101"; --addi
                        elsif Op = "001101" then
                            ALUOp <= "0001"; --ori
                            zero_ext <= '1';
                        elsif Op = "001010" then
                            ALUOp <= "1010"; --slti
                        elsif Op = "001111" then
                            ALUOp <= "1100"; -- lui ???
                            shamt_sel <= "10";
                        end if;
                        PCWriteCond <= '0';
                        PCWrite <= '0';
                        MemRead <= '0';
                        IorD <= '0';
                        A_en <= '1';
                        B_en <= '1';
                        ALUOut_en <= '1';
                        MemData_en <= '0';
                        MemWrite <= '0';
                        MemToReg <= '0';
                        IRWrite <= '0';
                        ALUSrcA <= '1';
                        RegWrite <= '0';
                        RegDest <= '0';
                        PCSource <= "00";
                        ALUSrcB <= "10";				   
					end if;
			when s3=> --Mem
				if Op = "000000" then --R-type completion
				    ALUOp <= "0000";
				    PCWriteCond <= '0';
                    PCWrite <= '0';
                    MemRead <= '0';
                    IorD <= '0';
                    A_en <= '0';
				    B_en <= '0';
				    ALUOut_en <= '0';
				    MemData_en <= '0';
                    MemWrite <= '0';
                    MemToReg <= '0';
                    IRWrite <= '0';
                    ALUSrcA <= '0';
                    RegWrite <= '1';
                    RegDest <= '1';
                    PCSource <= "00";
                    ALUSrcB <= "00";
					elsif Op = "100011" then --LW
					   ALUOp <= "0000";
					   PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '1';
                       A_en <= '0';
				       B_en <= '0';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '0';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "00";
					elsif Op = "101011" then --SW
					   ALUOp <= "0000";
					   PCWriteCond <= '0';
                       PCWrite <= '0';
                       MemRead <= '0';
                       IorD <= '1';
                       A_en <= '0';
				       B_en <= '0';
				       ALUOut_en <= '0';
				       MemData_en <= '0';
                       MemWrite <= '1';
                       MemToReg <= '0';
                       IRWrite <= '0';
                       ALUSrcA <= '0';
                       RegWrite <= '0';
                       RegDest <= '0';
                       PCSource <= "00";
                       ALUSrcB <= "00";
                     else 
                        ALUOp <= "0000";
                        PCWriteCond <= '0';
                        PCWrite <= '0';
                        MemRead <= '0';
                        IorD <= '0';
                        A_en <= '0';
                        B_en <= '0';
                        ALUOut_en <= '0';
                        MemData_en <= '0';
                        MemWrite <= '0';
                        MemToReg <= '0';
                        IRWrite <= '0';
                        ALUSrcA <= '0';
                        RegWrite <= '1';
                        RegDest <= '0';
                        PCSource <= "00";
                        ALUSrcB <= "00";
					end if;
			when s4 => --Mem read completion
			    ALUOp <= "0000";
			    PCWriteCond <= '0';
				PCWrite <= '0';
				MemRead <= '1';
				IorD <= '0';
				A_en <= '0';
				B_en <= '0';
				ALUOut_en <= '0';
				MemData_en <= '0';
				MemWrite <= '0';
				MemToReg <= '1';
				IRWrite <= '0';
				ALUSrcA <= '0';
				RegWrite <= '1';
				RegDest <= '0';
				PCSource <= "00";
				ALUSrcB <= "00";
		end case;
	end process;

end Behavioral;
