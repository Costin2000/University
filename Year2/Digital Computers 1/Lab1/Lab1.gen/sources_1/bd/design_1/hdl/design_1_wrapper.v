//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed Mar 17 09:57:10 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (A,
    B,
    C,
    D);
  input [0:0]A;
  input [0:0]B;
  input [0:0]C;
  output [0:0]D;

  wire [0:0]A;
  wire [0:0]B;
  wire [0:0]C;
  wire [0:0]D;

  design_1 design_1_i
       (.A(A),
        .B(B),
        .C(C),
        .D(D));
endmodule
