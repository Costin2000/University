`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 02:16:53 PM
// Design Name: 
// Module Name: defalcare_UAT
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


module defalcare_UAT(c_UAT, c_in_0, c_in_1, c_in_2);

    input [3:0] c_UAT;
    output c_in_0, c_in_1, c_in_2;
    
    assign c_in_0 = c_UAT[0];
    assign c_in_1 = c_UAT[1];
    assign c_in_2 = c_UAT[2];
    
endmodule
