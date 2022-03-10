`timescale 1ns / 1ps


module Test();
    reg INPUT_0, a_0, b_0, clk_0, load_0, reset_0;
    wire iesire_0;
    
    schema_wrapper schema(INPUT_0, a_0, b_0, clk_0, iesire_0,load_0, reset_0);
    
    initial begin
    
    clk_0 = 0; reset_0 = 1; load_0 = 0;
    
    #10 reset_0 = 0; load_0 = 1;
    #15 a_0 = 1; b_0 = 1; INPUT_0 = 0;
    #50 a_0 = 0; b_0 = 0; INPUT_0 = 1;
    #50 a_0 = 1; b_0 = 1; INPUT_0 = 0;
    #50 a_0 = 1; b_0 = 0; INPUT_0 = 1;
    #50 a_0 = 0; b_0 = 1; INPUT_0 = 0;
    
    end
    always 
    #25 clk_0 = ~clk_0;
    
endmodule
