//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Mon Apr 12 09:41:16 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema_wrapper.bd
//Design      : Schema_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Schema_wrapper
   (B10_0,
    B1_0,
    B5_0,
    REST1_0,
    REST5_0,
    SUC_0,
    clk_0,
    reset_0);
  input B10_0;
  input B1_0;
  input B5_0;
  output REST1_0;
  output REST5_0;
  output SUC_0;
  input clk_0;
  input reset_0;

  wire B10_0;
  wire B1_0;
  wire B5_0;
  wire REST1_0;
  wire REST5_0;
  wire SUC_0;
  wire clk_0;
  wire reset_0;

  Schema Schema_i
       (.B10_0(B10_0),
        .B1_0(B1_0),
        .B5_0(B5_0),
        .REST1_0(REST1_0),
        .REST5_0(REST5_0),
        .SUC_0(SUC_0),
        .clk_0(clk_0),
        .reset_0(reset_0));
endmodule
