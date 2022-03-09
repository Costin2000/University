//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Thu Apr 15 10:47:46 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN design_1_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;

  wire Automat_0_Ron_rest1;
  wire Automat_0_Ron_rest5;
  wire Automat_0_SANDWICH;
  wire Ron10_0_1;
  wire Ron1_0_1;
  wire Ron5_0_1;
  wire clk_0_1;
  wire reset_0_1;

  assign Ron10_0_1 = Ron10_0;
  assign Ron1_0_1 = Ron1_0;
  assign Ron5_0_1 = Ron5_0;
  assign Ron_rest1_0 = Automat_0_Ron_rest1;
  assign Ron_rest5_0 = Automat_0_Ron_rest5;
  assign SANDWICH_0 = Automat_0_SANDWICH;
  assign clk_0_1 = clk_0;
  assign reset_0_1 = reset_0;
  design_1_Automat_0_0 Automat_0
       (.Ron1(Ron1_0_1),
        .Ron10(Ron10_0_1),
        .Ron5(Ron5_0_1),
        .Ron_rest1(Automat_0_Ron_rest1),
        .Ron_rest5(Automat_0_Ron_rest5),
        .SANDWICH(Automat_0_SANDWICH),
        .clk(clk_0_1),
        .reset(reset_0_1));
endmodule
