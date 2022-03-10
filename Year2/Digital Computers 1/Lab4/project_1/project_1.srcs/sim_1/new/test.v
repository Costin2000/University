`timescale 1ns / 1ps

module test();
     reg [15:0] a, b;
     reg  c_in;
     wire GUAT_G, GUAT_P;
     wire [15:0] sum;
     wire c_out;
     
     sumator s(a, b, c_in, GUAT_G, GUAT_P, c_out, sum);
     
     initial begin
        c_in = 1'b0; a = 6969; b = 69;
        #250 c_in = 1'b1; a = 1234; b = -23;
        #250 a = -666; b = 66;
        #250 c_in = 0; a = -420; b = -23;
    end
    
endmodule