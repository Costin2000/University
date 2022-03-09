`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2021 06:28:01 PM
// Design Name: 
// Module Name: sumator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sumator(a,b,c_in, GG, GP, c_out, sum);
     input [15:0] a, b;
     input c_in;
     output GG, GP;
     output [15:0] sum;
     output c_out;
     wire [3:0] UAT_G, UAT_P;
     wire [4:1] carry_GUAT;
     wire [3:0] g0_in, p0_in, g1_in, p1_in, g2_in, p2_in, g3_in, p3_in;
     wire [3:0] carry_UAT0, carry_UAT1, carry_UAT2, carry_UAT3;
     
     sumator_complet_1bit sc4(a[4], b[4], carry_GUAT[1], p1_in[0], g1_in[0], sum[4]);
     sumator_complet_1bit sc5(a[5], b[5], carry_UAT1[0], p1_in[1], g1_in[1], sum[5]);
     sumator_complet_1bit sc6(a[6], b[6], carry_UAT1[1], p1_in[2], g1_in[2], sum[6]); 
     sumator_complet_1bit sc7(a[7], b[7], carry_UAT1[2], p1_in[3], g1_in[3], sum[7]);

     sumator_complet_1bit sc8(a[8], b[8], carry_GUAT[2], p2_in[0], g2_in[0], sum[8]);
     sumator_complet_1bit sc9(a[9], b[9], carry_UAT2[0], p2_in[1], g2_in[1], sum[9]);
     sumator_complet_1bit sc10(a[10], b[10], carry_UAT2[1], p2_in[2], g2_in[2], sum[10]);
     sumator_complet_1bit sc11(a[11], b[11], carry_UAT2[2] , p2_in[3], g2_in[3], sum[11]);
     
     UAT uat1(carry_GUAT[1], g1_in[3:0], p1_in[3:0], UAT_G[1], UAT_P[1], carry_UAT1[3:0]);
     UAT uat2(carry_GUAT[2], g2_in[3:0], p2_in[3:0], UAT_G[2], UAT_P[2], carry_UAT2[3:0]);
     
     sumator_complet_1bit sc0(a[0], b[0], c_in, p0_in[0], g0_in[0], sum[0]);
     sumator_complet_1bit sc1(a[1], b[1], carry_UAT0[0], p0_in[1], g0_in[1], sum[1]); 
     sumator_complet_1bit sc2(a[2], b[2], carry_UAT0[1], p0_in[2], g0_in[2], sum[2]);
     sumator_complet_1bit sc3(a[3], b[3], carry_UAT0[2], p0_in[3], g0_in[3], sum[3]);

     sumator_complet_1bit sc12(a[12], b[12], carry_GUAT[3], p3_in[0], g3_in[0], sum[12]);
     sumator_complet_1bit sc13(a[13], b[13], carry_UAT3[0], p3_in[1], g3_in[1], sum[13]);
     sumator_complet_1bit sc14(a[14], b[14], carry_UAT3[1], p3_in[2], g3_in[2], sum[14]);
     sumator_complet_1bit sc15(a[15], b[15], carry_UAT3[2], p3_in[3], g3_in[3], sum[15]);
     
     UAT uat0(c_in, g0_in[3:0], p0_in[3:0], UAT_G[0], UAT_P[0], carry_UAT0[3:0]);
     UAT uat3(carry_GUAT[3], g3_in[3:0], p3_in[3:0], UAT_G[3], UAT_P[3], carry_UAT3[3:0]);
     
     GUAT guat(c_in, UAT_G[3:0], UAT_P[3:0], GG, GP, carry_GUAT[4:1]);
     assign c_out = carry_GUAT[4];
endmodule
