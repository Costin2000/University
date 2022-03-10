`timescale 1ns / 1ps

module automat(clk, reset, B1, B5, B10, SUC, REST1, REST5);
    input clk, reset, B1, B5, B10;
    output SUC, REST1, REST5;
    reg SUC, REST1, REST5;
    reg[2:0] current_state, next_state;

    always @(posedge clk)
    if (reset)
        begin
            SUC <= 0;
            REST1 <= 0;
            REST5 <= 0;
            current_state <= 3'b000;
        end
    else
        current_state <= next_state;

    always @(current_state or B1 or B5 or B10)
        case ({current_state, B1, B5, B10})
            6'b000100:  
                begin                                //STARE: 0, LAST INPUT: 1 leu
                    next_state = 3'b001;             //NEXT: 1 leu in aparat
                    SUC = 0; REST1 = 0; REST5 = 0;   //OUTPUT: 0
                end
            6'b001100: 
                begin                                //STARE: 1 leu in aparat, LAST INPUT: 1 leu
                    next_state = 3'b010;             //NEXT: 2 lei in aparat
                    SUC = 0; REST1 = 0; REST5 = 0;   //OUTPUT: 0
                end 
            6'b010100:  
                begin                                //STARE: 2 lei in aparat, LAST INPUT: 1 leu
                    next_state = 3'b000;             //NEXT: 0 
                    SUC = 1; REST1 = 0; REST5 = 0;   //OUTPUT: suc
                end
            6'b000010:  
                begin                                //STARE: 0, LAST INPUT: 5 lei
                    next_state = 3'b011;             //NEXT: 5 lei in aparat
                    SUC = 0; REST1 = 0; REST5 = 0;   //OUTPUT: 0
                end   
            6'b011010: 
                begin                                //STARE: 5 lei in aparat, LAST INPUT: 5 lei
                    next_state = 3'b001;             //NEXT: 1 leu in aparat
                    SUC = 1; REST1 = 1; REST5 = 0;   //OUTPUT: suc si 1 leu rest
                end
            6'b001010:  
                begin                                //STARE: 1 leu in aparat, LAST INPUT: 5 lei
                    next_state = 3'b000;             //NEXT: 0
                    SUC = 0; REST1 = 1; REST5 = 0;   //OUTPUT: 1 leu rest
                end
            6'b000001:  
                begin                                //STARE: 0, LAST INPUT: 10 lei
                    next_state = 3'b100;             //NEXT: 10 lei in aparat
                    SUC = 0; REST1 = 0; REST5 = 0;   //OUTPUT: 0
                end 
            6'b100001:
                begin                                //STARE: 10 lei in aparat, LAST INPUT: 10 lei
                    next_state = 3'b010;             //NEXT: 2 lei in aparat
                    SUC = 1; REST1 = 0; REST5 = 1;   //OUTPUT: suc si 5 lei rest
                end 
            6'b010001:
                begin                                //STARE: 2 lei in aparat, LAST INPUT: 10 lei
                    next_state = 3'b001;             //NEXT: 1 leu in aparat
                    SUC = 0; REST1 = 1; REST5 = 0;   //OUTPUT: 1 leu rest
                end
            6'b001001:
                begin                                //STARE: 1 leu in aparat, LAST INPUT: 10 lei
                    next_state = 3'b000;             //NEXT: 0
                    SUC = 0; REST1 = 1; REST5 = 0;   //OUTPUT: 1 leu rest
                end   
            default:     
                next_state = 3'b000;                     
        endcase
        
endmodule
