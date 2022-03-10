`timescale 1ns / 1ps

module reg23(rin, rout, clear, load, clock);
    output [23:0]rout;
    reg [23:0]rout;
    input [23:0]rin;
    input clear, load, clock;
    
    always @ (posedge clock)
        if(clear)
            rout <= 24'b000000000000000000000000;
        else if(load)
            rout <= rin;
            
endmodule
