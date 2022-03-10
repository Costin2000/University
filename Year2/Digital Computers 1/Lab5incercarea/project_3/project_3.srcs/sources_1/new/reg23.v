`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:12:01 AM
// Design Name: 
// Module Name: reg23
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
