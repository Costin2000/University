//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed May 26 13:48:52 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target schema.bd
//Design      : schema
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "schema,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=schema,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=8,numReposBlks=8,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=8,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "schema.hwdef" *) 
module schema
   (INPUT_0,
    a_0,
    b_0,
    clk_0,
    iesire_0,
    load_0,
    reset_0);
  input INPUT_0;
  input a_0;
  input b_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET reset_0, CLK_DOMAIN schema_clk_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  output iesire_0;
  input load_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input reset_0;

  wire INPUT_0_1;
  wire a_0_1;
  wire b_0_1;
  wire clk_0_1;
  wire load_0_1;
  wire orGate_0_iesire;
  wire orGate_1_iesire;
  wire orGate_2_iesire;
  wire registruTampon_0_iesire;
  wire registruTampon_1_iesire;
  wire registruTampon_2_iesire;
  wire registruTampon_3_iesire;
  wire registruTampon_4_iesire;
  wire reset_0_1;

  assign INPUT_0_1 = INPUT_0;
  assign a_0_1 = a_0;
  assign b_0_1 = b_0;
  assign clk_0_1 = clk_0;
  assign iesire_0 = registruTampon_4_iesire;
  assign load_0_1 = load_0;
  assign reset_0_1 = reset_0;
  schema_orGate_0_0 orGate_0
       (.a(a_0_1),
        .b(b_0_1),
        .iesire(orGate_0_iesire));
  schema_orGate_1_0 orGate_1
       (.a(registruTampon_0_iesire),
        .b(registruTampon_1_iesire),
        .iesire(orGate_1_iesire));
  schema_orGate_2_0 orGate_2
       (.a(registruTampon_3_iesire),
        .b(registruTampon_2_iesire),
        .iesire(orGate_2_iesire));
  schema_registruTampon_0_0 registruTampon_0
       (.clk(clk_0_1),
        .iesire(registruTampon_0_iesire),
        .intrare(orGate_0_iesire),
        .load(load_0_1),
        .reset(reset_0_1));
  schema_registruTampon_1_0 registruTampon_1
       (.clk(clk_0_1),
        .iesire(registruTampon_1_iesire),
        .intrare(INPUT_0_1),
        .load(load_0_1),
        .reset(reset_0_1));
  schema_registruTampon_2_0 registruTampon_2
       (.clk(clk_0_1),
        .iesire(registruTampon_2_iesire),
        .intrare(orGate_1_iesire),
        .load(load_0_1),
        .reset(reset_0_1));
  schema_registruTampon_3_0 registruTampon_3
       (.clk(clk_0_1),
        .iesire(registruTampon_3_iesire),
        .intrare(registruTampon_0_iesire),
        .load(load_0_1),
        .reset(reset_0_1));
  schema_registruTampon_4_0 registruTampon_4
       (.clk(clk_0_1),
        .iesire(registruTampon_4_iesire),
        .intrare(orGate_2_iesire),
        .load(load_0_1),
        .reset(reset_0_1));
endmodule
