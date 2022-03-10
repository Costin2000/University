//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Mon Apr 12 20:01:48 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema.bd
//Design      : Schema
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Schema,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Schema,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "Schema.hwdef" *) 
module Schema
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN Schema_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  input mancare1_0;
  input mancare2_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;
  input vreauRest_0;

  wire Automat_0_Aliment1;
  wire Automat_0_Aliment2;
  wire Automat_0_REST1;
  wire Automat_0_REST2;
  wire Automat_0_REST3;
  wire Automat_0_REST4;
  wire Automat_0_REST5;
  wire Automat_0_Suc1;
  wire Automat_0_Suc2;
  wire Lei10_0_1;
  wire Lei5_0_1;
  wire Leu1_0_1;
  wire bautura1_0_1;
  wire bautura2_0_1;
  wire clk_0_1;
  wire mancare1_0_1;
  wire mancare2_0_1;
  wire reset_0_1;
  wire vreauRest_0_1;

  assign Aliment1_0 = Automat_0_Aliment1;
  assign Aliment2_0 = Automat_0_Aliment2;
  assign Lei10_0_1 = Lei10_0;
  assign Lei5_0_1 = Lei5_0;
  assign Leu1_0_1 = Leu1_0;
  assign REST1_0 = Automat_0_REST1;
  assign REST2_0 = Automat_0_REST2;
  assign REST3_0 = Automat_0_REST3;
  assign REST4_0 = Automat_0_REST4;
  assign REST5_0 = Automat_0_REST5;
  assign Suc1_0 = Automat_0_Suc1;
  assign Suc2_0 = Automat_0_Suc2;
  assign bautura1_0_1 = bautura1_0;
  assign bautura2_0_1 = bautura2_0;
  assign clk_0_1 = clk_0;
  assign mancare1_0_1 = mancare1_0;
  assign mancare2_0_1 = mancare2_0;
  assign reset_0_1 = reset_0;
  assign vreauRest_0_1 = vreauRest_0;
  Schema_Automat_0_0 Automat_0
       (.Aliment1(Automat_0_Aliment1),
        .Aliment2(Automat_0_Aliment2),
        .Lei10(Lei10_0_1),
        .Lei5(Lei5_0_1),
        .Leu1(Leu1_0_1),
        .REST1(Automat_0_REST1),
        .REST2(Automat_0_REST2),
        .REST3(Automat_0_REST3),
        .REST4(Automat_0_REST4),
        .REST5(Automat_0_REST5),
        .Suc1(Automat_0_Suc1),
        .Suc2(Automat_0_Suc2),
        .bautura1(bautura1_0_1),
        .bautura2(bautura2_0_1),
        .clk(clk_0_1),
        .mancare1(mancare1_0_1),
        .mancare2(mancare2_0_1),
        .reset(reset_0_1),
        .vreauRest(vreauRest_0_1));
endmodule
