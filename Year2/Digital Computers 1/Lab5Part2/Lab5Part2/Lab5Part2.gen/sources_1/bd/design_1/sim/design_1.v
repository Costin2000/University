//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Thu May 27 12:39:50 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=8,numReposBlks=8,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=8,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (a_0,
    b_0,
    clk_0,
    enable_0,
    iesire_0,
    intrare_0,
    reset_0);
  input a_0;
  input b_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN design_1_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  input enable_0;
  output iesire_0;
  input intrare_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;

  wire ANDGate_0_c;
  wire ANDGate_1_c;
  wire ANDGate_2_c;
  wire a_0_1;
  wire b_0_1;
  wire clk_0_1;
  wire enable_0_1;
  wire intrare_0_1;
  wire memoryBuffer_0_iesire;
  wire memoryBuffer_1_iesire;
  wire memoryBuffer_2_iesire;
  wire memoryBuffer_3_iesire;
  wire memoryBuffer_4_iesire;
  wire reset_0_1;

  assign a_0_1 = a_0;
  assign b_0_1 = b_0;
  assign clk_0_1 = clk_0;
  assign enable_0_1 = enable_0;
  assign iesire_0 = memoryBuffer_4_iesire;
  assign intrare_0_1 = intrare_0;
  assign reset_0_1 = reset_0;
  design_1_ANDGate_0_0 ANDGate_0
       (.a(a_0_1),
        .b(b_0_1),
        .c(ANDGate_0_c));
  design_1_ANDGate_1_0 ANDGate_1
       (.a(memoryBuffer_0_iesire),
        .b(memoryBuffer_1_iesire),
        .c(ANDGate_1_c));
  design_1_ANDGate_2_0 ANDGate_2
       (.a(memoryBuffer_3_iesire),
        .b(memoryBuffer_2_iesire),
        .c(ANDGate_2_c));
  design_1_memoryBuffer_0_0 memoryBuffer_0
       (.clk(clk_0_1),
        .enable(enable_0_1),
        .iesire(memoryBuffer_0_iesire),
        .intrare(ANDGate_0_c),
        .reset(reset_0_1));
  design_1_memoryBuffer_1_0 memoryBuffer_1
       (.clk(clk_0_1),
        .enable(enable_0_1),
        .iesire(memoryBuffer_1_iesire),
        .intrare(intrare_0_1),
        .reset(reset_0_1));
  design_1_memoryBuffer_2_0 memoryBuffer_2
       (.clk(clk_0_1),
        .enable(enable_0_1),
        .iesire(memoryBuffer_2_iesire),
        .intrare(ANDGate_1_c),
        .reset(reset_0_1));
  design_1_memoryBuffer_3_0 memoryBuffer_3
       (.clk(clk_0_1),
        .enable(enable_0_1),
        .iesire(memoryBuffer_3_iesire),
        .intrare(memoryBuffer_0_iesire),
        .reset(reset_0_1));
  design_1_memoryBuffer_4_0 memoryBuffer_4
       (.clk(clk_0_1),
        .enable(enable_0_1),
        .iesire(memoryBuffer_4_iesire),
        .intrare(ANDGate_2_c),
        .reset(reset_0_1));
endmodule
