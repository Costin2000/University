`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 05:42:29 PM
// Design Name: 
// Module Name: dpr
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


module dpr #(parameter biti = 32) (
    input clk, we_a, we_b,
    input [2:0] addr_a, addr_b,
    input [biti - 1:0] d_in_a, d_in_b,
    output [biti - 1:0] d_out_a, d_out_b
);
    reg [biti - 1:0] ram_vec[7:0];
    reg [biti - 1:0] tmp_a, tmp_b;
    reg [2:0] read_addr_a, read_addr_b;
    
    always @(posedge clk)
    begin
        if (we_a)
            ram_vec[addr_a] <= d_in_a;
        tmp_a <= ram_vec[addr_a];
        read_addr_a <= addr_a;
    end
    
    assign d_out_a = tmp_a;
    
    always @(posedge clk)
    begin
        if (we_b)
            ram_vec[addr_b] <= d_in_b;
        tmp_b <= ram_vec[addr_b]; 
        read_addr_b <= addr_b;
    end
    
    assign d_out_b = tmp_b;

endmodule
