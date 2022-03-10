`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 03:10:16 PM
// Design Name: 
// Module Name: Convertor2_32
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


module Convertor2_32(
    a, b, cin,
    a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15,
    b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15
    );
    
    
    input[15:0] a, b;
    input cin;
    output a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15,
    b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15;
    
    
    assign a0 = a[0];
    assign a1 = a[1];
    assign a2 = a[2];
    assign a3 = a[3];
    assign a4 = a[4];
    assign a5 = a[5];
    assign a6 = a[6];
    assign a7 = a[7];
    assign a8 = a[8];
    assign a9 = a[9];
    assign a10 = a[10];
    assign a11 = a[11];
    assign a12 = a[12];
    assign a13 = a[13];
    assign a14 = a[14];
    assign a15 = a[15];
    
    assign b0 = b[0];
    assign b1 = b[1];
    assign b2 = b[2];
    assign b3 = b[3];
    assign b4 = b[4];
    assign b5 = b[5];
    assign b6 = b[6];
    assign b7 = b[7];
    assign b8 = b[8];
    assign b9 = b[9];
    assign b10 = b[10];
    assign b11 = b[11];
    assign b12 = b[12];
    assign b13 = b[13];
    assign b14 = b[14];
    assign b15 = b[15];
endmodule

    