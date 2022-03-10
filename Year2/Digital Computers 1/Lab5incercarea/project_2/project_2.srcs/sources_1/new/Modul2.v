`timescale 1ns / 1ps

module Modul2(
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
