vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../Lab4.srcs/sources_1/ip/clk_wiz_1" "+incdir+../../../../Lab4.srcs/sources_1/ip/clk_wiz_1" \
"C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../Lab4.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_sim_netlist.vhdl" \


vlog -work xil_defaultlib \
"glbl.v"

