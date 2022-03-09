`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 11:02:45 AM
// Design Name: 
// Module Name: intrare
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


module intrare(a, b, a_out, b_out);

    input [15:0] a;
    input [15:0] b;
    
    output [15:0] a_out;
    output [15:0] b_out;
   
    assign a_out = a;
    assign b_out = b;
    
endmodule
