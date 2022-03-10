`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 03:29:28 PM
// Design Name: 
// Module Name: Convertor1_4
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


module Convertor1_4(
    intrare, o1, o2, o3, o4
    );
    input[3:0] intrare;
    output o1, o2, o3, o4;
    
    assign o1 = intrare[0];
    assign o2 = intrare[1];
    assign o3 = intrare[2];
    assign o4 = intrare[3];
    
    
endmodule
