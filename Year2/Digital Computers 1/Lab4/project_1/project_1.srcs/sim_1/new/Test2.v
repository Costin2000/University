`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 04:14:24 PM
// Design Name: 
// Module Name: Test2
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


module Test2(
    
    );
    reg[15:0] a_0, b_0;
    reg cin_0;
    wire GUAT_G_0, GUAT_P_0, o4_0;
    wire[15:0] a_1;
    Schema_wrapper test2(GUAT_G_0, GUAT_P_0, a_0, a_1, b_0, cin_0, o4_0);
    
    initial begin
    cin_0 = 1'b0; a_0 = 9669; b_0 = 31;
    #250 cin_0 = 1'b1; a_0 = 1234; b_0 = -23;
    #250 a_0 = -666; b_0 = 66;
    #250 cin_0 = 0; a_0 = -420; b_0 = -23;
    end
    
    
endmodule
