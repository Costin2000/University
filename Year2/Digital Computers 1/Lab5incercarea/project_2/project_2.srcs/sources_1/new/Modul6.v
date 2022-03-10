`timescale 1ns / 1ps



module Modul6(
    mant, mfinal, val2
    );
    input [25:0] mant;
    output [23:0] mfinal;
    output [8:0] val2;
    reg [23:0] mfinal;
    reg [8:0] val2;
    reg [25:0] maux;
    
    always @(mant) begin
        maux[25:0] = mant[25:0];
        val2[8] = maux[24];
        val2[7:0] = 8'b00000000;
        if(mant[25] == 0) begin
            while(maux[23] != 1) begin
                maux = maux << 1;
                val2[7:0] = val2[7:0] +1;
            end
        end
        mfinal[22:0] = maux[23:1];
        mfinal[23] = mant[24];
    end
    
endmodule
