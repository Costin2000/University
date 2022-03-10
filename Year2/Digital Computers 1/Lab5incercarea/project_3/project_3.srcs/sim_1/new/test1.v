`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 06:49:11 AM
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
    
    reg [23:0] mant1_0;
    reg [23:0] mant2_0;
    reg [7:0] exp1_0;
    reg [7:0] exp2_0; 
    wire[7:0] rout_1;
    reg op_0;
    wire[23:0] rout_0;  
    reg clear_0;
    reg load_0;
    reg clock_0; 
     
    design_1_wrapper ok(clear_0, clock_0, exp1_0, exp2_0, load_0, mant1_0, mant2_0, op_0, rout_0, rout_1);

    always
    #10 clock_0 = !clock_0;
    initial
    begin
    clock_0 = 1;
    load_0 = 1;
    clear_0 =0;
 
     op_0 = 0;
    
    //2.25
    //3.5
    #20;
    exp1_0 = 8'b10000000;
    exp2_0 = 8'b10000000;
    mant1_0 = 24'b000100000000000000000000; 
    mant2_0 = 24'b011000000000000000000000; 

    
    end
endmodule
