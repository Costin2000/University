`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2021 07:51:29 PM
// Design Name: 
// Module Name: Test
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


module Test();
    reg Lei10_0, Lei5_0, Leu1_0,bautura1_0, bautura2_0, clk_0, mancare1_0, mancare2_0, reset_0, vreauRest_0;
    wire Aliment1_0, Aliment2_0, REST1_0, REST2_0, REST3_0, REST4_0, REST5_0, Suc1_0, Suc2_0;

always #25 clk_0 = ~clk_0;
    
Schema_wrapper automat(
    Aliment1_0,
    Aliment2_0,
    Lei10_0,
    Lei5_0,
    Leu1_0,
    REST1_0,
    REST2_0,
    REST3_0,
    REST4_0,
    REST5_0,
    Suc1_0,
    Suc2_0,
    bautura1_0,
    bautura2_0,
    clk_0,
    mancare1_0,
    mancare2_0,
    reset_0,
    vreauRest_0
    );

    initial begin
        Lei10_0 = 0; Lei5_0 = 0; Leu1_0 = 0; bautura1_0 = 0; bautura2_0 = 0; clk_0 = 0; mancare1_0 = 0; mancare2_0 = 0; reset_0 = 1; vreauRest_0 = 0;
        #25 reset_0 = 0;  
        #25 Lei10_0 = 1;
        #50 bautura1_0 = 1; vreauRest_0 = 1;
    end       
    
endmodule
