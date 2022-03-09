`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 01:26:50 PM
// Design Name: 
// Module Name: modul_refacere_suma
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


module modul_refacere_suma(s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, sum);

    input s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15;
    output [15:0] sum;
    
    assign sum[0] = s0;
    assign sum[1] = s1;
    assign sum[2] = s2;
    assign sum[3] = s3;
    assign sum[4] = s4;
    assign sum[5] = s5;
    assign sum[6] = s6;
    assign sum[7] = s7;
    assign sum[8] = s8;
    assign sum[9] = s9;
    assign sum[10] = s10;
    assign sum[11] = s11;
    assign sum[12] = s12;
    assign sum[13] = s13;
    assign sum[14] = s14;
    assign sum[15] = s15;
    
endmodule
