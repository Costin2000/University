`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 11:22:31 AM
// Design Name: 
// Module Name: extragere_GUAT
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


module extragere_GUAT(carry_GUAT, carry1, carry2, carry3, carry4);

    input [4:1] carry_GUAT;
    output carry1, carry2, carry3, carry4;
    
    assign carry1 = carry_GUAT[1];
    assign carry2 = carry_GUAT[2];
    assign carry3 = carry_GUAT[3];
    assign carry4 = carry_GUAT[4];
    
endmodule
