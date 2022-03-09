//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Tue Jun  1 21:26:10 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target automat_V1_wrapper.bd
//Design      : automat_V1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module automat_V1_wrapper
   (Ceai_0,
    Procesare_0,
    Rest1_0,
    Rest5_0,
    Rest_0,
    Ron10_0,
    Ron1_0,
    Ron5_0,
    clock_0,
    reset_0,
    stare_0);
  output Ceai_0;
  output Procesare_0;
  output Rest1_0;
  output Rest5_0;
  input Rest_0;
  input Ron10_0;
  input Ron1_0;
  input Ron5_0;
  input clock_0;
  input reset_0;
  output [2:0]stare_0;

  wire Ceai_0;
  wire Procesare_0;
  wire Rest1_0;
  wire Rest5_0;
  wire Rest_0;
  wire Ron10_0;
  wire Ron1_0;
  wire Ron5_0;
  wire clock_0;
  wire reset_0;
  wire [2:0]stare_0;

  automat_V1 automat_V1_i
       (.Ceai_0(Ceai_0),
        .Procesare_0(Procesare_0),
        .Rest1_0(Rest1_0),
        .Rest5_0(Rest5_0),
        .Rest_0(Rest_0),
        .Ron10_0(Ron10_0),
        .Ron1_0(Ron1_0),
        .Ron5_0(Ron5_0),
        .clock_0(clock_0),
        .reset_0(reset_0),
        .stare_0(stare_0));
endmodule
