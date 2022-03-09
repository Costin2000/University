`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2021 05:20:02 PM
// Design Name: 
// Module Name: modul_defalcare
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


module modul_defalcare(a,
                       a1,
                       a2,
                       a3,
                       a4,
                       a5,
                       a6,
                       a7,
                       a8,
                       a9,
                       a10,
                       a11,
                       a12,
                       a13,
                       a14,
                       a15,
                       a16);
    input [15:0] a;
   
    output a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16;
    
    assign a1 = a[0];
    assign a2 = a[1];
    assign a3 = a[2];
    assign a4 = a[3];
    assign a5 = a[4];
    assign a6 = a[5];
    assign a7 = a[6];
    assign a8 = a[7];
    assign a9 = a[8];
    assign a10 = a[9];
    assign a11 = a[10];
    assign a12 = a[11];
    assign a13 = a[12];
    assign a14 = a[13];
    assign a15 = a[14];
    assign a16 = a[15];
                      
    
endmodule
