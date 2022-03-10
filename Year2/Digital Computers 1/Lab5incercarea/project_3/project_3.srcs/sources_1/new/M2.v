`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:18:18 AM
// Design Name: 
// Module Name: M2
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


module M2(
    exp,
    rez
    );
    input [15:0]exp;
    output[7:0] rez;
    reg [7:0] rez;
    always @(exp)
    begin
    if (exp[15:8] > exp[7:0])
    begin
      rez[7:0] = exp[15:8];
     end
    else rez[7:0] = exp[7:0]; 
    end
    
endmodule
