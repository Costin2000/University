`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2021 03:03:38 PM
// Design Name: 
// Module Name: verif
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


module verif();
    reg clk_out_led_0, reset_0, pauza_0, load_0, sens_0;
    reg [5:0] data_0;
    wire [3:0] BCD0_0, BCD1_0, BCD0_1, BCD1_1;
    
    schema_wrapper wrapper(BCD0_0, BCD0_1, BCD1_0, BCD1_1, clk_out_led_0, data_0, load_0, pauza_0, reset_0, sens_0);
    
    initial begin
        clk_out_led_0 = 0; pauza_0 = 0; reset_0 = 1; load_0 = 0; sens_0 = 1; data_0 = 12; 
        #10 reset_0 = 0;
        #30 pauza_0 = 1;
        #20 pauza_0 = 0;
        #20 sens_0 = 0;
        #20 sens_0 = 1;
        #10 reset_0 = 1;
        #10 reset_0 = 0;
        #10 load_0 = 1;
        #10 load_0 = 0;
        #100 $finish;
    end

   always
        #1 clk_out_led_0 =~ clk_out_led_0;
        
endmodule        
