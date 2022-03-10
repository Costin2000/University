`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:21:23 AM
// Design Name: 
// Module Name: concatMantise
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


module concatMantise(mant1, mant2, rez);

    input [23:0] mant1;
    input [23:0] mant2;
    
    output [47:0] rez;
    
    assign rez = {mant1, mant2};


endmodule