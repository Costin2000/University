`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 03:12:05 PM
// Design Name: 
// Module Name: registruBuffer
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


module registruBuffer(y, clock, reset, enable, result);

    input y, clock, reset, enable;
    output reg result;
    
    always @(posedge clock)
    begin
        if (reset)
            result <= 0;
        else if (enable)
            result <= y;
    
    end
endmodule
