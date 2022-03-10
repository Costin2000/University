//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu Apr 15 12:11:49 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema_wrapper.bd
//Design      : Schema_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Schema_wrapper
   (Cola_0,
    Fanta_0,
    L10_0,
    L1_0,
    L5_0,
    R10_0,
    R1_0,
    R5_0,
    clk_0,
    reset_0,
    wantCola_0,
    wantFanta_0,
    wantRest_0);
  output Cola_0;
  output Fanta_0;
  input L10_0;
  input L1_0;
  input L5_0;
  output R10_0;
  output R1_0;
  output R5_0;
  input clk_0;
  input reset_0;
  input wantCola_0;
  input wantFanta_0;
  input wantRest_0;

  wire Cola_0;
  wire Fanta_0;
  wire L10_0;
  wire L1_0;
  wire L5_0;
  wire R10_0;
  wire R1_0;
  wire R5_0;
  wire clk_0;
  wire reset_0;
  wire wantCola_0;
  wire wantFanta_0;
  wire wantRest_0;

  Schema Schema_i
       (.Cola_0(Cola_0),
        .Fanta_0(Fanta_0),
        .L10_0(L10_0),
        .L1_0(L1_0),
        .L5_0(L5_0),
        .R10_0(R10_0),
        .R1_0(R1_0),
        .R5_0(R5_0),
        .clk_0(clk_0),
        .reset_0(reset_0),
        .wantCola_0(wantCola_0),
        .wantFanta_0(wantFanta_0),
        .wantRest_0(wantRest_0));
endmodule
