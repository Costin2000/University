`timescale 1ns / 1ps

module sim_automat();
    reg clk, reset, B1, B5, B10;
    wire SUC, REST1, REST5;

    always #25 clk = ~clk;

    automat autom(clk, reset, B1, B5, B10, SUC, REST1, REST5);
    
    initial begin
        clk = 0; reset = 1;
        #25 reset = 0; 
        #25 B1 = 1; B5 = 0; B10 = 0;
        #50 B1 = 1; B5 = 0; B10 = 0;
        #50 B1 = 1; B5 = 0; B10 = 0;
        #75 B1 = 0; B5 = 1; B10 = 0;
        #150 B1 = 0; B5 = 0; B10 = 1;
        #200 B1 = 0; B5 = 1; B10 = 0;
        #150 reset = 1; B1 = 0; B5 = 0; B10 = 0;
        #125 reset = 0; B1 = 0; B5 = 0; B10 = 1;
    end

endmodule
