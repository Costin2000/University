`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2021 04:40:51 PM
// Design Name: 
// Module Name: test_ceas1
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


module test_ceas1(
   
    );
    
    reg clk_out_led_0, reset_0, pauza_0, load_0, direction_0;
    reg [5:0] data_0;
    wire [3:0] BCD0_0, BCD1_0, BCD0_1, BCD1_1;
    
    ceas_figure_wrapper wrapper_test(BCD0_0, BCD0_1, BCD1_0, BCD1_1, clk_out_led_0, data_0, direction_0, load_0, pauza_0, reset_0);
    
    initial begin
       clk_out_led_0 = 0; 
       pauza_0 = 0; 
       reset_0 = 1; 
       load_0 = 0; 
       direction_0 = 1; 
       data_0 = 13;
       
       #1 reset_0 = 0;
       
       #700 direction_0 = 0;
       #1475 reset_0 = 1;
      
       
        
       #2000 $finish;
    
    end
    
    always
       #1 clk_out_led_0 =~ clk_out_led_0;
    
    
    
    
endmodule
