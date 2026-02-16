# restart the simulation
restart

#forcing a clock with 10 ns period


#give a reset signal
add_force rst 0
run 2500ps
add_force rst 1
run 5 ns
add_force rst 0
add_force rd1 00000
add_force rd2 00101
add_force wr 00101
add_force regw 1
add_force data -radix hex 00000011
add_force clk 0
run 5 ns
add_force clk 1

run 200 ns
