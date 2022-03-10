`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:16:21 AM
// Design Name: 
// Module Name: M5
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


module M5( 
   mant, mantRez, op
    );
    input op;
    input  [47:0]mant;
    output  [25:0] mantRez;
    reg  [25:0] mantRez;
    reg  [23:0]mant1;
    reg  [23:0]mant2;
    
    always @(mant)
    begin
    mant1[23:0] = mant[47:24];
    mant2[23:0] = mant[23:0];
    if(op == 0   || op == 1) begin
        if(op == 1) begin mant1[23] = mant1[23]^1; end
        if((mant1[23] == 0 && mant2[23] == 0) || (mant1[23] == 1 && mant2[23] == 1)) begin
        mantRez[23:0] = mant1[22:0] + mant2[22:0];
        mantRez[24] = mant1[23];
         end
        else begin
         if (mant1[22:0] > mant2[22:0] ) begin 
             mantRez[22:0] = mant1[22:0] - mant2[22:0];
             mantRez[23] = 0;
             mantRez[24] = mant1[23];
         end 
         else begin
            mantRez[22:0] = mant2[22:0] - mant1[22:0];
            mantRez[23] = 0;
            mantRez[24] = mant2[23];
         
         end
        end
    end 
    if(mantRez[23:0] == 24'b000000000000000000000000) begin
     mantRez[25] = 1; end 
     else begin
      mantRez[25] = 0; end
    
    
    end
    
endmodule