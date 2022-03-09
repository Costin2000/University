`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 03:40:52 PM
// Design Name: 
// Module Name: test1
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


module test1();
    
    reg x_0, t_0, y_0, clock_0, enable_0, reset_0;
    wire result_0;
    
    design_1_wrapper simulare(clock_0, enable_0, reset_0, result_0, t_0, x_0, y_0);
    
    initial begin
    
    clock_0 = 0; reset_0 = 1; enable_0 = 0; 
    #10 reset_0 = 0; enable_0 = 1;
    #15 x_0 = 1; t_0 = 1; y_0 = 0;
    #50 x_0 = 0; t_0 = 1; y_0 = 1;
    #50 x_0 = 1; t_0 = 1; y_0 = 0;
    #50 x_0 = 0; t_0 = 1; y_0 = 1;
    #50 x_0 = 1; t_0 = 0; y_0 = 0;

    end
    
    always
    #25 clock_0 = ~clock_0;
endmodule
