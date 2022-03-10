//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Mon Apr 12 09:41:16 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema.bd
//Design      : Schema
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Schema,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Schema,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "Schema.hwdef" *) 
module Schema
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN Schema_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;

  wire Automat_0_REST1;
  wire Automat_0_REST5;
  wire Automat_0_SUC;
  wire B10_0_1;
  wire B1_0_1;
  wire B5_0_1;
  wire clk_0_1;
  wire reset_0_1;

  assign B10_0_1 = B10_0;
  assign B1_0_1 = B1_0;
  assign B5_0_1 = B5_0;
  assign REST1_0 = Automat_0_REST1;
  assign REST5_0 = Automat_0_REST5;
  assign SUC_0 = Automat_0_SUC;
  assign clk_0_1 = clk_0;
  assign reset_0_1 = reset_0;
  Schema_Automat_0_0 Automat_0
       (.B1(B1_0_1),
        .B10(B10_0_1),
        .B5(B5_0_1),
        .REST1(Automat_0_REST1),
        .REST5(Automat_0_REST5),
        .SUC(Automat_0_SUC),
        .clk(clk_0_1),
        .reset(reset_0_1));
endmodule
