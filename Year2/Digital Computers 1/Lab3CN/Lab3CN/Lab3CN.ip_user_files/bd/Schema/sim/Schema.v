//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu Apr 15 10:51:28 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema.bd
//Design      : Schema
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Schema,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Schema,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "Schema.hwdef" *) 
module Schema
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN Schema_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;
  input wantCola_0;
  input wantFanta_0;
  input wantRest_0;

  wire Automat_0_Cola;
  wire Automat_0_Fanta;
  wire Automat_0_R1;
  wire Automat_0_R10;
  wire Automat_0_R5;
  wire L10_0_1;
  wire L1_0_1;
  wire L5_0_1;
  wire clk_0_1;
  wire reset_0_1;
  wire wantCola_0_1;
  wire wantFanta_0_1;
  wire wantRest_0_1;

  assign Cola_0 = Automat_0_Cola;
  assign Fanta_0 = Automat_0_Fanta;
  assign L10_0_1 = L10_0;
  assign L1_0_1 = L1_0;
  assign L5_0_1 = L5_0;
  assign R10_0 = Automat_0_R10;
  assign R1_0 = Automat_0_R1;
  assign R5_0 = Automat_0_R5;
  assign clk_0_1 = clk_0;
  assign reset_0_1 = reset_0;
  assign wantCola_0_1 = wantCola_0;
  assign wantFanta_0_1 = wantFanta_0;
  assign wantRest_0_1 = wantRest_0;
  Schema_Automat_0_0 Automat_0
       (.Cola(Automat_0_Cola),
        .Fanta(Automat_0_Fanta),
        .L1(L1_0_1),
        .L10(L10_0_1),
        .L5(L5_0_1),
        .R1(Automat_0_R1),
        .R10(Automat_0_R10),
        .R5(Automat_0_R5),
        .clk(clk_0_1),
        .reset(reset_0_1),
        .wantCola(wantCola_0_1),
        .wantFanta(wantFanta_0_1),
        .wantRest(wantRest_0_1));
endmodule
