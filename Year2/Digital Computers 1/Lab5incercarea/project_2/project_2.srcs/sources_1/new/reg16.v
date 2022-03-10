`timescale 1ns / 1ps

module reg16(rin, rout, clear, load, clock);
    output [15:0]rout;
    reg [15:0]rout;
    input [15:0]rin;
    input clear, load, clock;
    
    always @ (posedge clock) 
        if(clear)
            rout <= 16'b0000000000000000;
        else if(load)
            rout <= rin;
           
           
            
endmodule
