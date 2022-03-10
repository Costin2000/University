`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 02:54:08 PM
// Design Name: 
// Module Name: Convertor4_1
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


module Convertor4_1(
    var1, var2, var3, var4, iesire
    );
    input var1, var2, var3, var4;
    output[3:0] iesire;
    
    assign iesire[0] = var1; 
    assign iesire[1] = var2;
    assign iesire[2] = var3;
    assign iesire[3] = var4;
    
endmodule
