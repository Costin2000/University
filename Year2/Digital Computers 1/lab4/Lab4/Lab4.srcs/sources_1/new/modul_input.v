`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 09:10:12 AM
// Design Name: 
// Module Name: modul_input
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


module modul_input(a, b, c_in, a_out, b_out, c_in_out);

    input [15:0] a;
    input [15:0] b;
    input c_in;
    output [15:0] a_out;
    output [15:0] b_out;
    output c_in_out;
    
    assign a_out = a;
    assign b_out = b;
    assign c_in_out = c_in;
endmodule
