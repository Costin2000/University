`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 12:36:15 PM
// Design Name: 
// Module Name: modul_concat_uat
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


module modul_concat_uat(p0, p1, p2, p3, g0, g1, g2, g3, uat_g, uat_p);

    input p0, p1, p2, p3, g0, g1, g2, g3;
    output [3:0] uat_g;
    output [3:0] uat_p;
    
    assign uat_g[0] = g0;
    assign uat_g[1] = g1;
    assign uat_g[2] = g2;
    assign uat_g[3] = g3;
    
    assign uat_p[0] = p0;
    assign uat_p[1] = p1;
    assign uat_p[2] = p2;
    assign uat_p[3] = p3;
endmodule
