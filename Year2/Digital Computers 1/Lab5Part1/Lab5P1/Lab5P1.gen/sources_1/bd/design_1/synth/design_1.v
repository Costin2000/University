//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Wed May 26 15:46:49 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=8,numReposBlks=8,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=8,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (clock_0,
    enable_0,
    reset_0,
    result_0,
    t_0,
    x_0,
    y_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLOCK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLOCK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN design_1_clock_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clock_0;
  input enable_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;
  output result_0;
  input t_0;
  input x_0;
  input y_0;

  wire clock_0_1;
  wire enable_0_1;
  wire gateXOR_0_result;
  wire gateXOR_1_result;
  wire gateXOR_2_result;
  wire registruBuffer_0_result;
  wire registruBuffer_1_result;
  wire registruBuffer_2_result;
  wire registruBuffer_3_result;
  wire registruBuffer_4_result;
  wire reset_0_1;
  wire t_0_1;
  wire x_0_1;
  wire y_0_1;

  assign clock_0_1 = clock_0;
  assign enable_0_1 = enable_0;
  assign reset_0_1 = reset_0;
  assign result_0 = registruBuffer_4_result;
  assign t_0_1 = t_0;
  assign x_0_1 = x_0;
  assign y_0_1 = y_0;
  design_1_gateXOR_0_0 gateXOR_0
       (.result(gateXOR_0_result),
        .t(t_0_1),
        .x(x_0_1));
  design_1_gateXOR_1_0 gateXOR_1
       (.result(gateXOR_1_result),
        .t(registruBuffer_1_result),
        .x(registruBuffer_0_result));
  design_1_gateXOR_2_0 gateXOR_2
       (.result(gateXOR_2_result),
        .t(registruBuffer_2_result),
        .x(registruBuffer_3_result));
  design_1_registruBuffer_0_0 registruBuffer_0
       (.clock(clock_0_1),
        .enable(enable_0_1),
        .reset(reset_0_1),
        .result(registruBuffer_0_result),
        .y(gateXOR_0_result));
  design_1_registruBuffer_1_0 registruBuffer_1
       (.clock(clock_0_1),
        .enable(enable_0_1),
        .reset(reset_0_1),
        .result(registruBuffer_1_result),
        .y(y_0_1));
  design_1_registruBuffer_2_0 registruBuffer_2
       (.clock(clock_0_1),
        .enable(enable_0_1),
        .reset(reset_0_1),
        .result(registruBuffer_2_result),
        .y(gateXOR_1_result));
  design_1_registruBuffer_3_0 registruBuffer_3
       (.clock(clock_0_1),
        .enable(enable_0_1),
        .reset(reset_0_1),
        .result(registruBuffer_3_result),
        .y(registruBuffer_0_result));
  design_1_registruBuffer_4_0 registruBuffer_4
       (.clock(clock_0_1),
        .enable(enable_0_1),
        .reset(reset_0_1),
        .result(registruBuffer_4_result),
        .y(gateXOR_2_result));
endmodule
