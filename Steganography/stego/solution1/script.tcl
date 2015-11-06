############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 2014 Xilinx Inc. All rights reserved.
############################################################
open_project stego
set_top array_io
add_files Vivado_HLS_Tutorial/Interface_Synthesis/lab3/array_io.c
add_files Vivado_HLS_Tutorial/Interface_Synthesis/lab3/array_io.h
add_files -tb Vivado_HLS_Tutorial/Interface_Synthesis/lab3/array_io_test.c
open_solution "solution1"
set_part {xc7z020clg484-1}
create_clock -period 10 -name default
source "./stego/solution1/directives.tcl"
csim_design -setup
csynth_design
cosim_design
export_design -format ip_catalog
