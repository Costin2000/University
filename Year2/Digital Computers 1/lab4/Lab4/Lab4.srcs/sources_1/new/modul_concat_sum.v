`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2021 02:17:51 PM
// Design Name: 
// Module Name: modul_concat_sum
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


module modul_concat_sum(p1, p2, p3, p4, g1, g2, g3, g4, g_out, p_out);
    input p1;
    input p2;
    input p3;
    input p4;
    input g1;
    input g2;
    input g3;
    input g4;
    output [3:0] g_out;
    output [3:0] p_out;
    
    assign p_out[0] = p1;
    assign p_out[1] = p2;
    assign p_out[2] = p3;
    assign p_out[3] = p4;
    
    assign g_out[0] = g1;
    assign g_out[1] = g2;
    assign g_out[2] = g3;
    assign g_out[3] = g4;
    
endmodule
