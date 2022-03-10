`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 03:22:25 PM
// Design Name: 
// Module Name: Modul4
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


module Modul4(
    mant, mantRez
    );
    input [56:0]mant;
    output [47:0] mantRez;
    reg [47:0] mantRez;
    reg [8:0]exp;
    reg [23:0] m1;
    reg [23:0] m2;
    
    always @ (mant)
    begin
    exp[8:0] = mant[56:48];
    m1[23:0] = mant[47:24];
    m2[23:0] = mant[23:0];
    if(exp[8] == 0)
    begin
        m2[22:0]  = m2[22:0] >> exp[7:0];
    end else begin
        m1[22:0] = m1[22:0] >> exp[7:0];
    end   
    mantRez[47:0] = {m1[23:0], m2[23:0]};
    end
endmodule
