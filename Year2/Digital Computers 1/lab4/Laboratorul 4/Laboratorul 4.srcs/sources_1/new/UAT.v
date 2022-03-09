`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2021 06:26:06 PM
// Design Name: 
// Module Name: UAT
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


module UAT(c_in, g_in, p_in, UAT_G, UAT_P, carry_UAT);

    input c_in;
    input [3:0] g_in, p_in;
    output UAT_G, UAT_P;
    output [3:0] carry_UAT;
    
    assign carry_UAT[0] = (g_in[0] | (p_in[0] & c_in));
    assign carry_UAT[1] = (g_in[1] | (p_in[1] & (g_in[0] | (p_in[0] & c_in))));
    assign carry_UAT[2] = (g_in[2] | (p_in[2] & (g_in[1] | (p_in[1] & (g_in[0] | (p_in[0] & c_in))))));
    assign carry_UAT[3] = (g_in[3] | (p_in[3] & (g_in[2] | (p_in[2] & (g_in[1] | (p_in[1] & (g_in[0] | (p_in[0] & c_in))))))));
    
    assign UAT_P = (p_in[3] & (p_in[2] & (p_in[1] & p_in[0])));
    assign UAT_G = (g_in[3] | (p_in[3] & (g_in[2] | (p_in[2] & (g_in[1] | (p_in[1] & g_in[0]))))));
endmodule
