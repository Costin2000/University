`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2021 09:08:42 PM
// Design Name: 
// Module Name: automat
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


module automat(
        input clock, Ron10, Ron5, Ron1, reset, Rest,
        output reg Rest5, Rest1, Ceai, Procesare,
        output reg [2:0] stare
    );
    
    reg S0, S0_next, S1, S1_next, S2, S2_next, S3, S3_next, S4, S4_next, S5, S5_next, S6, S6_next; 
    reg Rest5_next, Rest1_next, Ceai_next;
    reg [2:0] sum; 
    
    always @(posedge clock, posedge reset)
    begin
        if(reset)
        begin
            S0 = 1;
            S1 = 0;
            S2 = 0;
            S3 = 0;
            S4 = 0;
            S5 = 0;
            S6 = 0;
            Rest5 = 0;
            Rest1 = 0;
            Ceai = 0;
            stare = 0;
            Procesare = 0;
        end else
        begin
            S0 = S0_next;
            S1 = S1_next;
            S2 = S2_next;
            S3 = S3_next;
            S4 = S4_next;
            S5 = S5_next;
            S6 = S6_next;
            Rest5 = Rest5_next;
            Rest1 = Rest1_next;
            Ceai = Ceai_next;
            if(S0) stare = 0;
            if(S1) stare = 1;
            if(S2) stare = 2;
            if(S3) stare = 3;
            if(S4) stare = 4;
            if(S5) stare = 5;
            if(S6) stare = 6;
        end
    end
    
    always @ (Ron10 or Ron5 or Ron1 or S0 or S1 or S2 or S3 or S4 or S5 or S6 or Rest)
	begin
        sum = Ron10 + Ron5 + Ron1 + Rest;
        Procesare = 1;
        if(Rest)
        begin
            S0_next = 0;
            S1_next = 0;
            S2_next = 0;
            S3_next = 0;
            S4_next = 0;
            S5_next = 0;
            S6_next = 0;
            if(S0) S0_next = 1;
            if(S3) S3_next = 1;
            if(S4) S4_next = 1;
            if(S5) S5_next = 1;
            if(S6) S6_next = 1;
               
            if(S1)
            begin
                if(~Ron10 & ~Ron5 & ~Ron1)
                    S0_next = 1;
                else S1_next = 1;
            end
            if(S2)
            begin
                if(~Ron10 & ~Ron5 & ~Ron1)
                    S3_next = 1;
                else S2_next = 1;
            end    
        end else
        begin
        
            if ( Ron1 & Ron5 & S0 | Ron1 & Ron10 & S0 | Ron5 & Ron10 & S0 | ~Ron1 & ~Ron5 & ~Ron10 & S0  
            | Ron1 & ~Ron5 & ~Ron10 & S2 | S3 | ~Ron1 & ~Ron5 & ~Ron10 & Rest & S1 ) S0_next=1;
            else S0_next=0;
    
            if (Ron1 & Ron5 & S1 | Ron1 & Ron10 & S1 | Ron5 & Ron10 & S1 | ~Ron1 & ~Ron5 & ~Ron10 & S1 |
            Ron1 & ~Ron5 & ~Ron10 & S0) 
              S1_next = 1;
            else S1_next = 0;
    
            if ( Ron1 & Ron5 & S2 | Ron1 & Ron10 & S2 | Ron5 & Ron10 & S2 | ~Ron1 & ~Ron5 & ~Ron10 & S2 |
                 Ron1 & ~Ron5 & ~Ron10 & S1 ) S2_next = 1;
            else S2_next=0;
    
            if ( ~Ron10 & Ron5 & ~Ron1 & S0 | S4 | ~Ron1 & ~Ron5 & ~Ron10 & Rest & S2) S3_next = 1;
            else S3_next = 0;
    
            if ( Ron10 & ~Ron5 & ~Ron1 & S0 | ~Ron10 & Ron5 & ~Ron1 & S1 | S5 ) S4_next = 1;
            else S4_next = 0;
    
            if ( Ron10 & ~Ron5 & ~Ron1 & S1 | ~Ron10 & Ron5 & ~Ron1 & S2 | S6 ) S5_next = 1;
            else S5_next=0;
    
            if ( Ron10 & ~Ron5 & ~Ron1 & S2 ) S6_next = 1;
            else S6_next = 0;
        end

		if ( Ron10 & ~Ron5 & ~Ron1 & S0 | Ron10 & ~Ron5 & ~Ron1 & S2 | Ron10 & ~Ron5 & ~Ron1 & S1 ) Rest5_next = 1;
		else Rest5_next = 0;

		if ( S3 |  ~Ron10 & Ron5 & ~Ron1 & S1 | ~Ron10 & Ron5 & ~Ron1 & S2 | S5 | S6 
		| ~Ron10 & Ron5 & ~Ron1 & S0 | S4 | ~Ron1 & ~Ron5 & ~Ron10 & Rest & S1 | ~Ron1 & ~Ron5 & ~Ron10 & Rest & S2) 
			Rest1_next = 1;
		else Rest1_next = 0;

		if ( Ron10 & ~Ron5 & ~Ron1 & S0 | ~Ron10 & Ron5 & ~Ron1 & S0 | ~Ron10 & Ron5 & ~Ron1 & S1 | Ron10 & ~Ron5 & ~Ron1 & S1
		| ~Ron10 & Ron5 & ~Ron1 & S2 | Ron10 & ~Ron5 & ~Ron1 & S2 | ~Ron10 & ~Ron5 & Ron1 & S2)
			 Ceai_next = 1;
		else Ceai_next = 0;
	end
	
	
	
	
	
	always @(negedge clock)
	begin
//	    Rest5 = 0;
//        Rest1 = 0;
//        Ceai = 0;
        if(S6 | S4 | S3 | S5)
            Procesare = 1;
        else Procesare = 0;    
	end
endmodule
