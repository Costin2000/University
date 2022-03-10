`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 02:01:35 PM
// Design Name: 
// Module Name: registruTampon
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


module registruTampon(intrare, clk, reset, enable, iesire);

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
