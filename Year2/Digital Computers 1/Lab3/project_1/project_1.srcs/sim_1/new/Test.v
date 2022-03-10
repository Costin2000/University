`timescale 1ns / 1ps

module Test();
    reg clk_0, reset_0, B1_0, B5_0, B10_0;
    wire SUC_0, REST1_0, REST5_0;
    
    always #25 clk_0 = ~clk_0;
    
    Schema_wrapper automat(
    B10_0,
    B1_0,
    B5_0,
    REST1_0,
    REST5_0,
    SUC_0,
    clk_0,
    reset_0
    );
    
    initial begin
        clk_0 = 0; reset_0 = 1;
        #25 reset_0 = 0; 
        #25 B1_0 = 1; B5_0 = 0; B10_0 = 0;
        #50 B1_0 = 1; B5_0 = 0; B10_0 = 0;
        #50 B1_0 = 1; B5_0 = 0; B10_0 = 0;
        #75 B1_0 = 0; B5_0 = 1; B10_0 = 0;
        #150 B1_0 = 0; B5_0 = 0; B10_0 = 1;
        #200 B1_0 = 0; B5_0 = 1; B10_0 = 0;
        #150 reset_0 = 1; B1_0 = 0; B5_0 = 0; B10_0 = 0;
        #125 reset_0 = 0; B1_0 = 0; B5_0 = 0; B10_0 = 1;
    end

endmodule

