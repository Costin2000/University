`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2021 04:20:01 PM
// Design Name: 
// Module Name: memoryBuffer
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


module memoryBuffer(intrare, clk, reset, enable, iesire);

    input intrare, clk, reset, enable;
    output reg iesire;
    
    always @(posedge clk)
    begin
        if (reset)
            iesire <= 0;
        else if (enable) 
            iesire <= intrare;
   end
endmodule
