`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2021 12:43:51 PM
// Design Name: 
// Module Name: sim_sumatorCLA
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


module sim_sumatorCLA();
reg [15:0] a, b;
     reg  c_in;
     wire GUAT_G, GUAT_P;
     wire [15:0] sum;
     wire c_out;
     
     sumator s(a, b, c_in, GUAT_G, GUAT_P, c_out, sum);
     
     initial begin
        c_in = 1'b0; a = 20000; b = 7000;
        #250 c_in = 1; a = 23458; b = -44;
        #250 a = -7324; b = 4567;
        #250 c_in = 0; a = -2135; b = -455;
    end
    
endmodule
