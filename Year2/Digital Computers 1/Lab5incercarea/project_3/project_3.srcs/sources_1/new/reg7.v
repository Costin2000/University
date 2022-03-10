`timescale 1ns / 1ps

module reg7(rin, rout, clear, load, clock);
    output [7:0]rout;
    reg [7:0]rout;
    input [7:0]rin;
    input clear, load, clock;
    
    always @ (posedge clock)
        if(clear)
            rout <= 0;
        else if(load)
            rout <= rin;
            
endmodule