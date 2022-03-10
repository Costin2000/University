`timescale 1ns / 1ps

module registruTampon(
    intrare, clk, reset, load, iesire
    );
    
    input intrare, clk, reset, load;
    output reg iesire; 
    
    always @(posedge clk)
    begin
        if (reset)
            iesire <= 0;
        else if (load)
            iesire <= intrare;
    end
    
endmodule
