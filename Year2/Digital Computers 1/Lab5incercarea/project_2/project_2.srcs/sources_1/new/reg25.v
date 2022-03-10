`timescale 1ns / 1ps

module reg25(rin, rout, clear, load, clock);
    output [25:0]rout;
    reg [25:0]rout;
    input [25:0]rin;
    input clear, load, clock;
    
    always @ (posedge clock)
        if(clear)
            rout <= 0;
        else if(load)
            rout <= rin;
            
endmodule
