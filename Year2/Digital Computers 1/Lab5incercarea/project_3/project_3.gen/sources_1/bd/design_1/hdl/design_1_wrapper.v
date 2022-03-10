//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu May 27 06:50:27 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clear_0,
    clock_0,
    exp1_0,
    exp2_0,
    load_0,
    mant1_0,
    mant2_0,
    op_0,
    rout_0,
    rout_1);
  input clear_0;
  input clock_0;
  input [7:0]exp1_0;
  input [7:0]exp2_0;
  input load_0;
  input [23:0]mant1_0;
  input [23:0]mant2_0;
  input op_0;
  output [23:0]rout_0;
  output [7:0]rout_1;

  wire clear_0;
  wire clock_0;
  wire [7:0]exp1_0;
  wire [7:0]exp2_0;
  wire load_0;
  wire [23:0]mant1_0;
  wire [23:0]mant2_0;
  wire op_0;
  wire [23:0]rout_0;
  wire [7:0]rout_1;

  design_1 design_1_i
       (.clear_0(clear_0),
        .clock_0(clock_0),
        .exp1_0(exp1_0),
        .exp2_0(exp2_0),
        .load_0(load_0),
        .mant1_0(mant1_0),
        .mant2_0(mant2_0),
        .op_0(op_0),
        .rout_0(rout_0),
        .rout_1(rout_1));
endmodule
