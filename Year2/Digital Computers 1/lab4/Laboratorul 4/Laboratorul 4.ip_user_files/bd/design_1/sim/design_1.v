//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
//Date        : Wed May 19 18:21:04 2021
//Host        : catalin-vm running 64-bit Linux Mint 20.1
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=36,numReposBlks=36,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=36,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (GUAT_G_0,
    GUAT_P_0,
    a_0,
    b_0,
    c_in_0,
    carry4_0,
    sum_out_0);
  output GUAT_G_0;
  output GUAT_P_0;
  input [15:0]a_0;
  input [15:0]b_0;
  input c_in_0;
  output carry4_0;
  output [15:0]sum_out_0;

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
  wire [15:0]concatenare_suma_0_sum_out;
  wire [3:0]concatenare_uat_0_g_out;
  wire [3:0]concatenare_uat_0_p_out;
  wire extragere_0_a1;
  wire extragere_0_a10;
  wire extragere_0_a11;
  wire extragere_0_a12;
  wire extragere_0_a13;
  wire extragere_0_a14;
  wire extragere_0_a15;
  wire extragere_0_a16;
  wire extragere_0_a2;
  wire extragere_0_a3;
  wire extragere_0_a4;
  wire extragere_0_a5;
  wire extragere_0_a6;
  wire extragere_0_a7;
  wire extragere_0_a8;
  wire extragere_0_a9;
  wire extragere_1_a1;
  wire extragere_1_a10;
  wire extragere_1_a11;
  wire extragere_1_a12;
  wire extragere_1_a13;
  wire extragere_1_a14;
  wire extragere_1_a15;
  wire extragere_1_a16;
  wire extragere_1_a2;
  wire extragere_1_a3;
  wire extragere_1_a4;
  wire extragere_1_a5;
  wire extragere_1_a6;
  wire extragere_1_a7;
  wire extragere_1_a8;
  wire extragere_1_a9;
  wire extragere_GUAT_0_carry1;
  wire extragere_GUAT_0_carry2;
  wire extragere_GUAT_0_carry3;
  wire extragere_GUAT_0_carry4;
  wire [15:0]intrare_0_a_out;
  wire [15:0]intrare_0_b_out;
  wire intrare_c_in_0_c_in_out;
  wire [3:0]modul_concatenare_0_g_out;
  wire [3:0]modul_concatenare_0_p_out;
  wire [3:0]modul_concatenare_1_g_out;
  wire [3:0]modul_concatenare_1_p_out;
  wire [3:0]modul_concatenare_2_g_out;
  wire [3:0]modul_concatenare_2_p_out;
  wire [3:0]modul_concatenare_3_g_out;
  wire [3:0]modul_concatenare_3_p_out;
  wire split_UAT_0_c0;
  wire split_UAT_0_c1;
  wire split_UAT_0_c2;
  wire split_UAT_1_c0;
  wire split_UAT_1_c1;
  wire split_UAT_1_c2;
  wire split_UAT_2_c0;
  wire split_UAT_2_c1;
  wire split_UAT_2_c2;
  wire split_UAT_3_c0;
  wire split_UAT_3_c1;
  wire split_UAT_3_c2;
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
  assign carry4_0 = extragere_GUAT_0_carry4;
  assign sum_out_0[15:0] = concatenare_suma_0_sum_out;
  design_1_GUAT_0_0 GUAT_0
       (.GUAT_G(GUAT_0_GUAT_G),
        .GUAT_P(GUAT_0_GUAT_P),
        .UAT_G(concatenare_uat_0_g_out),
        .UAT_P(concatenare_uat_0_p_out),
        .c_in(intrare_c_in_0_c_in_out),
        .carry_GUAT(GUAT_0_carry_GUAT));
  design_1_UAT_0_0 UAT_0
       (.UAT_G(UAT_0_UAT_G),
        .UAT_P(UAT_0_UAT_P),
        .c_in(intrare_c_in_0_c_in_out),
        .carry_UAT(UAT_0_carry_UAT),
        .g_in(modul_concatenare_0_g_out),
        .p_in(modul_concatenare_0_p_out));
  design_1_UAT_1_0 UAT_1
       (.UAT_G(UAT_1_UAT_G),
        .UAT_P(UAT_1_UAT_P),
        .c_in(extragere_GUAT_0_carry1),
        .carry_UAT(UAT_1_carry_UAT),
        .g_in(modul_concatenare_1_g_out),
        .p_in(modul_concatenare_1_p_out));
  design_1_UAT_2_0 UAT_2
       (.UAT_G(UAT_2_UAT_G),
        .UAT_P(UAT_2_UAT_P),
        .c_in(extragere_GUAT_0_carry2),
        .carry_UAT(UAT_2_carry_UAT),
        .g_in(modul_concatenare_2_g_out),
        .p_in(modul_concatenare_2_p_out));
  design_1_UAT_3_0 UAT_3
       (.UAT_G(UAT_3_UAT_G),
        .UAT_P(UAT_3_UAT_P),
        .c_in(extragere_GUAT_0_carry3),
        .carry_UAT(UAT_3_carry_UAT),
        .g_in(modul_concatenare_3_g_out),
        .p_in(modul_concatenare_3_p_out));
  design_1_concatenare_suma_0_0 concatenare_suma_0
       (.sum0(sumator_complet_1bit_0_sum),
        .sum1(sumator_complet_1bit_1_sum),
        .sum10(sumator_complet_1bit_10_sum),
        .sum11(sumator_complet_1bit_11_sum),
        .sum12(sumator_complet_1bit_12_sum),
        .sum13(sumator_complet_1bit_13_sum),
        .sum14(sumator_complet_1bit_14_sum),
        .sum15(sumator_complet_1bit_15_sum),
        .sum2(sumator_complet_1bit_2_sum),
        .sum3(sumator_complet_1bit_3_sum),
        .sum4(sumator_complet_1bit_4_sum),
        .sum5(sumator_complet_1bit_5_sum),
        .sum6(sumator_complet_1bit_6_sum),
        .sum7(sumator_complet_1bit_7_sum),
        .sum8(sumator_complet_1bit_8_sum),
        .sum9(sumator_complet_1bit_9_sum),
        .sum_out(concatenare_suma_0_sum_out));
  design_1_concatenare_uat_0_0 concatenare_uat_0
       (.g0(UAT_0_UAT_G),
        .g1(UAT_1_UAT_G),
        .g2(UAT_2_UAT_G),
        .g3(UAT_3_UAT_G),
        .g_out(concatenare_uat_0_g_out),
        .p0(UAT_0_UAT_P),
        .p1(UAT_1_UAT_P),
        .p2(UAT_2_UAT_P),
        .p3(UAT_3_UAT_P),
        .p_out(concatenare_uat_0_p_out));
  design_1_extragere_0_0 extragere_0
       (.a(intrare_0_a_out),
        .a1(extragere_0_a1),
        .a10(extragere_0_a10),
        .a11(extragere_0_a11),
        .a12(extragere_0_a12),
        .a13(extragere_0_a13),
        .a14(extragere_0_a14),
        .a15(extragere_0_a15),
        .a16(extragere_0_a16),
        .a2(extragere_0_a2),
        .a3(extragere_0_a3),
        .a4(extragere_0_a4),
        .a5(extragere_0_a5),
        .a6(extragere_0_a6),
        .a7(extragere_0_a7),
        .a8(extragere_0_a8),
        .a9(extragere_0_a9));
  design_1_extragere_1_0 extragere_1
       (.a(intrare_0_b_out),
        .a1(extragere_1_a1),
        .a10(extragere_1_a10),
        .a11(extragere_1_a11),
        .a12(extragere_1_a12),
        .a13(extragere_1_a13),
        .a14(extragere_1_a14),
        .a15(extragere_1_a15),
        .a16(extragere_1_a16),
        .a2(extragere_1_a2),
        .a3(extragere_1_a3),
        .a4(extragere_1_a4),
        .a5(extragere_1_a5),
        .a6(extragere_1_a6),
        .a7(extragere_1_a7),
        .a8(extragere_1_a8),
        .a9(extragere_1_a9));
  design_1_extragere_GUAT_0_0 extragere_GUAT_0
       (.carry1(extragere_GUAT_0_carry1),
        .carry2(extragere_GUAT_0_carry2),
        .carry3(extragere_GUAT_0_carry3),
        .carry4(extragere_GUAT_0_carry4),
        .carry_GUAT(GUAT_0_carry_GUAT));
  design_1_intrare_0_1 intrare_0
       (.a(a_0_1),
        .a_out(intrare_0_a_out),
        .b(b_0_1),
        .b_out(intrare_0_b_out));
  design_1_intrare_c_in_0_0 intrare_c_in_0
       (.c_in(c_in_0_1),
        .c_in_out(intrare_c_in_0_c_in_out));
  design_1_modul_concatenare_0_0 modul_concatenare_0
       (.g1(sumator_complet_1bit_0_g),
        .g2(sumator_complet_1bit_1_g),
        .g3(sumator_complet_1bit_2_g),
        .g4(sumator_complet_1bit_3_g),
        .g_out(modul_concatenare_0_g_out),
        .p1(sumator_complet_1bit_0_p),
        .p2(sumator_complet_1bit_1_p),
        .p3(sumator_complet_1bit_2_p),
        .p4(sumator_complet_1bit_3_p),
        .p_out(modul_concatenare_0_p_out));
  design_1_modul_concatenare_1_0 modul_concatenare_1
       (.g1(sumator_complet_1bit_4_g),
        .g2(sumator_complet_1bit_5_g),
        .g3(sumator_complet_1bit_6_g),
        .g4(sumator_complet_1bit_7_g),
        .g_out(modul_concatenare_1_g_out),
        .p1(sumator_complet_1bit_4_p),
        .p2(sumator_complet_1bit_5_p),
        .p3(sumator_complet_1bit_6_p),
        .p4(sumator_complet_1bit_7_p),
        .p_out(modul_concatenare_1_p_out));
  design_1_modul_concatenare_2_0 modul_concatenare_2
       (.g1(sumator_complet_1bit_8_g),
        .g2(sumator_complet_1bit_9_g),
        .g3(sumator_complet_1bit_11_g),
        .g4(sumator_complet_1bit_10_g),
        .g_out(modul_concatenare_2_g_out),
        .p1(sumator_complet_1bit_8_p),
        .p2(sumator_complet_1bit_9_p),
        .p3(sumator_complet_1bit_11_p),
        .p4(sumator_complet_1bit_10_p),
        .p_out(modul_concatenare_2_p_out));
  design_1_modul_concatenare_3_0 modul_concatenare_3
       (.g1(sumator_complet_1bit_12_g),
        .g2(sumator_complet_1bit_13_g),
        .g3(sumator_complet_1bit_14_g),
        .g4(sumator_complet_1bit_15_g),
        .g_out(modul_concatenare_3_g_out),
        .p1(sumator_complet_1bit_12_p),
        .p2(sumator_complet_1bit_13_p),
        .p3(sumator_complet_1bit_14_p),
        .p4(sumator_complet_1bit_15_p),
        .p_out(modul_concatenare_3_p_out));
  design_1_split_UAT_0_0 split_UAT_0
       (.c0(split_UAT_0_c0),
        .c1(split_UAT_0_c1),
        .c2(split_UAT_0_c2),
        .carry_uat(UAT_0_carry_UAT));
  design_1_split_UAT_1_0 split_UAT_1
       (.c0(split_UAT_1_c0),
        .c1(split_UAT_1_c1),
        .c2(split_UAT_1_c2),
        .carry_uat(UAT_1_carry_UAT));
  design_1_split_UAT_2_0 split_UAT_2
       (.c0(split_UAT_2_c0),
        .c1(split_UAT_2_c1),
        .c2(split_UAT_2_c2),
        .carry_uat(UAT_2_carry_UAT));
  design_1_split_UAT_3_0 split_UAT_3
       (.c0(split_UAT_3_c0),
        .c1(split_UAT_3_c1),
        .c2(split_UAT_3_c2),
        .carry_uat(UAT_3_carry_UAT));
  design_1_sumator_complet_1bit_0_0 sumator_complet_1bit_0
       (.a(extragere_0_a1),
        .b(extragere_1_a1),
        .c_in(intrare_c_in_0_c_in_out),
        .g(sumator_complet_1bit_0_g),
        .p(sumator_complet_1bit_0_p),
        .sum(sumator_complet_1bit_0_sum));
  design_1_sumator_complet_1bit_1_0 sumator_complet_1bit_1
       (.a(extragere_0_a2),
        .b(extragere_1_a2),
        .c_in(split_UAT_0_c0),
        .g(sumator_complet_1bit_1_g),
        .p(sumator_complet_1bit_1_p),
        .sum(sumator_complet_1bit_1_sum));
  design_1_sumator_complet_1bit_10_0 sumator_complet_1bit_10
       (.a(extragere_0_a11),
        .b(extragere_1_a11),
        .c_in(split_UAT_2_c1),
        .g(sumator_complet_1bit_10_g),
        .p(sumator_complet_1bit_10_p),
        .sum(sumator_complet_1bit_10_sum));
  design_1_sumator_complet_1bit_11_0 sumator_complet_1bit_11
       (.a(extragere_0_a12),
        .b(extragere_1_a12),
        .c_in(split_UAT_2_c2),
        .g(sumator_complet_1bit_11_g),
        .p(sumator_complet_1bit_11_p),
        .sum(sumator_complet_1bit_11_sum));
  design_1_sumator_complet_1bit_12_0 sumator_complet_1bit_12
       (.a(extragere_0_a13),
        .b(extragere_1_a13),
        .c_in(extragere_GUAT_0_carry3),
        .g(sumator_complet_1bit_12_g),
        .p(sumator_complet_1bit_12_p),
        .sum(sumator_complet_1bit_12_sum));
  design_1_sumator_complet_1bit_13_0 sumator_complet_1bit_13
       (.a(extragere_0_a14),
        .b(extragere_1_a14),
        .c_in(split_UAT_3_c0),
        .g(sumator_complet_1bit_13_g),
        .p(sumator_complet_1bit_13_p),
        .sum(sumator_complet_1bit_13_sum));
  design_1_sumator_complet_1bit_14_0 sumator_complet_1bit_14
       (.a(extragere_0_a15),
        .b(extragere_1_a15),
        .c_in(split_UAT_3_c1),
        .g(sumator_complet_1bit_14_g),
        .p(sumator_complet_1bit_14_p),
        .sum(sumator_complet_1bit_14_sum));
  design_1_sumator_complet_1bit_15_0 sumator_complet_1bit_15
       (.a(extragere_0_a16),
        .b(extragere_1_a16),
        .c_in(split_UAT_3_c2),
        .g(sumator_complet_1bit_15_g),
        .p(sumator_complet_1bit_15_p),
        .sum(sumator_complet_1bit_15_sum));
  design_1_sumator_complet_1bit_2_0 sumator_complet_1bit_2
       (.a(extragere_0_a3),
        .b(extragere_1_a3),
        .c_in(split_UAT_0_c1),
        .g(sumator_complet_1bit_2_g),
        .p(sumator_complet_1bit_2_p),
        .sum(sumator_complet_1bit_2_sum));
  design_1_sumator_complet_1bit_3_0 sumator_complet_1bit_3
       (.a(extragere_0_a4),
        .b(extragere_1_a4),
        .c_in(split_UAT_0_c2),
        .g(sumator_complet_1bit_3_g),
        .p(sumator_complet_1bit_3_p),
        .sum(sumator_complet_1bit_3_sum));
  design_1_sumator_complet_1bit_4_0 sumator_complet_1bit_4
       (.a(extragere_0_a5),
        .b(extragere_1_a5),
        .c_in(extragere_GUAT_0_carry1),
        .g(sumator_complet_1bit_4_g),
        .p(sumator_complet_1bit_4_p),
        .sum(sumator_complet_1bit_4_sum));
  design_1_sumator_complet_1bit_5_0 sumator_complet_1bit_5
       (.a(extragere_0_a6),
        .b(extragere_1_a6),
        .c_in(split_UAT_1_c0),
        .g(sumator_complet_1bit_5_g),
        .p(sumator_complet_1bit_5_p),
        .sum(sumator_complet_1bit_5_sum));
  design_1_sumator_complet_1bit_6_0 sumator_complet_1bit_6
       (.a(extragere_0_a7),
        .b(extragere_1_a7),
        .c_in(split_UAT_1_c1),
        .g(sumator_complet_1bit_6_g),
        .p(sumator_complet_1bit_6_p),
        .sum(sumator_complet_1bit_6_sum));
  design_1_sumator_complet_1bit_7_0 sumator_complet_1bit_7
       (.a(extragere_0_a8),
        .b(extragere_1_a8),
        .c_in(split_UAT_1_c2),
        .g(sumator_complet_1bit_7_g),
        .p(sumator_complet_1bit_7_p),
        .sum(sumator_complet_1bit_7_sum));
  design_1_sumator_complet_1bit_8_0 sumator_complet_1bit_8
       (.a(extragere_0_a9),
        .b(extragere_1_a9),
        .c_in(extragere_GUAT_0_carry2),
        .g(sumator_complet_1bit_8_g),
        .p(sumator_complet_1bit_8_p),
        .sum(sumator_complet_1bit_8_sum));
  design_1_sumator_complet_1bit_9_0 sumator_complet_1bit_9
       (.a(extragere_0_a10),
        .b(extragere_1_a10),
        .c_in(split_UAT_2_c0),
        .g(sumator_complet_1bit_9_g),
        .p(sumator_complet_1bit_9_p),
        .sum(sumator_complet_1bit_9_sum));
endmodule
