`timescale 1ns / 1ps

module Modul7(
    mants,
    val,
    mantsRez
    );
    input [47:0] mants;
    input [8:0] val;
    output [56:0] mantsRez;
    
    assign mantsRez = {val, mants}; 
endmodule

