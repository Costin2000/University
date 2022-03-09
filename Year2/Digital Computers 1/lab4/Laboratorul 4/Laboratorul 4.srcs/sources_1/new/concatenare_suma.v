`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 04:53:47 PM
// Design Name: 
// Module Name: concatenare_suma
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


module concatenare_suma(sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12, sum13, sum14, sum15, sum_out);

    input sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12, sum13, sum14, sum15;
    output [15:0] sum_out;
    
    assign sum_out[0] = sum0;
    assign sum_out[1] = sum1;
    assign sum_out[2] = sum2;
    assign sum_out[3] = sum3;
    assign sum_out[4] = sum4;
    assign sum_out[5] = sum5;
    assign sum_out[6] = sum6;
    assign sum_out[7] = sum7;
    assign sum_out[8] = sum8;
    assign sum_out[9] = sum9;
    assign sum_out[10] = sum10;
    assign sum_out[11] = sum11;
    assign sum_out[12] = sum12;
    assign sum_out[13] = sum13;
    assign sum_out[14] = sum14;
    assign sum_out[15] = sum15;
endmodule
