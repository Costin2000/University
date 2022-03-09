`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2021 06:28:55 PM
// Design Name: 
// Module Name: test
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


module test();
     reg [15:0] a, b;
     reg  c_in;
     wire GUAT_G, GUAT_P;
     wire [15:0] sum;
     wire c_out;
     
     sumator s(a, b, c_in, GUAT_G, GUAT_P, c_out, sum);
     
     initial begin
        c_in = 1'b0; a = 10000; b = 5000;
        #250 c_in = 1'b1; a = 16678; b = -23;
        #250 a = -5634; b = 18834;
        #250 c_in = 0; a = -12345; b = -355;
    end
    
endmodule
