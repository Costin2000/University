`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 03:38:35 PM
// Design Name: 
// Module Name: Convertor16_1
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


module Convertor16_1(
    a, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15
    );
    
    output[15:0] a;
    input a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15;
    
    assign a[0] = a0;
    assign a[1] = a1;
    assign a[2] = a2;
    assign a[3] = a3;
    assign a[4] = a4;
    assign a[5] = a5;
    assign a[6] = a6;
    assign a[7] = a7;
    assign a[8] = a8;
    assign a[9] = a9;
    assign a[10] = a10;
    assign a[11] = a11;
    assign a[12] = a12;
    assign a[13] = a13;
    assign a[14] = a14;
    assign a[15] = a15;
endmodule
