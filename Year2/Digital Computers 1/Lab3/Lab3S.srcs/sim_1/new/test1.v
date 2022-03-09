`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2021 05:56:22 PM
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


module test1(

    );
    
    reg clk_0, reset_0, Ron1_0, Ron5_0, Ron10_0;
    wire SANDWICH_0, Ron_rest1_0, Ron_rest5_0;

    always #25 clk_0 = ~clk_0;

    design_1_wrapper autom(Ron10_0,
    Ron1_0,
    Ron5_0,
    Ron_rest1_0,
    Ron_rest5_0,
    SANDWICH_0,
    clk_0,
    reset_0);
    
    initial begin
        clk_0 = 0; reset_0 = 1;
        #25 reset_0 = 0; 
        #25 Ron1_0 = 1; Ron5_0 = 0; Ron10_0 = 0;
        #50 Ron1_0 = 1; Ron5_0 = 0; Ron10_0 = 0;
        #50 Ron1_0 = 1; Ron5_0 = 0; Ron10_0 = 0;
        #50 Ron1_0 = 1; Ron5_0 = 0; Ron10_0 = 0;
        #75 Ron1_0 = 0; Ron5_0 = 1; Ron10_0 = 0;
        #100 Ron1_0 = 0; Ron5_0 = 0; Ron10_0 = 1;
        #200 reset_0 = 1; Ron1_0 = 0; Ron5_0 = 0; Ron10_0 = 0;
    end
endmodule
