//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Wed May 19 19:01:47 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (GUAT_G_0,
    GUAT_P_0,
    a_0,
    b_0,
    c_in_0,
    carry4_0,
    sum_out_0);
  output GUAT_G_0;
  output GUAT_P_0;
  input [15:0]a_0;
  input [15:0]b_0;
  input c_in_0;
  output carry4_0;
  output [15:0]sum_out_0;

  wire GUAT_G_0;
  wire GUAT_P_0;
  wire [15:0]a_0;
  wire [15:0]b_0;
  wire c_in_0;
  wire carry4_0;
  wire [15:0]sum_out_0;

  design_1 design_1_i
       (.GUAT_G_0(GUAT_G_0),
        .GUAT_P_0(GUAT_P_0),
        .a_0(a_0),
        .b_0(b_0),
        .c_in_0(c_in_0),
        .carry4_0(carry4_0),
        .sum_out_0(sum_out_0));
endmodule
