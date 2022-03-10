`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2021 03:29:07 PM
// Design Name: 
// Module Name: Merge
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


module Merge();
    reg A,B,C;
    wire D;   
    design_1_wrapper instance1(A, B, C, D);  
    initial begin
    A = 1; B = 1; C = 1;
    #10 A = 1; B = 1; C = 0;
    #20 A = 1; B = 0; C = 0;
    #30 A = 0; B = 1; C = 1;
    #40 A = 0; B = 1; C = 0;
    #50 A = 0; B = 0; C = 1;
    #60 A = 0; B = 0; C = 0;
    end
endmodule
