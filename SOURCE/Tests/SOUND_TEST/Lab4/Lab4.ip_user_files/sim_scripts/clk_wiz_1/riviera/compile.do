vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../Lab4.srcs/sources_1/ip/clk_wiz_1" "+incdir+../../../../Lab4.srcs/sources_1/ip/clk_wiz_1" \
"C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../Lab4.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_sim_netlist.vhdl" \


vlog -work xil_defaultlib \
"glbl.v"

