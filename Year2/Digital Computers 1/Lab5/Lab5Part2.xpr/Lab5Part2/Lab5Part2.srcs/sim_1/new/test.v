`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2021 04:57:11 PM
// Design Name: 
// Module Name: test
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


module test();
    
    reg a_0, b_0, clk_0, enable_0, intrare_0, reset_0;
    wire iesire_0;
    
    design_1_wrapper pipeline(a_0, b_0, clk_0, enable_0, iesire_0, intrare_0, reset_0);
    
    initial begin
    
    clk_0 = 0; reset_0 = 1; enable_0 = 0; 
    #10 reset_0 = 0; enable_0 = 1;
    #15 a_0 = 1; b_0 = 1; intrare_0 = 0;
    #50 a_0 = 0; b_0 = 1; intrare_0 = 1;
    #50 a_0 = 1; b_0 = 1; intrare_0 = 0;
    #50 a_0 = 0; b_0 = 1; intrare_0 = 1;
    #50 a_0 = 1; b_0 = 0; intrare_0 = 0;

    end
    always
    #25 clk_0 = ~clk_0;
endmodule
