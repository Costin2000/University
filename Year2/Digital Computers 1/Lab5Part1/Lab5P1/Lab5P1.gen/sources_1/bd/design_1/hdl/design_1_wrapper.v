//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Wed May 26 15:46:49 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clock_0,
    enable_0,
    reset_0,
    result_0,
    t_0,
    x_0,
    y_0);
  input clock_0;
  input enable_0;
  input reset_0;
  output result_0;
  input t_0;
  input x_0;
  input y_0;

  wire clock_0;
  wire enable_0;
  wire reset_0;
  wire result_0;
  wire t_0;
  wire x_0;
  wire y_0;

  design_1 design_1_i
       (.clock_0(clock_0),
        .enable_0(enable_0),
        .reset_0(reset_0),
        .result_0(result_0),
        .t_0(t_0),
        .x_0(x_0),
        .y_0(y_0));
endmodule
