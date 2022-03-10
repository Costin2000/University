`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2021 06:00:20 AM
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
    input L1,
    input L5,
    input L10,
    input wantCola,
    input wantFanta,
    input wantRest,
    output reg R10,
    output reg R5,
    output reg R1,
    output reg Cola,
    output reg Fanta
    );
    
    reg A, B, C, D, nextA, nextB, nextC, nextD;
    reg nextCola;
    reg nextFanta;
    reg nextR10;
    reg nextR5;
    reg nextR1;
    reg[4:0] sumaTotala, nextSumaTotala;
    
    
    always @(posedge clk)
    if (reset)
        begin
            R10 = 0;
            R5 = 0;
            R1 = 0;
            Cola = 0;
            Fanta = 0;
            A = 1; // in starea A doar se acumuleaza bani, se intra in B sau C doar daca am suf bani
            B = 0; // in starea B se primeste cola daca sun suf bani, daca nu ne intoarcem in A
            C = 0; // in starea C se primeste fanta daca sunt suf bani, daca nu ne intoarcem in A
            D = 0; // in starea D se primeste rest
            sumaTotala = 0;
        end
    else
        begin
            A = nextA; 
            B = nextB;
            C = nextC;
            D = nextD;
            Fanta = nextFanta;
            Cola = nextCola;
            R10 = nextR10;
            R5 = nextR5;
            R1 = nextR1;
            sumaTotala = nextSumaTotala;
        end
     
    always @ (*)
    begin 
       
       //Cazuri intrare A
       //-----------------------------------------------------------------------------------------------------
        if( (A & (L1 | L5 | L10)) | (A & ~L1 & ~L5 & ~L10 & ~wantCola & ~wantFanta) | (A & ~L1 & ~L5 & ~L10 & wantCola & wantFanta) | 
            (B & (L1| L5 | L10)) &  (C & (L1| L5 | L10)) & (D  & ~L1 & ~L5 & ~L10 & wantRest )  )
        begin 
        nextA = 1;      
            if(L1 & (sumaTotala + 1 <= 30))
                nextSumaTotala = sumaTotala + 1;
            else
            if(L5 & (sumaTotala + 5 <= 30))
                nextSumaTotala = sumaTotala + 5;
            else
            if(L10 & (sumaTotala + 10 <= 30))
                nextSumaTotala = sumaTotala + 10;   
        end    
        else
        nextA = 0;    
        //-----------------------------------------------------------------------------------------------------
        
        //Cazuri intrare B
        //-----------------------------------------------------------------------------------------------------
        if( (A & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala >= 3) & ~wantFanta) | (B & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala >= 3)))
           nextB = 1;
        else
            nextB = 0;
        //-----------------------------------------------------------------------------------------------------
        
        
        //Cazuri intrare C
        //-----------------------------------------------------------------------------------------------------  
        if( (A & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala >= 3) & ~wantCola) | (C & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala >= 3)))
           nextC = 1; 
        else
           nextC = 0;  
        
        
        //-----------------------------------------------------------------------------------------------------  

        //Cazuri intrare D
        //-----------------------------------------------------------------------------------------------------    
        if( (B &  ~L1 & ~L5 & ~L10 & wantRest) | (C &  ~L1 & ~L5 & ~L10 &  wantRest) | (D & (sumaTotala > 0))
            | (A & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3) & ~wantFanta) | (B & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3))
            | (A & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3) & ~wantCola) | (B & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3)))
            nextD = 1;
        else 
            nextD = 0;  
       //-----------------------------------------------------------------------------------------------------    
    
    
        //pt iesire Cola
        if( (A & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala >= 3) & ~wantFanta) | (B & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala >= 3) & ~wantRest))
        begin
           nextCola = 1;
           nextSumaTotala = sumaTotala - 3; 
        end 
        else
            nextCola = 0;
            
        //pt iesire Fanta
        if( (A & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala >= 3) & ~wantCola) | (C & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala >= 3) & ~wantRest))
        begin
           nextFanta = 1;
           nextSumaTotala = sumaTotala - 3; 
        end 
        else
            nextFanta = 0;
        
        
        
        // pt Rest10
        if(( (B &  ~L1 & ~L5 & ~L10 & wantRest) | (C &  ~L1 & ~L5 & ~L10 &  wantRest) | (D & (nextSumaTotala > 0))
            | (A & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3) & ~wantFanta) | (B & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3) & ~wantRest)
            | (A & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3) & ~wantCola) | (B & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3) & ~wantRest)) & (sumaTotala >= 10))
        begin
            nextSumaTotala = sumaTotala - 10;
            R10 = 1;
        end
        else
            R10 = 0;
            
        // pt Rest5    
        if(( (B &  ~L1 & ~L5 & ~L10 & wantRest) | (C &  ~L1 & ~L5 & ~L10 &  wantRest) | (D & (nextSumaTotala > 0))
            | (A & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3) & ~wantFanta) | (B & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3) & ~wantRest)
            | (A & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3) & ~wantCola) | (B & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3) & ~wantRest)) & (sumaTotala < 10) & (sumaTotala >= 5))
        begin
            nextSumaTotala = sumaTotala - 5;
            R5 = 1;
        end
        else
            R5 = 0;
        
        // pt Rest1    
        if(( (B &  ~L1 & ~L5 & ~L10 & wantRest) | (C &  ~L1 & ~L5 & ~L10 &  wantRest) | (D &   ~L1 & ~L5 & ~L10 & (sumaTotala > 0)) 
            | (A & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3) & ~wantFanta) | (B & ~L1 & ~L5 & ~L10 & wantCola & (sumaTotala < 3) & ~wantRest)
            | (A & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3) & ~wantCola) | (B & ~L1 & ~L5 & ~L10 & wantFanta & (sumaTotala < 3) & ~wantRest)) & (sumaTotala < 10) &  (sumaTotala < 5) & (sumaTotala >= 1))
        begin
            nextSumaTotala = sumaTotala - 1;
            R1 = 1;
        end
        else
            R1 = 0;
             
	end
        
endmodule
