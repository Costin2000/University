`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2021 10:34:34 PM
// Design Name: 
// Module Name: numarator_59
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


module numarator_59(
    input clk_out_led,
    input reset,
    input pauza,
    input load,
    input direction,
    input [5:0] data,
    output reg[5:0] valoare_bin,
    output reg carry_out
    );
    
 always @(posedge clk_out_led, posedge reset)
    begin
        carry_out = 0;
        if (reset != 0) // reset numarator
        begin 
            carry_out = 0;
            valoare_bin = 0;
        end
        
        else begin
            if (load != 0)
                valoare_bin = data;
                
            else begin
                if (pauza == 0)
                begin
                    
                    if (direction <= 0)
                    begin
                        if (valoare_bin <= 0)
                        begin
                            valoare_bin = 59;
                            carry_out = 1;
                        end
                        valoare_bin = valoare_bin - 1;
                    end
                    
                    else begin
                        if (valoare_bin > 59)
                        begin
                            valoare_bin = 0;
                            carry_out = 1;
                        end
                        valoare_bin = valoare_bin + 1; 
                    end  
                end
            end
        end
     end
     
     always @ (negedge clk_out_led)
     carry_out = 0;
endmodule

