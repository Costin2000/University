`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 05:59:04 PM
// Design Name: 
// Module Name: test2
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


module test2(

    );
    
    reg [15:0] a_0, b_0;
    reg c_in_0;
    wire [15:0] sum_out_0;
    wire GUAT_G_0, GUAT_P_0, carry4_0;
    
    design_1_wrapper sumator(GUAT_G_0, GUAT_P_0, a_0, b_0, c_in_0, carry4_0, sum_out_0);
    
    initial begin
        c_in_0 = 1'b0; a_0 = 24000; b_0 = 5000;
        #250 c_in_0 = 1; a_0 = 23580; b_0 = -489;
        #250 a_0 = -1234; b_0 = 2000;
        #250 c_in_0 = 0; a_0 = -5875; b_0 = -235;
    end
endmodule
