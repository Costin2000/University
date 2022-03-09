//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Wed May 19 21:12:45 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=35,numReposBlks=35,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=35,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (GUAT_G_0,
    GUAT_P_0,
    a_0,
    b_0,
    c_in_0,
    carry4_0,
    sum_0);
  output GUAT_G_0;
  output GUAT_P_0;
  input [15:0]a_0;
  input [15:0]b_0;
  input c_in_0;
  output carry4_0;
  output [15:0]sum_0;

  wire GUAT_0_GUAT_G;
  wire GUAT_0_GUAT_P;
  wire [4:1]GUAT_0_carry_GUAT;
  wire UAT_0_UAT_G;
  wire UAT_0_UAT_P;
  wire [3:0]UAT_0_carry_UAT;
  wire UAT_1_UAT_G;
  wire UAT_1_UAT_P;
  wire [3:0]UAT_1_carry_UAT;
  wire UAT_2_UAT_G;
  wire UAT_2_UAT_P;
  wire [3:0]UAT_2_carry_UAT;
  wire UAT_3_UAT_G;
  wire UAT_3_UAT_P;
  wire [3:0]UAT_3_carry_UAT;
  wire [15:0]a_0_1;
  wire [15:0]b_0_1;
  wire c_in_0_1;
  wire defalcare_UAT_0_c_in_0;
  wire defalcare_UAT_0_c_in_1;
  wire defalcare_UAT_0_c_in_2;
  wire defalcare_UAT_1_c_in_0;
  wire defalcare_UAT_1_c_in_1;
  wire defalcare_UAT_1_c_in_2;
  wire defalcare_UAT_2_c_in_0;
  wire defalcare_UAT_2_c_in_1;
  wire defalcare_UAT_2_c_in_2;
  wire defalcare_UAT_3_c_in_0;
  wire defalcare_UAT_3_c_in_1;
  wire defalcare_UAT_3_c_in_2;
  wire [3:0]modul_concat_sum_0_g_out;
  wire [3:0]modul_concat_sum_0_p_out;
  wire [3:0]modul_concat_sum_1_g_out;
  wire [3:0]modul_concat_sum_1_p_out;
  wire [3:0]modul_concat_sum_2_g_out;
  wire [3:0]modul_concat_sum_2_p_out;
  wire [3:0]modul_concat_sum_3_g_out;
  wire [3:0]modul_concat_sum_3_p_out;
  wire [3:0]modul_concat_uat_0_uat_g;
  wire [3:0]modul_concat_uat_0_uat_p;
  wire modul_defalcare_0_a1;
  wire modul_defalcare_0_a10;
  wire modul_defalcare_0_a11;
  wire modul_defalcare_0_a12;
  wire modul_defalcare_0_a13;
  wire modul_defalcare_0_a14;
  wire modul_defalcare_0_a15;
  wire modul_defalcare_0_a16;
  wire modul_defalcare_0_a2;
  wire modul_defalcare_0_a3;
  wire modul_defalcare_0_a4;
  wire modul_defalcare_0_a5;
  wire modul_defalcare_0_a6;
  wire modul_defalcare_0_a7;
  wire modul_defalcare_0_a8;
  wire modul_defalcare_0_a9;
  wire modul_defalcare_1_a1;
  wire modul_defalcare_1_a10;
  wire modul_defalcare_1_a11;
  wire modul_defalcare_1_a12;
  wire modul_defalcare_1_a13;
  wire modul_defalcare_1_a14;
  wire modul_defalcare_1_a15;
  wire modul_defalcare_1_a16;
  wire modul_defalcare_1_a2;
  wire modul_defalcare_1_a3;
  wire modul_defalcare_1_a4;
  wire modul_defalcare_1_a5;
  wire modul_defalcare_1_a6;
  wire modul_defalcare_1_a7;
  wire modul_defalcare_1_a8;
  wire modul_defalcare_1_a9;
  wire [15:0]modul_input_0_a_out;
  wire [15:0]modul_input_0_b_out;
  wire modul_input_0_c_in_out;
  wire [15:0]modul_refacere_suma_0_sum;
  wire splitter_GUAT_0_carry1;
  wire splitter_GUAT_0_carry2;
  wire splitter_GUAT_0_carry3;
  wire splitter_GUAT_0_carry4;
  wire sumator_complet_1bit_0_g;
  wire sumator_complet_1bit_0_p;
  wire sumator_complet_1bit_0_sum;
  wire sumator_complet_1bit_10_g;
  wire sumator_complet_1bit_10_p;
  wire sumator_complet_1bit_10_sum;
  wire sumator_complet_1bit_11_g;
  wire sumator_complet_1bit_11_p;
  wire sumator_complet_1bit_11_sum;
  wire sumator_complet_1bit_12_g;
  wire sumator_complet_1bit_12_p;
  wire sumator_complet_1bit_12_sum;
  wire sumator_complet_1bit_13_g;
  wire sumator_complet_1bit_13_p;
  wire sumator_complet_1bit_13_sum;
  wire sumator_complet_1bit_14_g;
  wire sumator_complet_1bit_14_p;
  wire sumator_complet_1bit_14_sum;
  wire sumator_complet_1bit_15_g;
  wire sumator_complet_1bit_15_p;
  wire sumator_complet_1bit_15_sum;
  wire sumator_complet_1bit_1_g;
  wire sumator_complet_1bit_1_p;
  wire sumator_complet_1bit_1_sum;
  wire sumator_complet_1bit_2_g;
  wire sumator_complet_1bit_2_p;
  wire sumator_complet_1bit_2_sum;
  wire sumator_complet_1bit_3_g;
  wire sumator_complet_1bit_3_p;
  wire sumator_complet_1bit_3_sum;
  wire sumator_complet_1bit_4_g;
  wire sumator_complet_1bit_4_p;
  wire sumator_complet_1bit_4_sum;
  wire sumator_complet_1bit_5_g;
  wire sumator_complet_1bit_5_p;
  wire sumator_complet_1bit_5_sum;
  wire sumator_complet_1bit_6_g;
  wire sumator_complet_1bit_6_p;
  wire sumator_complet_1bit_6_sum;
  wire sumator_complet_1bit_7_g;
  wire sumator_complet_1bit_7_p;
  wire sumator_complet_1bit_7_sum;
  wire sumator_complet_1bit_8_g;
  wire sumator_complet_1bit_8_p;
  wire sumator_complet_1bit_8_sum;
  wire sumator_complet_1bit_9_g;
  wire sumator_complet_1bit_9_p;
  wire sumator_complet_1bit_9_sum;

  assign GUAT_G_0 = GUAT_0_GUAT_G;
  assign GUAT_P_0 = GUAT_0_GUAT_P;
  assign a_0_1 = a_0[15:0];
  assign b_0_1 = b_0[15:0];
  assign c_in_0_1 = c_in_0;
  assign carry4_0 = splitter_GUAT_0_carry4;
  assign sum_0[15:0] = modul_refacere_suma_0_sum;
  design_1_GUAT_0_0 GUAT_0
       (.GUAT_G(GUAT_0_GUAT_G),
        .GUAT_P(GUAT_0_GUAT_P),
        .UAT_G(modul_concat_uat_0_uat_g),
        .UAT_P(modul_concat_uat_0_uat_p),
        .c_in(modul_input_0_c_in_out),
        .carry_GUAT(GUAT_0_carry_GUAT));
  design_1_UAT_0_0 UAT_0
       (.UAT_G(UAT_0_UAT_G),
        .UAT_P(UAT_0_UAT_P),
        .c_in(modul_input_0_c_in_out),
        .carry_UAT(UAT_0_carry_UAT),
        .g_in(modul_concat_sum_0_g_out),
        .p_in(modul_concat_sum_0_p_out));
  design_1_UAT_1_0 UAT_1
       (.UAT_G(UAT_1_UAT_G),
        .UAT_P(UAT_1_UAT_P),
        .c_in(splitter_GUAT_0_carry1),
        .carry_UAT(UAT_1_carry_UAT),
        .g_in(modul_concat_sum_1_g_out),
        .p_in(modul_concat_sum_1_p_out));
  design_1_UAT_2_0 UAT_2
       (.UAT_G(UAT_2_UAT_G),
        .UAT_P(UAT_2_UAT_P),
        .c_in(splitter_GUAT_0_carry2),
        .carry_UAT(UAT_2_carry_UAT),
        .g_in(modul_concat_sum_2_g_out),
        .p_in(modul_concat_sum_2_p_out));
  design_1_UAT_3_0 UAT_3
       (.UAT_G(UAT_3_UAT_G),
        .UAT_P(UAT_3_UAT_P),
        .c_in(splitter_GUAT_0_carry3),
        .carry_UAT(UAT_3_carry_UAT),
        .g_in(modul_concat_sum_3_g_out),
        .p_in(modul_concat_sum_3_p_out));
  design_1_defalcare_UAT_0_0 defalcare_UAT_0
       (.c_UAT(UAT_0_carry_UAT),
        .c_in_0(defalcare_UAT_0_c_in_0),
        .c_in_1(defalcare_UAT_0_c_in_1),
        .c_in_2(defalcare_UAT_0_c_in_2));
  design_1_defalcare_UAT_1_0 defalcare_UAT_1
       (.c_UAT(UAT_1_carry_UAT),
        .c_in_0(defalcare_UAT_1_c_in_0),
        .c_in_1(defalcare_UAT_1_c_in_1),
        .c_in_2(defalcare_UAT_1_c_in_2));
  design_1_defalcare_UAT_2_0 defalcare_UAT_2
       (.c_UAT(UAT_2_carry_UAT),
        .c_in_0(defalcare_UAT_2_c_in_0),
        .c_in_1(defalcare_UAT_2_c_in_1),
        .c_in_2(defalcare_UAT_2_c_in_2));
  design_1_defalcare_UAT_3_0 defalcare_UAT_3
       (.c_UAT(UAT_3_carry_UAT),
        .c_in_0(defalcare_UAT_3_c_in_0),
        .c_in_1(defalcare_UAT_3_c_in_1),
        .c_in_2(defalcare_UAT_3_c_in_2));
  design_1_modul_concat_sum_0_0 modul_concat_sum_0
       (.g1(sumator_complet_1bit_0_g),
        .g2(sumator_complet_1bit_1_g),
        .g3(sumator_complet_1bit_2_g),
        .g4(sumator_complet_1bit_3_g),
        .g_out(modul_concat_sum_0_g_out),
        .p1(sumator_complet_1bit_0_p),
        .p2(sumator_complet_1bit_1_p),
        .p3(sumator_complet_1bit_2_p),
        .p4(sumator_complet_1bit_3_p),
        .p_out(modul_concat_sum_0_p_out));
  design_1_modul_concat_sum_1_0 modul_concat_sum_1
       (.g1(sumator_complet_1bit_4_g),
        .g2(sumator_complet_1bit_5_g),
        .g3(sumator_complet_1bit_6_g),
        .g4(sumator_complet_1bit_7_g),
        .g_out(modul_concat_sum_1_g_out),
        .p1(sumator_complet_1bit_4_p),
        .p2(sumator_complet_1bit_5_p),
        .p3(sumator_complet_1bit_6_p),
        .p4(sumator_complet_1bit_7_p),
        .p_out(modul_concat_sum_1_p_out));
  design_1_modul_concat_sum_2_0 modul_concat_sum_2
       (.g1(sumator_complet_1bit_8_g),
        .g2(sumator_complet_1bit_9_g),
        .g3(sumator_complet_1bit_10_g),
        .g4(sumator_complet_1bit_11_g),
        .g_out(modul_concat_sum_2_g_out),
        .p1(sumator_complet_1bit_8_p),
        .p2(sumator_complet_1bit_9_p),
        .p3(sumator_complet_1bit_10_p),
        .p4(sumator_complet_1bit_11_p),
        .p_out(modul_concat_sum_2_p_out));
  design_1_modul_concat_sum_3_0 modul_concat_sum_3
       (.g1(sumator_complet_1bit_12_g),
        .g2(sumator_complet_1bit_13_g),
        .g3(sumator_complet_1bit_14_g),
        .g4(sumator_complet_1bit_15_g),
        .g_out(modul_concat_sum_3_g_out),
        .p1(sumator_complet_1bit_12_p),
        .p2(sumator_complet_1bit_13_p),
        .p3(sumator_complet_1bit_14_p),
        .p4(sumator_complet_1bit_15_p),
        .p_out(modul_concat_sum_3_p_out));
  design_1_modul_concat_uat_0_0 modul_concat_uat_0
       (.g0(UAT_0_UAT_G),
        .g1(UAT_1_UAT_G),
        .g2(UAT_2_UAT_G),
        .g3(UAT_3_UAT_G),
        .p0(UAT_0_UAT_P),
        .p1(UAT_1_UAT_P),
        .p2(UAT_2_UAT_P),
        .p3(UAT_3_UAT_P),
        .uat_g(modul_concat_uat_0_uat_g),
        .uat_p(modul_concat_uat_0_uat_p));
  design_1_modul_defalcare_0_1 modul_defalcare_0
       (.a(modul_input_0_a_out),
        .a1(modul_defalcare_0_a1),
        .a10(modul_defalcare_0_a10),
        .a11(modul_defalcare_0_a11),
        .a12(modul_defalcare_0_a12),
        .a13(modul_defalcare_0_a13),
        .a14(modul_defalcare_0_a14),
        .a15(modul_defalcare_0_a15),
        .a16(modul_defalcare_0_a16),
        .a2(modul_defalcare_0_a2),
        .a3(modul_defalcare_0_a3),
        .a4(modul_defalcare_0_a4),
        .a5(modul_defalcare_0_a5),
        .a6(modul_defalcare_0_a6),
        .a7(modul_defalcare_0_a7),
        .a8(modul_defalcare_0_a8),
        .a9(modul_defalcare_0_a9));
  design_1_modul_defalcare_1_1 modul_defalcare_1
       (.a(modul_input_0_b_out),
        .a1(modul_defalcare_1_a1),
        .a10(modul_defalcare_1_a10),
        .a11(modul_defalcare_1_a11),
        .a12(modul_defalcare_1_a12),
        .a13(modul_defalcare_1_a13),
        .a14(modul_defalcare_1_a14),
        .a15(modul_defalcare_1_a15),
        .a16(modul_defalcare_1_a16),
        .a2(modul_defalcare_1_a2),
        .a3(modul_defalcare_1_a3),
        .a4(modul_defalcare_1_a4),
        .a5(modul_defalcare_1_a5),
        .a6(modul_defalcare_1_a6),
        .a7(modul_defalcare_1_a7),
        .a8(modul_defalcare_1_a8),
        .a9(modul_defalcare_1_a9));
  design_1_modul_input_0_1 modul_input_0
       (.a(a_0_1),
        .a_out(modul_input_0_a_out),
        .b(b_0_1),
        .b_out(modul_input_0_b_out),
        .c_in(c_in_0_1),
        .c_in_out(modul_input_0_c_in_out));
  design_1_modul_refacere_suma_0_0 modul_refacere_suma_0
       (.s0(sumator_complet_1bit_0_sum),
        .s1(sumator_complet_1bit_1_sum),
        .s10(sumator_complet_1bit_10_sum),
        .s11(sumator_complet_1bit_11_sum),
        .s12(sumator_complet_1bit_12_sum),
        .s13(sumator_complet_1bit_13_sum),
        .s14(sumator_complet_1bit_14_sum),
        .s15(sumator_complet_1bit_15_sum),
        .s2(sumator_complet_1bit_2_sum),
        .s3(sumator_complet_1bit_3_sum),
        .s4(sumator_complet_1bit_4_sum),
        .s5(sumator_complet_1bit_5_sum),
        .s6(sumator_complet_1bit_6_sum),
        .s7(sumator_complet_1bit_7_sum),
        .s8(sumator_complet_1bit_8_sum),
        .s9(sumator_complet_1bit_9_sum),
        .sum(modul_refacere_suma_0_sum));
  design_1_splitter_GUAT_0_0 splitter_GUAT_0
       (.carry1(splitter_GUAT_0_carry1),
        .carry2(splitter_GUAT_0_carry2),
        .carry3(splitter_GUAT_0_carry3),
        .carry4(splitter_GUAT_0_carry4),
        .carry_GUAT(GUAT_0_carry_GUAT));
  design_1_sumator_complet_1bit_0_1 sumator_complet_1bit_0
       (.a(modul_defalcare_0_a1),
        .b(modul_defalcare_1_a1),
        .c_in(modul_input_0_c_in_out),
        .g(sumator_complet_1bit_0_g),
        .p(sumator_complet_1bit_0_p),
        .sum(sumator_complet_1bit_0_sum));
  design_1_sumator_complet_1bit_1_0 sumator_complet_1bit_1
       (.a(modul_defalcare_0_a2),
        .b(modul_defalcare_1_a2),
        .c_in(defalcare_UAT_0_c_in_0),
        .g(sumator_complet_1bit_1_g),
        .p(sumator_complet_1bit_1_p),
        .sum(sumator_complet_1bit_1_sum));
  design_1_sumator_complet_1bit_10_0 sumator_complet_1bit_10
       (.a(modul_defalcare_0_a11),
        .b(modul_defalcare_1_a11),
        .c_in(defalcare_UAT_2_c_in_1),
        .g(sumator_complet_1bit_10_g),
        .p(sumator_complet_1bit_10_p),
        .sum(sumator_complet_1bit_10_sum));
  design_1_sumator_complet_1bit_11_0 sumator_complet_1bit_11
       (.a(modul_defalcare_0_a12),
        .b(modul_defalcare_1_a12),
        .c_in(defalcare_UAT_2_c_in_2),
        .g(sumator_complet_1bit_11_g),
        .p(sumator_complet_1bit_11_p),
        .sum(sumator_complet_1bit_11_sum));
  design_1_sumator_complet_1bit_12_0 sumator_complet_1bit_12
       (.a(modul_defalcare_0_a13),
        .b(modul_defalcare_1_a13),
        .c_in(splitter_GUAT_0_carry3),
        .g(sumator_complet_1bit_12_g),
        .p(sumator_complet_1bit_12_p),
        .sum(sumator_complet_1bit_12_sum));
  design_1_sumator_complet_1bit_13_0 sumator_complet_1bit_13
       (.a(modul_defalcare_0_a14),
        .b(modul_defalcare_1_a14),
        .c_in(defalcare_UAT_3_c_in_0),
        .g(sumator_complet_1bit_13_g),
        .p(sumator_complet_1bit_13_p),
        .sum(sumator_complet_1bit_13_sum));
  design_1_sumator_complet_1bit_14_0 sumator_complet_1bit_14
       (.a(modul_defalcare_0_a15),
        .b(modul_defalcare_1_a15),
        .c_in(defalcare_UAT_3_c_in_1),
        .g(sumator_complet_1bit_14_g),
        .p(sumator_complet_1bit_14_p),
        .sum(sumator_complet_1bit_14_sum));
  design_1_sumator_complet_1bit_15_0 sumator_complet_1bit_15
       (.a(modul_defalcare_0_a16),
        .b(modul_defalcare_1_a16),
        .c_in(defalcare_UAT_3_c_in_2),
        .g(sumator_complet_1bit_15_g),
        .p(sumator_complet_1bit_15_p),
        .sum(sumator_complet_1bit_15_sum));
  design_1_sumator_complet_1bit_2_1 sumator_complet_1bit_2
       (.a(modul_defalcare_0_a3),
        .b(modul_defalcare_1_a3),
        .c_in(defalcare_UAT_0_c_in_1),
        .g(sumator_complet_1bit_2_g),
        .p(sumator_complet_1bit_2_p),
        .sum(sumator_complet_1bit_2_sum));
  design_1_sumator_complet_1bit_3_0 sumator_complet_1bit_3
       (.a(modul_defalcare_0_a4),
        .b(modul_defalcare_1_a4),
        .c_in(defalcare_UAT_0_c_in_2),
        .g(sumator_complet_1bit_3_g),
        .p(sumator_complet_1bit_3_p),
        .sum(sumator_complet_1bit_3_sum));
  design_1_sumator_complet_1bit_4_1 sumator_complet_1bit_4
       (.a(modul_defalcare_0_a5),
        .b(modul_defalcare_1_a5),
        .c_in(splitter_GUAT_0_carry1),
        .g(sumator_complet_1bit_4_g),
        .p(sumator_complet_1bit_4_p),
        .sum(sumator_complet_1bit_4_sum));
  design_1_sumator_complet_1bit_5_0 sumator_complet_1bit_5
       (.a(modul_defalcare_0_a6),
        .b(modul_defalcare_1_a6),
        .c_in(defalcare_UAT_1_c_in_0),
        .g(sumator_complet_1bit_5_g),
        .p(sumator_complet_1bit_5_p),
        .sum(sumator_complet_1bit_5_sum));
  design_1_sumator_complet_1bit_6_0 sumator_complet_1bit_6
       (.a(modul_defalcare_0_a7),
        .b(modul_defalcare_1_a7),
        .c_in(defalcare_UAT_1_c_in_1),
        .g(sumator_complet_1bit_6_g),
        .p(sumator_complet_1bit_6_p),
        .sum(sumator_complet_1bit_6_sum));
  design_1_sumator_complet_1bit_7_0 sumator_complet_1bit_7
       (.a(modul_defalcare_0_a8),
        .b(modul_defalcare_1_a8),
        .c_in(defalcare_UAT_1_c_in_2),
        .g(sumator_complet_1bit_7_g),
        .p(sumator_complet_1bit_7_p),
        .sum(sumator_complet_1bit_7_sum));
  design_1_sumator_complet_1bit_8_0 sumator_complet_1bit_8
       (.a(modul_defalcare_0_a9),
        .b(modul_defalcare_1_a9),
        .c_in(splitter_GUAT_0_carry2),
        .g(sumator_complet_1bit_8_g),
        .p(sumator_complet_1bit_8_p),
        .sum(sumator_complet_1bit_8_sum));
  design_1_sumator_complet_1bit_9_0 sumator_complet_1bit_9
       (.a(modul_defalcare_0_a10),
        .b(modul_defalcare_1_a10),
        .c_in(defalcare_UAT_2_c_in_0),
        .g(sumator_complet_1bit_9_g),
        .p(sumator_complet_1bit_9_p),
        .sum(sumator_complet_1bit_9_sum));
endmodule
