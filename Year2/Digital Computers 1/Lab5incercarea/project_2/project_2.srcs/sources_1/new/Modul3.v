`timescale 1ns / 1ps


module Modul3(
    exp,  val, rez
    );
    input [7:0] exp;
    input [8:0] val;
    output [7:0] rez;
    reg [7:0] rez;
    
    always @(exp)
    begin
    //if(val[8] == 1) 
    //begin
   //rez[7:0] = exp[7:0] + val[7:0];
    //end else 
    //begin rez[7:0] = exp[7:0] - val[7:0];
    rez = exp - val[7:0] ;
    //end
    
    end
    
endmodule