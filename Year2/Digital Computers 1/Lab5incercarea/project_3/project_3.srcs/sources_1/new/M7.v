`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:15:03 AM
// Design Name: 
// Module Name: M7
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


module M7(    
    mants,
    val,
    mantsRez
    );
    input [47:0] mants;
    input [8:0] val;
    output [56:0] mantsRez;
    
    assign mantsRez = {val, mants}; 
endmodule

