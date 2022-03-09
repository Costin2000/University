`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2021 10:34:10 AM
// Design Name: 
// Module Name: GUAT
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


module GUAT(c_in, UAT_G, UAT_P, GUAT_G, GUAT_P, carry_GUAT);

    input c_in;
    input [3:0] UAT_G, UAT_P;
    output GUAT_G, GUAT_P;
    output [4:1] carry_GUAT;
    
    assign carry_GUAT[1] = (UAT_G[0] | (UAT_P[0] & c_in));
    assign carry_GUAT[2] = (UAT_G[1] | (UAT_P[1] & (UAT_G[0] | (UAT_P[0] & c_in))));
    assign carry_GUAT[3] = (UAT_G[2] | (UAT_P[2] & (UAT_G[1] | (UAT_P[1] & (UAT_G[0] | (UAT_P[0] & c_in))))));
    assign carry_GUAT[4] = (UAT_G[3] | (UAT_P[3] & (UAT_G[2] | (UAT_P[2] & (UAT_G[1] | (UAT_P[1] & (UAT_G[0] | (UAT_P[0] & c_in))))))));
    
    assign GUAT_P = (UAT_P[3] & (UAT_P[2] & (UAT_P[1] & UAT_P[0]))); 
    assign GUAT_G = (UAT_G[3] | (UAT_P[3] & (UAT_G[2] | (UAT_P[2] & (UAT_G[1] | (UAT_P[1] & UAT_G[0]))))));
endmodule
