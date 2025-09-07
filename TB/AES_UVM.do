Vlog AES_128_regs.sv AES_pack_UVM.sv AES_top.sv AES_interface.sv +cover
vsim AES_top -novopt -cover -coverage -suppress 12110 -sv_seed random 
add wave -r /*
coverage save AES_top.ucdb -onexit
run -all; 
vcover report AES_top.ucdb -details -all -annotate -output AES_UVM_cvr.txt