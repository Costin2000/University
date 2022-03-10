//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed May 19 16:38:52 2021
//Host        : DESKTOP-UQS0J8L running 64-bit major release  (build 9200)
//Command     : generate_target Schema.bd
//Design      : Schema
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Schema,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Schema,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=38,numReposBlks=38,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=38,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "Schema.hwdef" *) 
module Schema
   (GUAT_G_0,
    GUAT_P_0,
    a_0,
    a_1,
    b_0,
    cin_0,
    o4_0);
  output GUAT_G_0;
  output GUAT_P_0;
  input [15:0]a_0;
  output [15:0]a_1;
  input [15:0]b_0;
  input cin_0;
  output o4_0;

  wire [15:0]Convertor16_1_0_a;
  wire Convertor1_4_0_o1;
  wire Convertor1_4_0_o2;
  wire Convertor1_4_0_o3;
  wire Convertor1_4_0_o4;
  wire Convertor2_32_0_a0;
  wire Convertor2_32_0_a1;
  wire Convertor2_32_0_a10;
  wire Convertor2_32_0_a11;
  wire Convertor2_32_0_a12;
  wire Convertor2_32_0_a13;
  wire Convertor2_32_0_a14;
  wire Convertor2_32_0_a15;
  wire Convertor2_32_0_a2;
  wire Convertor2_32_0_a3;
  wire Convertor2_32_0_a4;
  wire Convertor2_32_0_a5;
  wire Convertor2_32_0_a6;
  wire Convertor2_32_0_a7;
  wire Convertor2_32_0_a8;
  wire Convertor2_32_0_a9;
  wire Convertor2_32_0_b0;
  wire Convertor2_32_0_b1;
  wire Convertor2_32_0_b10;
  wire Convertor2_32_0_b11;
  wire Convertor2_32_0_b12;
  wire Convertor2_32_0_b13;
  wire Convertor2_32_0_b14;
  wire Convertor2_32_0_b15;
  wire Convertor2_32_0_b2;
  wire Convertor2_32_0_b3;
  wire Convertor2_32_0_b4;
  wire Convertor2_32_0_b5;
  wire Convertor2_32_0_b6;
  wire Convertor2_32_0_b7;
  wire Convertor2_32_0_b8;
  wire Convertor2_32_0_b9;
  wire [3:0]Convertor4_1_0_out;
  wire [3:0]Convertor4_1_1_out;
  wire [3:0]Convertor4_1_2_out;
  wire [3:0]Convertor4_1_3_out;
  wire [3:0]Convertor4_1_4_out;
  wire [3:0]Convertor4_1_5_out;
  wire [3:0]Convertor4_1_6_out;
  wire [3:0]Convertor4_1_7_out;
  wire [3:0]Convertor4_1_8_out;
  wire [3:0]Convertor4_1_9_out;
  wire EliminareBit_0_b0;
  wire EliminareBit_0_b1;
  wire EliminareBit_0_b3;
  wire EliminareBit_1_b0;
  wire EliminareBit_1_b1;
  wire EliminareBit_1_b3;
  wire EliminareBit_2_b0;
  wire EliminareBit_2_b1;
  wire EliminareBit_2_b3;
  wire EliminareBit_3_b0;
  wire EliminareBit_3_b1;
  wire EliminareBit_3_b3;
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
  wire cin_0_1;
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
  assign a_1[15:0] = Convertor16_1_0_a;
  assign b_0_1 = b_0[15:0];
  assign cin_0_1 = cin_0;
  assign o4_0 = Convertor1_4_0_o4;
  Schema_Convertor16_1_0_1 Convertor16_1_0
       (.a(Convertor16_1_0_a),
        .a0(sumator_complet_1bit_0_sum),
        .a1(sumator_complet_1bit_1_sum),
        .a10(sumator_complet_1bit_10_sum),
        .a11(sumator_complet_1bit_11_sum),
        .a12(sumator_complet_1bit_12_sum),
        .a13(sumator_complet_1bit_13_sum),
        .a14(sumator_complet_1bit_14_sum),
        .a15(sumator_complet_1bit_15_sum),
        .a2(sumator_complet_1bit_2_sum),
        .a3(sumator_complet_1bit_3_sum),
        .a4(sumator_complet_1bit_4_sum),
        .a5(sumator_complet_1bit_5_sum),
        .a6(sumator_complet_1bit_6_sum),
        .a7(sumator_complet_1bit_7_sum),
        .a8(sumator_complet_1bit_8_sum),
        .a9(sumator_complet_1bit_9_sum));
  Schema_Convertor1_4_0_0 Convertor1_4_0
       (.intrare(GUAT_0_carry_GUAT),
        .o1(Convertor1_4_0_o1),
        .o2(Convertor1_4_0_o2),
        .o3(Convertor1_4_0_o3),
        .o4(Convertor1_4_0_o4));
  Schema_Convertor2_32_0_0 Convertor2_32_0
       (.a(a_0_1),
        .a0(Convertor2_32_0_a0),
        .a1(Convertor2_32_0_a1),
        .a10(Convertor2_32_0_a10),
        .a11(Convertor2_32_0_a11),
        .a12(Convertor2_32_0_a12),
        .a13(Convertor2_32_0_a13),
        .a14(Convertor2_32_0_a14),
        .a15(Convertor2_32_0_a15),
        .a2(Convertor2_32_0_a2),
        .a3(Convertor2_32_0_a3),
        .a4(Convertor2_32_0_a4),
        .a5(Convertor2_32_0_a5),
        .a6(Convertor2_32_0_a6),
        .a7(Convertor2_32_0_a7),
        .a8(Convertor2_32_0_a8),
        .a9(Convertor2_32_0_a9),
        .b(b_0_1),
        .b0(Convertor2_32_0_b0),
        .b1(Convertor2_32_0_b1),
        .b10(Convertor2_32_0_b10),
        .b11(Convertor2_32_0_b11),
        .b12(Convertor2_32_0_b12),
        .b13(Convertor2_32_0_b13),
        .b14(Convertor2_32_0_b14),
        .b15(Convertor2_32_0_b15),
        .b2(Convertor2_32_0_b2),
        .b3(Convertor2_32_0_b3),
        .b4(Convertor2_32_0_b4),
        .b5(Convertor2_32_0_b5),
        .b6(Convertor2_32_0_b6),
        .b7(Convertor2_32_0_b7),
        .b8(Convertor2_32_0_b8),
        .b9(Convertor2_32_0_b9),
        .cin(cin_0_1));
  Schema_Convertor4_1_0_0 Convertor4_1_0
       (.iesire(Convertor4_1_0_out),
        .var1(sumator_complet_1bit_4_p),
        .var2(sumator_complet_1bit_5_p),
        .var3(sumator_complet_1bit_6_p),
        .var4(sumator_complet_1bit_7_p));
  Schema_Convertor4_1_1_0 Convertor4_1_1
       (.iesire(Convertor4_1_1_out),
        .var1(sumator_complet_1bit_4_g),
        .var2(sumator_complet_1bit_5_g),
        .var3(sumator_complet_1bit_6_g),
        .var4(sumator_complet_1bit_7_g));
  Schema_Convertor4_1_2_0 Convertor4_1_2
       (.iesire(Convertor4_1_2_out),
        .var1(sumator_complet_1bit_8_p),
        .var2(sumator_complet_1bit_9_p),
        .var3(sumator_complet_1bit_10_p),
        .var4(sumator_complet_1bit_11_p));
  Schema_Convertor4_1_3_0 Convertor4_1_3
       (.iesire(Convertor4_1_3_out),
        .var1(sumator_complet_1bit_8_g),
        .var2(sumator_complet_1bit_9_g),
        .var3(sumator_complet_1bit_10_g),
        .var4(sumator_complet_1bit_11_g));
  Schema_Convertor4_1_4_0 Convertor4_1_4
       (.iesire(Convertor4_1_4_out),
        .var1(sumator_complet_1bit_0_p),
        .var2(sumator_complet_1bit_1_p),
        .var3(sumator_complet_1bit_2_p),
        .var4(sumator_complet_1bit_3_p));
  Schema_Convertor4_1_5_0 Convertor4_1_5
       (.iesire(Convertor4_1_5_out),
        .var1(sumator_complet_1bit_0_g),
        .var2(sumator_complet_1bit_1_g),
        .var3(sumator_complet_1bit_2_g),
        .var4(sumator_complet_1bit_3_g));
  Schema_Convertor4_1_6_0 Convertor4_1_6
       (.iesire(Convertor4_1_6_out),
        .var1(sumator_complet_1bit_12_p),
        .var2(sumator_complet_1bit_13_p),
        .var3(sumator_complet_1bit_14_p),
        .var4(sumator_complet_1bit_15_p));
  Schema_Convertor4_1_7_0 Convertor4_1_7
       (.iesire(Convertor4_1_7_out),
        .var1(sumator_complet_1bit_12_g),
        .var2(sumator_complet_1bit_13_g),
        .var3(sumator_complet_1bit_14_g),
        .var4(sumator_complet_1bit_15_g));
  Schema_Convertor4_1_8_0 Convertor4_1_8
       (.iesire(Convertor4_1_8_out),
        .var1(UAT_0_UAT_G),
        .var2(UAT_1_UAT_G),
        .var3(UAT_2_UAT_G),
        .var4(UAT_3_UAT_G));
  Schema_Convertor4_1_9_0 Convertor4_1_9
       (.iesire(Convertor4_1_9_out),
        .var1(UAT_0_UAT_P),
        .var2(UAT_1_UAT_P),
        .var3(UAT_2_UAT_P),
        .var4(UAT_3_UAT_P));
  Schema_EliminareBit_0_1 EliminareBit_0
       (.b0(EliminareBit_0_b0),
        .b1(EliminareBit_0_b1),
        .b2(EliminareBit_0_b3),
        .carry(UAT_0_carry_UAT));
  Schema_EliminareBit_1_1 EliminareBit_1
       (.b0(EliminareBit_1_b0),
        .b1(EliminareBit_1_b1),
        .b2(EliminareBit_1_b3),
        .carry(UAT_1_carry_UAT));
  Schema_EliminareBit_2_1 EliminareBit_2
       (.b0(EliminareBit_2_b0),
        .b1(EliminareBit_2_b1),
        .b2(EliminareBit_2_b3),
        .carry(UAT_2_carry_UAT));
  Schema_EliminareBit_3_0 EliminareBit_3
       (.b0(EliminareBit_3_b0),
        .b1(EliminareBit_3_b1),
        .b2(EliminareBit_3_b3),
        .carry(UAT_3_carry_UAT));
  Schema_GUAT_0_0 GUAT_0
       (.GUAT_G(GUAT_0_GUAT_G),
        .GUAT_P(GUAT_0_GUAT_P),
        .UAT_G(Convertor4_1_8_out),
        .UAT_P(Convertor4_1_9_out),
        .c_in(cin_0_1),
        .carry_GUAT(GUAT_0_carry_GUAT));
  Schema_UAT_0_0 UAT_0
       (.UAT_G(UAT_0_UAT_G),
        .UAT_P(UAT_0_UAT_P),
        .c_in(cin_0_1),
        .carry_UAT(UAT_0_carry_UAT),
        .g_in(Convertor4_1_5_out),
        .p_in(Convertor4_1_4_out));
  Schema_UAT_1_0 UAT_1
       (.UAT_G(UAT_1_UAT_G),
        .UAT_P(UAT_1_UAT_P),
        .c_in(Convertor1_4_0_o1),
        .carry_UAT(UAT_1_carry_UAT),
        .g_in(Convertor4_1_1_out),
        .p_in(Convertor4_1_0_out));
  Schema_UAT_2_0 UAT_2
       (.UAT_G(UAT_2_UAT_G),
        .UAT_P(UAT_2_UAT_P),
        .c_in(Convertor1_4_0_o2),
        .carry_UAT(UAT_2_carry_UAT),
        .g_in(Convertor4_1_3_out),
        .p_in(Convertor4_1_2_out));
  Schema_UAT_3_0 UAT_3
       (.UAT_G(UAT_3_UAT_G),
        .UAT_P(UAT_3_UAT_P),
        .c_in(Convertor1_4_0_o3),
        .carry_UAT(UAT_3_carry_UAT),
        .g_in(Convertor4_1_7_out),
        .p_in(Convertor4_1_6_out));
  Schema_sumator_complet_1bit_0_0 sumator_complet_1bit_0
       (.a(Convertor2_32_0_a0),
        .b(Convertor2_32_0_b0),
        .c_in(cin_0_1),
        .g(sumator_complet_1bit_0_g),
        .p(sumator_complet_1bit_0_p),
        .sum(sumator_complet_1bit_0_sum));
  Schema_sumator_complet_1bit_1_0 sumator_complet_1bit_1
       (.a(Convertor2_32_0_a1),
        .b(Convertor2_32_0_b1),
        .c_in(EliminareBit_0_b0),
        .g(sumator_complet_1bit_1_g),
        .p(sumator_complet_1bit_1_p),
        .sum(sumator_complet_1bit_1_sum));
  Schema_sumator_complet_1bit_10_0 sumator_complet_1bit_10
       (.a(Convertor2_32_0_a10),
        .b(Convertor2_32_0_b10),
        .c_in(EliminareBit_2_b1),
        .g(sumator_complet_1bit_10_g),
        .p(sumator_complet_1bit_10_p),
        .sum(sumator_complet_1bit_10_sum));
  Schema_sumator_complet_1bit_11_0 sumator_complet_1bit_11
       (.a(Convertor2_32_0_a11),
        .b(Convertor2_32_0_b11),
        .c_in(EliminareBit_2_b3),
        .g(sumator_complet_1bit_11_g),
        .p(sumator_complet_1bit_11_p),
        .sum(sumator_complet_1bit_11_sum));
  Schema_sumator_complet_1bit_12_0 sumator_complet_1bit_12
       (.a(Convertor2_32_0_a12),
        .b(Convertor2_32_0_b12),
        .c_in(Convertor1_4_0_o3),
        .g(sumator_complet_1bit_12_g),
        .p(sumator_complet_1bit_12_p),
        .sum(sumator_complet_1bit_12_sum));
  Schema_sumator_complet_1bit_13_0 sumator_complet_1bit_13
       (.a(Convertor2_32_0_a13),
        .b(Convertor2_32_0_b13),
        .c_in(EliminareBit_3_b0),
        .g(sumator_complet_1bit_13_g),
        .p(sumator_complet_1bit_13_p),
        .sum(sumator_complet_1bit_13_sum));
  Schema_sumator_complet_1bit_14_0 sumator_complet_1bit_14
       (.a(Convertor2_32_0_a14),
        .b(Convertor2_32_0_b14),
        .c_in(EliminareBit_3_b1),
        .g(sumator_complet_1bit_14_g),
        .p(sumator_complet_1bit_14_p),
        .sum(sumator_complet_1bit_14_sum));
  Schema_sumator_complet_1bit_15_0 sumator_complet_1bit_15
       (.a(Convertor2_32_0_a15),
        .b(Convertor2_32_0_b15),
        .c_in(EliminareBit_3_b3),
        .g(sumator_complet_1bit_15_g),
        .p(sumator_complet_1bit_15_p),
        .sum(sumator_complet_1bit_15_sum));
  Schema_sumator_complet_1bit_2_0 sumator_complet_1bit_2
       (.a(Convertor2_32_0_a2),
        .b(Convertor2_32_0_b2),
        .c_in(EliminareBit_0_b1),
        .g(sumator_complet_1bit_2_g),
        .p(sumator_complet_1bit_2_p),
        .sum(sumator_complet_1bit_2_sum));
  Schema_sumator_complet_1bit_3_0 sumator_complet_1bit_3
       (.a(Convertor2_32_0_a3),
        .b(Convertor2_32_0_b3),
        .c_in(EliminareBit_0_b3),
        .g(sumator_complet_1bit_3_g),
        .p(sumator_complet_1bit_3_p),
        .sum(sumator_complet_1bit_3_sum));
  Schema_sumator_complet_1bit_4_0 sumator_complet_1bit_4
       (.a(Convertor2_32_0_a4),
        .b(Convertor2_32_0_b4),
        .c_in(Convertor1_4_0_o1),
        .g(sumator_complet_1bit_4_g),
        .p(sumator_complet_1bit_4_p),
        .sum(sumator_complet_1bit_4_sum));
  Schema_sumator_complet_1bit_5_0 sumator_complet_1bit_5
       (.a(Convertor2_32_0_a5),
        .b(Convertor2_32_0_b5),
        .c_in(EliminareBit_1_b0),
        .g(sumator_complet_1bit_5_g),
        .p(sumator_complet_1bit_5_p),
        .sum(sumator_complet_1bit_5_sum));
  Schema_sumator_complet_1bit_6_0 sumator_complet_1bit_6
       (.a(Convertor2_32_0_a6),
        .b(Convertor2_32_0_b6),
        .c_in(EliminareBit_1_b1),
        .g(sumator_complet_1bit_6_g),
        .p(sumator_complet_1bit_6_p),
        .sum(sumator_complet_1bit_6_sum));
  Schema_sumator_complet_1bit_7_0 sumator_complet_1bit_7
       (.a(Convertor2_32_0_a7),
        .b(Convertor2_32_0_b7),
        .c_in(EliminareBit_1_b3),
        .g(sumator_complet_1bit_7_g),
        .p(sumator_complet_1bit_7_p),
        .sum(sumator_complet_1bit_7_sum));
  Schema_sumator_complet_1bit_8_0 sumator_complet_1bit_8
       (.a(Convertor2_32_0_a8),
        .b(Convertor2_32_0_b8),
        .c_in(Convertor1_4_0_o2),
        .g(sumator_complet_1bit_8_g),
        .p(sumator_complet_1bit_8_p),
        .sum(sumator_complet_1bit_8_sum));
  Schema_sumator_complet_1bit_9_0 sumator_complet_1bit_9
       (.a(Convertor2_32_0_a9),
        .b(Convertor2_32_0_b9),
        .c_in(EliminareBit_2_b0),
        .g(sumator_complet_1bit_9_g),
        .p(sumator_complet_1bit_9_p),
        .sum(sumator_complet_1bit_9_sum));
endmodule
