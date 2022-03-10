`timescale 1ns / 1ps

module reg47(rin, rout, clear, load, clock);
    output [47:0]rout;
    reg [47:0]rout;
    input [47:0]rin;
    input clear, load, clock;
    
    always @ (posedge clock)
        if(clear)
            rout <= 0;
        else if(load)
            rout <= rin;
            
endmodule
