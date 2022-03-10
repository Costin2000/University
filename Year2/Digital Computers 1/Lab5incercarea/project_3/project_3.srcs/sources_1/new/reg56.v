`timescale 1ns / 1ps

module reg56(rin, rout, clear, load, clock);
    output [56:0]rout;
    reg [56:0]rout;
    input [56:0]rin;
    input clear, load, clock;
    
    always @ (posedge clock)
        if(clear)
            rout <= 0;
        else if(load)
            rout <= rin;
            
endmodule
