`timescale 1ns / 1ps

module numarator_59(
    input clk_out_led,
    input reset,
    input pauza,
    input load,
    input [5:0] data,
    input sens,
    output reg[5:0] valoare_bin,
    output reg carry_out
    );

always@(posedge clk_out_led, posedge reset)
    begin
        if (reset)
            begin
                valoare_bin  = 0;
                carry_out = 0;
            end
        else
        begin
            if (load)
                valoare_bin = data;
            else
            begin  
                if(!pauza)
                begin
                    if(sens)
                    begin
                        if (valoare_bin > 59)
                        begin
                            valoare_bin = 0;
                            carry_out = 1;
                        end
                        valoare_bin = valoare_bin + 1;
                    end 
                    else
                    begin
                        if (valoare_bin < 1)
                        begin
                            valoare_bin = 59;
                            carry_out = 1;
                        end 
                        valoare_bin = valoare_bin - 1;
                    end
                end
            end
        end
    end
endmodule