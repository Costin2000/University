`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 07:34:17 AM
// Design Name: 
// Module Name: test
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


module test(

    );
    reg [23:0] mant1;
    reg [23:0] mant2;
    reg [7:0] exp1;
    reg [7:0] exp2; 
    wire[7:0] expRez;
    reg op;
    wire[23:0] mantRez;  
    reg clear;
    reg load;
    reg clock;  
 topModule ok(mant1, mant2 , exp1, exp2, op, clear, load, clock, expRez, mantRez);

    always
    #10 clock = !clock;
    initial
    begin
    clock = 1;
    load = 1;
    clear =0;
    #30;
     op = 0;
    exp1 = 8'b00000001;
    exp2 = 8'b00000010;
    mant1 = 24'b000000000000000000000001;
    mant2 = 24'b000000000000000000000010;
    #200;
    exp1 = 8'b00001001;
    exp2 = 8'b00000011;
    mant1 = 24'b000000000010001000000001;
    mant2 = 24'b000000000000101000000010;
    #200;
    exp1 = 8'b00101001;
    exp2 = 8'b00000010;
    mant1 = 24'b000000000000111000000001;
    mant2 = 24'b100100010000010000000010;
    #200;
    exp1 = 8'b00101001;
    exp2 = 8'b00110010;
    mant1 = 24'b100000000000111000000001;
    mant2 = 24'b000100010000010000000010;
    #300;
    end
  
endmodule
