//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu May 27 06:50:27 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=19,numReposBlks=19,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=19,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (clear_0,
    clock_0,
    exp1_0,
    exp2_0,
    load_0,
    mant1_0,
    mant2_0,
    op_0,
    rout_0,
    rout_1);
  input clear_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLOCK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLOCK_0, CLK_DOMAIN design_1_clock_0, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clock_0;
  input [7:0]exp1_0;
  input [7:0]exp2_0;
  input load_0;
  input [23:0]mant1_0;
  input [23:0]mant2_0;
  input op_0;
  output [23:0]rout_0;
  output [7:0]rout_1;

  wire [15:0]M1_0_rez;
  wire [8:0]M1_0_rez2;
  wire [7:0]M2_0_rez;
  wire [7:0]M3_0_rez;
  wire [47:0]M4_0_mantRez;
  wire [25:0]M5_0_mantRez;
  wire [23:0]M6_0_mfinal;
  wire [8:0]M6_0_val2;
  wire [56:0]M7_0_mantsRez;
  wire clear_0_1;
  wire clock_0_1;
  wire [15:0]concatExp_0_rez;
  wire [47:0]concatMantise_0_rez;
  wire [7:0]exp1_0_1;
  wire [7:0]exp2_0_1;
  wire load_0_1;
  wire [23:0]mant1_0_1;
  wire [23:0]mant2_0_1;
  wire op_0_1;
  wire [15:0]reg16_0_rout;
  wire [15:0]reg16_1_rout;
  wire [23:0]reg23_0_rout;
  wire [25:0]reg25_0_rout;
  wire [47:0]reg47_0_rout;
  wire [47:0]reg47_1_rout;
  wire [56:0]reg56_0_rout;
  wire [7:0]reg7_0_rout;
  wire [7:0]reg7_1_rout;
  wire [7:0]reg7_2_rout;

  assign clear_0_1 = clear_0;
  assign clock_0_1 = clock_0;
  assign exp1_0_1 = exp1_0[7:0];
  assign exp2_0_1 = exp2_0[7:0];
  assign load_0_1 = load_0;
  assign mant1_0_1 = mant1_0[23:0];
  assign mant2_0_1 = mant2_0[23:0];
  assign op_0_1 = op_0;
  assign rout_0[23:0] = reg23_0_rout;
  assign rout_1[7:0] = reg7_2_rout;
  design_1_M1_0_0 M1_0
       (.exp(reg16_0_rout),
        .rez(M1_0_rez),
        .rez2(M1_0_rez2));
  design_1_M2_0_0 M2_0
       (.exp(reg16_1_rout),
        .rez(M2_0_rez));
  design_1_M3_0_0 M3_0
       (.exp(reg7_1_rout),
        .rez(M3_0_rez),
        .val(M6_0_val2));
  design_1_M4_0_0 M4_0
       (.mant(reg56_0_rout),
        .mantRez(M4_0_mantRez));
  design_1_M5_0_1 M5_0
       (.mant(reg47_1_rout),
        .mantRez(M5_0_mantRez),
        .op(op_0_1));
  design_1_M6_0_0 M6_0
       (.mant(reg25_0_rout),
        .mfinal(M6_0_mfinal),
        .val2(M6_0_val2));
  design_1_M7_0_0 M7_0
       (.mants(reg47_0_rout),
        .mantsRez(M7_0_mantsRez),
        .val(M1_0_rez2));
  design_1_concatExp_0_0 concatExp_0
       (.exp1(exp1_0_1),
        .exp2(exp2_0_1),
        .rez(concatExp_0_rez));
  design_1_concatMantise_0_0 concatMantise_0
       (.mant1(mant1_0_1),
        .mant2(mant2_0_1),
        .rez(concatMantise_0_rez));
  design_1_reg16_0_0 reg16_0
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(concatExp_0_rez),
        .rout(reg16_0_rout));
  design_1_reg16_1_0 reg16_1
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(M1_0_rez),
        .rout(reg16_1_rout));
  design_1_reg23_0_0 reg23_0
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(M6_0_mfinal),
        .rout(reg23_0_rout));
  design_1_reg25_0_0 reg25_0
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(M5_0_mantRez),
        .rout(reg25_0_rout));
  design_1_reg47_0_0 reg47_0
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(concatMantise_0_rez),
        .rout(reg47_0_rout));
  design_1_reg47_1_0 reg47_1
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(M4_0_mantRez),
        .rout(reg47_1_rout));
  design_1_reg56_0_0 reg56_0
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(M7_0_mantsRez),
        .rout(reg56_0_rout));
  design_1_reg7_0_0 reg7_0
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(M2_0_rez),
        .rout(reg7_0_rout));
  design_1_reg7_1_0 reg7_1
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(reg7_0_rout),
        .rout(reg7_1_rout));
  design_1_reg7_2_0 reg7_2
       (.clear(clear_0_1),
        .clock(clock_0_1),
        .load(load_0_1),
        .rin(M3_0_rez),
        .rout(reg7_2_rout));
endmodule
