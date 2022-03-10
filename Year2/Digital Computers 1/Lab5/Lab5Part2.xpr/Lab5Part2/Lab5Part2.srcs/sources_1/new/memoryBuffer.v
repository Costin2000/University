`timescale 1ns / 1ps


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
