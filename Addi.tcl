restart
add_wave {{/datapath/Reg}}
add_wave {{/datapath/Cont}}
add_force Clock 1 {0 5ns} -repeat_every 10ns

#give a reset signal
add_force Reset 0
run 2500ps
add_force Reset 1
run 5 ns
add_force Reset 0
add_force MemoryDataIn -radix hex 20070011

run 200 ns
