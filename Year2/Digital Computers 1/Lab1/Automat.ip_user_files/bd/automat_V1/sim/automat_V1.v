//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Tue Jun  1 21:26:09 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target automat_V1.bd
//Design      : automat_V1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "automat_V1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=automat_V1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "automat_V1.hwdef" *) 
module automat_V1
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLOCK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLOCK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN automat_V1_clock_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clock_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;
  output [2:0]stare_0;

  wire Rest_0_1;
  wire Ron10_0_1;
  wire Ron1_0_1;
  wire Ron5_0_1;
  wire automat_0_Ceai;
  wire automat_0_Procesare;
  wire automat_0_Rest1;
  wire automat_0_Rest5;
  wire [2:0]automat_0_stare;
  wire clock_0_1;
  wire reset_0_1;

  assign Ceai_0 = automat_0_Ceai;
  assign Procesare_0 = automat_0_Procesare;
  assign Rest1_0 = automat_0_Rest1;
  assign Rest5_0 = automat_0_Rest5;
  assign Rest_0_1 = Rest_0;
  assign Ron10_0_1 = Ron10_0;
  assign Ron1_0_1 = Ron1_0;
  assign Ron5_0_1 = Ron5_0;
  assign clock_0_1 = clock_0;
  assign reset_0_1 = reset_0;
  assign stare_0[2:0] = automat_0_stare;
  automat_V1_automat_0_0 automat_0
       (.Ceai(automat_0_Ceai),
        .Procesare(automat_0_Procesare),
        .Rest(Rest_0_1),
        .Rest1(automat_0_Rest1),
        .Rest5(automat_0_Rest5),
        .Ron1(Ron1_0_1),
        .Ron10(Ron10_0_1),
        .Ron5(Ron5_0_1),
        .clock(clock_0_1),
        .reset(reset_0_1),
        .stare(automat_0_stare));
endmodule
