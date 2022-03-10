`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:17:38 AM
// Design Name: 
// Module Name: M3
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


module M3(
   exp,  val, rez
    );
    input [7:0] exp;
    input [8:0] val;
    output [7:0] rez;
    reg [7:0] rez;
    
    always @(*)
    begin
    if(val[8] == 0) 
    begin
    rez[7:0] = exp[7:0] + val[7:0];
    end else 
    begin rez[7:0] = exp[7:0] - val[7:0];
    //rez = exp - val;
    end
    
    end
    
endmodule

