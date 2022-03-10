`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 09:08:52 AM
// Design Name: 
// Module Name: test1
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


module test1(

    );
    reg a, b;
    wire c;
    poartaAND PAND(a, b, c);
    initial begin
        a = 0;
        b = 0;
        
        #10 a = 1;
        b = 1;
        
        #20 a = 0;
    end
endmodule
