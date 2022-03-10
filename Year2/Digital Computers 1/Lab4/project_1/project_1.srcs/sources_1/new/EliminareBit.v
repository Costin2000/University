`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 03:50:40 PM
// Design Name: 
// Module Name: EliminareBit
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


module EliminareBit(
    carry, b0, b1, b2
    );
    
    input[3:0] carry;
    output b0, b1, b2;
    
    assign b0 = carry[0];
    assign b1 = carry[1];
    assign b2 = carry[2];
endmodule
