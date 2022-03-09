`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2021 10:48:55 AM
// Design Name: 
// Module Name: sim_sumator
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


module sim_sumator(

    );
    
    reg a, b, c_in;
    wire p, g, sum;
    
    sumator_complet_1bit sumator(a, b, c_in, p, g, sum);
    
    initial begin
        a = 1'b0; b = 1'b0; c_in = 1'b0;
        #50 a = 1'b0; b = 1'b0; c_in = 1'b1;
        #50 a = 1'b0; b = 1'b1; c_in = 1'b0;
        #50 a = 1'b0; b = 1'b1; c_in = 1'b1;
        #50 a = 1'b1; b = 1'b0; c_in = 1'b0;
        #50 a = 1'b1; b = 1'b0; c_in = 1'b1;
        #50 a = 1'b1; b = 1'b1; c_in = 1'b0;
        #50 a = 1'b1; b = 1'b1; c_in = 1'b1;
    end
endmodule
