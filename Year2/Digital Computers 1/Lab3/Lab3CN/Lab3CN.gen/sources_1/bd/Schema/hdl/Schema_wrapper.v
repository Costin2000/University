//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Mon Apr 12 20:01:48 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema_wrapper.bd
//Design      : Schema_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Schema_wrapper
   (Aliment1_0,
    Aliment2_0,
    Lei10_0,
    Lei5_0,
    Leu1_0,
    REST1_0,
    REST2_0,
    REST3_0,
    REST4_0,
    REST5_0,
    Suc1_0,
    Suc2_0,
    bautura1_0,
    bautura2_0,
    clk_0,
    mancare1_0,
    mancare2_0,
    reset_0,
    vreauRest_0);
  output Aliment1_0;
  output Aliment2_0;
  input Lei10_0;
  input Lei5_0;
  input Leu1_0;
  output REST1_0;
  output REST2_0;
  output REST3_0;
  output REST4_0;
  output REST5_0;
  output Suc1_0;
  output Suc2_0;
  input bautura1_0;
  input bautura2_0;
  input clk_0;
  input mancare1_0;
  input mancare2_0;
  input reset_0;
  input vreauRest_0;

  wire Aliment1_0;
  wire Aliment2_0;
  wire Lei10_0;
  wire Lei5_0;
  wire Leu1_0;
  wire REST1_0;
  wire REST2_0;
  wire REST3_0;
  wire REST4_0;
  wire REST5_0;
  wire Suc1_0;
  wire Suc2_0;
  wire bautura1_0;
  wire bautura2_0;
  wire clk_0;
  wire mancare1_0;
  wire mancare2_0;
  wire reset_0;
  wire vreauRest_0;

  Schema Schema_i
       (.Aliment1_0(Aliment1_0),
        .Aliment2_0(Aliment2_0),
        .Lei10_0(Lei10_0),
        .Lei5_0(Lei5_0),
        .Leu1_0(Leu1_0),
        .REST1_0(REST1_0),
        .REST2_0(REST2_0),
        .REST3_0(REST3_0),
        .REST4_0(REST4_0),
        .REST5_0(REST5_0),
        .Suc1_0(Suc1_0),
        .Suc2_0(Suc2_0),
        .bautura1_0(bautura1_0),
        .bautura2_0(bautura2_0),
        .clk_0(clk_0),
        .mancare1_0(mancare1_0),
        .mancare2_0(mancare2_0),
        .reset_0(reset_0),
        .vreauRest_0(vreauRest_0));
endmodule
