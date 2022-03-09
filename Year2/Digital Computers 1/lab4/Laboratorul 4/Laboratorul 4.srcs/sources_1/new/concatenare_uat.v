`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 05:15:41 PM
// Design Name: 
// Module Name: concatenare_uat
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


module concatenare_uat(p0, p1, p2, p3, g0, g1, g2, g3, g_out, p_out);

    input p0, p1, p2, p3, g0, g1, g2, g3;
    output [3:0] g_out, p_out;
    
    assign g_out[0] = g0;
    assign g_out[1] = g1;
    assign g_out[2] = g2;
    assign g_out[3] = g3;
    
    assign p_out[0] = p0;
    assign p_out[1] = p1;
    assign p_out[2] = p2;
    assign p_out[3] = p3;
endmodule
