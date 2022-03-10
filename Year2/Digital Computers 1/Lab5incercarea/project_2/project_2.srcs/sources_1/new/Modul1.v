`timescale 1ns / 1ps


module Modul1(
 exp, 
 rez,
rez2
);
input [15:0]exp;
output [15:0]rez;
output [8:0]rez2;
reg [8:0] rez2;
   assign rez[15:0] = exp[15:0];
   always @ ( exp) begin 
   if( exp[7:0] >= exp[15:8])
   begin
    rez2[8] = 1'b1;
    rez2[7:0]  = exp[7:0] -  exp[15:8];
    end
    else begin
       rez2[8] = 1'b0;
       rez2[7:0] = exp[15:8] - exp[7:0];  
    end
 end
    
endmodule
