//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed May 26 14:12:48 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (a_0,
    b_0,
    clk_0,
    enable_0,
    iesire_0,
    intrare_0,
    reset_0);
  input a_0;
  input b_0;
  input clk_0;
  input enable_0;
  output iesire_0;
  input intrare_0;
  input reset_0;

  wire a_0;
  wire b_0;
  wire clk_0;
  wire enable_0;
  wire iesire_0;
  wire intrare_0;
  wire reset_0;

  design_1 design_1_i
       (.a_0(a_0),
        .b_0(b_0),
        .clk_0(clk_0),
        .enable_0(enable_0),
        .iesire_0(iesire_0),
        .intrare_0(intrare_0),
        .reset_0(reset_0));
endmodule
