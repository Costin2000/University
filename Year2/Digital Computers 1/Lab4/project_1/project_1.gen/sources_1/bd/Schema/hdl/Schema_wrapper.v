//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed May 19 16:38:52 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema_wrapper.bd
//Design      : Schema_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Schema_wrapper
   (GUAT_G_0,
    GUAT_P_0,
    a_0,
    a_1,
    b_0,
    cin_0,
    o4_0);
  output GUAT_G_0;
  output GUAT_P_0;
  input [15:0]a_0;
  output [15:0]a_1;
  input [15:0]b_0;
  input cin_0;
  output o4_0;

  wire GUAT_G_0;
  wire GUAT_P_0;
  wire [15:0]a_0;
  wire [15:0]a_1;
  wire [15:0]b_0;
  wire cin_0;
  wire o4_0;

  Schema Schema_i
       (.GUAT_G_0(GUAT_G_0),
        .GUAT_P_0(GUAT_P_0),
        .a_0(a_0),
        .a_1(a_1),
        .b_0(b_0),
        .cin_0(cin_0),
        .o4_0(o4_0));
endmodule
