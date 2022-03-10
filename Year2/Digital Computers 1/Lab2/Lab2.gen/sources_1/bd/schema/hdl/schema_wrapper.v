//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu Apr  8 10:09:17 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target schema_wrapper.bd
//Design      : schema_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module schema_wrapper
   (BCD0_0,
    BCD0_1,
    BCD1_0,
    BCD1_1,
    clk_out_led_0,
    data_0,
    load_0,
    pauza_0,
    reset_0,
    sens_0);
  output [3:0]BCD0_0;
  output [3:0]BCD0_1;
  output [3:0]BCD1_0;
  output [3:0]BCD1_1;
  input clk_out_led_0;
  input [5:0]data_0;
  input load_0;
  input pauza_0;
  input reset_0;
  input sens_0;

  wire [3:0]BCD0_0;
  wire [3:0]BCD0_1;
  wire [3:0]BCD1_0;
  wire [3:0]BCD1_1;
  wire clk_out_led_0;
  wire [5:0]data_0;
  wire load_0;
  wire pauza_0;
  wire reset_0;
  wire sens_0;

  schema schema_i
       (.BCD0_0(BCD0_0),
        .BCD0_1(BCD0_1),
        .BCD1_0(BCD1_0),
        .BCD1_1(BCD1_1),
        .clk_out_led_0(clk_out_led_0),
        .data_0(data_0),
        .load_0(load_0),
        .pauza_0(pauza_0),
        .reset_0(reset_0),
        .sens_0(sens_0));
endmodule
