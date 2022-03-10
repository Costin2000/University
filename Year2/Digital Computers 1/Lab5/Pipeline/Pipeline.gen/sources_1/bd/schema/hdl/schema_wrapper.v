//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed May 26 13:48:52 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target schema_wrapper.bd
//Design      : schema_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module schema_wrapper
   (INPUT_0,
    a_0,
    b_0,
    clk_0,
    iesire_0,
    load_0,
    reset_0);
  input INPUT_0;
  input a_0;
  input b_0;
  input clk_0;
  output iesire_0;
  input load_0;
  input reset_0;

  wire INPUT_0;
  wire a_0;
  wire b_0;
  wire clk_0;
  wire iesire_0;
  wire load_0;
  wire reset_0;

  schema schema_i
       (.INPUT_0(INPUT_0),
        .a_0(a_0),
        .b_0(b_0),
        .clk_0(clk_0),
        .iesire_0(iesire_0),
        .load_0(load_0),
        .reset_0(reset_0));
endmodule
