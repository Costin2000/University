//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Thu Apr 15 10:47:46 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (Ron10_0,
    Ron1_0,
    Ron5_0,
    Ron_rest1_0,
    Ron_rest5_0,
    SANDWICH_0,
    clk_0,
    reset_0);
  input Ron10_0;
  input Ron1_0;
  input Ron5_0;
  output Ron_rest1_0;
  output Ron_rest5_0;
  output SANDWICH_0;
  input clk_0;
  input reset_0;

  wire Ron10_0;
  wire Ron1_0;
  wire Ron5_0;
  wire Ron_rest1_0;
  wire Ron_rest5_0;
  wire SANDWICH_0;
  wire clk_0;
  wire reset_0;

  design_1 design_1_i
       (.Ron10_0(Ron10_0),
        .Ron1_0(Ron1_0),
        .Ron5_0(Ron5_0),
        .Ron_rest1_0(Ron_rest1_0),
        .Ron_rest5_0(Ron_rest5_0),
        .SANDWICH_0(SANDWICH_0),
        .clk_0(clk_0),
        .reset_0(reset_0));
endmodule
