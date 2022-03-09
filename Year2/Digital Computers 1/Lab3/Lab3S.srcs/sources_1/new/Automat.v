`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2021 11:49:27 AM
// Design Name: 
// Module Name: Automat
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


module Automat(
    input clk,
    input reset,
    input Ron1,
    input Ron5,
    input Ron10,
    output reg SANDWICH, // costa 4 lei
    output reg Ron_rest1,
    output reg Ron_rest5
    );
    
    reg[2:0] current_state, next_state;
    
    always @(posedge clk)
    if (reset != 0)
        begin
            SANDWICH = 0;
            Ron_rest1 = 0;
            Ron_rest5 = 0;
            current_state = 3'b000;
        end
    else
        current_state = next_state;
        
   always @(current_state or Ron1 or Ron5 or Ron10)
        case ({current_state, Ron1, Ron5, Ron10})
            6'b000100:  
                begin                                             //Stare initiala, introduc 1 leu in aparat
                    next_state = 3'b001;                          
                    SANDWICH = 0; Ron_rest1 = 0; Ron_rest5 = 0;  
                end
            6'b001100: 
                begin                                             //Mai introduc 1 leu in aparat
                    next_state = 3'b010;                          //Acum: 2 lei in aparat
                    SANDWICH = 0; Ron_rest1 = 0; Ron_rest5 = 0;   
                end 
            6'b010100:  
                begin                                             //Mai introduc 1 leu in aparat
                    next_state = 3'b011;                          //Acum: 3 lei in aparat
                    SANDWICH = 0; Ron_rest1 = 0; Ron_rest5 = 0;  
                end
            6'b011100:  
                begin                                             //Mai introduc 1 leu in aparat
                    next_state = 3'b011;                          //Acum: 4 lei in aparat
                    SANDWICH = 1; Ron_rest1 = 0; Ron_rest5 = 0;   //Primesc sandwich-ul
                end
            6'b000010:  
                begin                                             //Stare initiala, introduc 5 lei
                    next_state = 3'b001;                          
                    SANDWICH = 0; Ron_rest1 = 0; Ron_rest5 = 0;   
                end
            6'b001010:  
                begin                                             //Acum: 5 lei in aparat
                    next_state = 3'b000;                          //Primesc sandwich-ul si rest 1 leu
                    SANDWICH = 1; Ron_rest1 = 1; Ron_rest5 = 0;   
                end 
            6'b000001:  
                begin                                             //Stare initiala: introduc 10 lei
                    next_state = 3'b001;                          
                    SANDWICH = 0; Ron_rest1 = 0; Ron_rest5 = 0;   
                end
            6'b001001:  
                begin                                             //Acum: 10 lei in aparat
                    next_state = 3'b010;                          //Primesc sandwich-ul si rest 5 lei
                    SANDWICH = 1; Ron_rest1 = 0; Ron_rest5 = 1;   
                end 
             6'b010001:  
                begin                                             //Acum 1 leu in aparat
                    next_state = 3'b000;                          //Primesc 1 leu rest
                    SANDWICH = 0; Ron_rest1 = 1; Ron_rest5 = 0;   
                end      
                     
            default:     
                next_state = 3'b000;                     
        endcase
endmodule
