`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 05:37:32 PM
// Design Name: 
// Module Name: split_UAT
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


module split_UAT(carry_uat, c0, c1, c2);

    input [3:0] carry_uat;
    output c0, c1, c2;
    
    assign c0 = carry_uat[0];
    assign c1 = carry_uat[1];
    assign c2 = carry_uat[2];
endmodule
