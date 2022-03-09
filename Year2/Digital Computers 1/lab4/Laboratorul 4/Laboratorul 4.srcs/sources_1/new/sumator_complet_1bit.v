`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2021 06:25:10 PM
// Design Name: 
// Module Name: sumator_complet_1bit
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


module sumator_complet_1bit(a, b, c_in, p, g, sum);

    input a, b, c_in;
    output p, g, sum;
   
    assign p = (a | b);
    assign g = (a & b);
    assign sum = (a ^ b) ^ c_in;
endmodule
