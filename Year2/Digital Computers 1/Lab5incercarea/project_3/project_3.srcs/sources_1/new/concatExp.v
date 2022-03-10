`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:22:11 AM
// Design Name: 
// Module Name: concatExp
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


module concatExp(exp1, exp2, rez);

    input [7:0] exp1;
    input [7:0] exp2;
    
    output [15:0] rez;
    
    assign rez = {exp1, exp2};
endmodule
