`timescale 1ns / 1ps
module Test();
    
    wire Cola_0, Fanta_0, R10_0, R1_0, R5_0;
    reg L10_0, L1_0, L5_0, clk_0, reset_0, wantCola_0, wantFanta_0, wantRest_0;
    
    always #25 clk_0 = ~clk_0;
    
    Schema_wrapper automat(
    Cola_0,
    Fanta_0,
    L10_0,
    L1_0,
    L5_0,
    R10_0,
    R1_0,
    R5_0,
    clk_0,
    reset_0,
    wantCola_0,
    wantFanta_0,
    wantRest_0
    );
    
    initial begin
        L10_0 = 0; L5_0 = 0; L1_0 = 0; clk_0 = 0; wantCola_0 = 0; wantFanta_0 = 0; wantRest_0 = 0; reset_0 = 1; 
        #50 reset_0 = 0;  
        #25 L5_0 = 1;
        #100 L5_0 = 0; wantCola_0 = 1;
        #100 wantRest_0 = 1;
        
    end
endmodule
