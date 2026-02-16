# restart the simulation
restart

#top-level CPU testbench is named cpu_tb
#this instruction will add the internal signals and ports of a component name U_1, which in this case is the memory block.
#this should be replaced by the name of the componenet in your top-level testbench
add_wave {{/cpu_tb/data}} 

# Forcing a program (instruction memory)

#addi $11, $0, 3
#addi $11, $11, 5
#multu $11, $7
#sw $11, 15($7)


# you can use any of the following commands as an example on how to initilaize a memory location with a value
# the first 4 memory locations are initialized with the instruction codes correpsonding to the 4 instructions above.
add_force {/cpu_tb/U_1/mw_U_0ram_table[0]} -radix hex {200B0003}
add_force {/cpu_tb/U_1/mw_U_0ram_table[1]} -radix hex {216B0005}
add_force {/cpu_tb/U_1/mw_U_0ram_table[2]} -radix hex {01670019}
add_force {/cpu_tb/U_1/mw_U_0ram_table[3]} -radix hex {ACEB000F}

#forcing a clock with 10 ns period
add_force clock 1 {0 5ns} -repeat_every 10ns

#give a reset signal
add_force reset 0
run 2500ps
add_force reset 1
run 5 ns
add_force reset 0

run 200 ns
