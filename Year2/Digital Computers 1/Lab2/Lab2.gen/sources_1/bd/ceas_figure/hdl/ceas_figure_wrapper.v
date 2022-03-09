//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Thu Jun  3 13:19:12 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target ceas_figure_wrapper.bd
//Design      : ceas_figure_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ceas_figure_wrapper
   (BCD0_0,
    BCD0_1,
    BCD1_0,
    BCD1_1,
    clk_out_led_0,
    data_0,
    direction_0,
    load_0,
    pauza_0,
    reset_0);
  output [3:0]BCD0_0;
  output [3:0]BCD0_1;
  output [3:0]BCD1_0;
  output [3:0]BCD1_1;
  input clk_out_led_0;
  input [5:0]data_0;
  input direction_0;
  input load_0;
  input pauza_0;
  input reset_0;

  wire [3:0]BCD0_0;
  wire [3:0]BCD0_1;
  wire [3:0]BCD1_0;
  wire [3:0]BCD1_1;
  wire clk_out_led_0;
  wire [5:0]data_0;
  wire direction_0;
  wire load_0;
  wire pauza_0;
  wire reset_0;

  ceas_figure ceas_figure_i
       (.BCD0_0(BCD0_0),
        .BCD0_1(BCD0_1),
        .BCD1_0(BCD1_0),
        .BCD1_1(BCD1_1),
        .clk_out_led_0(clk_out_led_0),
        .data_0(data_0),
        .direction_0(direction_0),
        .load_0(load_0),
        .pauza_0(pauza_0),
        .reset_0(reset_0));
endmodule
