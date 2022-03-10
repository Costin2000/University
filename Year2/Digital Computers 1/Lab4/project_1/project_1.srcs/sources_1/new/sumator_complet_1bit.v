`timescale 1ns / 1ps

module sumator_complet_1bit(a, b, c_in, p, g, sum);
    input a, b, c_in;
    output p, g, sum;
   
    assign p = (a | b);
    assign g = (a & b);
    assign sum = (a ^ b) ^ c_in;
    
endmodule
