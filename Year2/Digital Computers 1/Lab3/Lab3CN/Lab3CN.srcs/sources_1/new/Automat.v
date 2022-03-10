`timescale 1ns / 1ps

module Automat(
    input clk,
    input reset,
    input Leu1,
    input Lei5,
    input Lei10,
    input bautura1,
    input bautura2,
    input mancare1,
    input mancare2,
    input vreauRest,
    output reg Suc1,
    output reg Suc2,
    output reg Aliment1,
    output reg Aliment2,
    output reg REST1,
    output reg REST2,
    output reg REST3,
    output reg REST4,
    output reg REST5
    );
    //Suc1 3 lei   ---->  bautura1 == 1
    //Suc2 5 lei   ---->  bautura2 == 1 
    //Aliment1 2 lei  ----> mancare1 == 1
    //Aliment2 7 lei  ----> mancare2 == 1
    
    integer sumaTotala; 
    
    always @(posedge clk, posedge reset)
    if (reset)
        begin
            Suc1 <= 0;
            Suc2 <= 0;
            Aliment1 <= 0;
            Aliment2 <= 0;
            REST1 <= 0;
            REST2 <= 0;
            REST3 <= 0;
            REST4 <= 0;
            REST5 <= 0;
            sumaTotala <= 0;
        end
    else 
        begin
        //Suc1 = 0; Suc2 =0; Aliment1 = 0; Aliment2 = 0; REST1 = 0; REST2 = 0; REST3 = 0; REST4 = 0; REST5 = 0;
         
            if(Leu1)
                sumaTotala = sumaTotala + 1;
                
            if(Lei5)
                sumaTotala = sumaTotala + 5;
                
           if(Lei10)
                sumaTotala = sumaTotala + 10;
          
           //---------------------------------------------------------------      
           if( (bautura1) && (sumaTotala > 3))
           begin
                sumaTotala = sumaTotala - 3;
                Suc1 = 1; Suc2 =0; Aliment1 = 0; Aliment2 = 0;
           end
           //----------------------------------------------------------------
           if( (bautura2) && (sumaTotala > 5) )
           begin
                sumaTotala = sumaTotala - 5;
                Suc1 = 0; Suc2 =1; Aliment1 = 0; Aliment2 = 0;
           end
           //----------------------------------------------------------------
           if( (mancare1) && (sumaTotala > 2))
           begin
                sumaTotala = sumaTotala - 2;
                Suc1 = 0; Suc2 =0; Aliment1 = 1; Aliment2 = 0;
           end
           //-----------------------------------------------------------------
           if( (mancare2) && (sumaTotala > 7) )
           begin
                sumaTotala = sumaTotala - 7;
                Suc1 = 0; Suc2 =0; Aliment1 = 0; Aliment2 = 1;
           end
           //----------------------------------------------------------------------
           if(vreauRest)
           begin
               case(sumaTotala)
                        9:
                        begin
                            REST1 = 0; REST2 = 0; REST3 = 0; REST4 = 1; REST5 = 1;
                        end
                        
                        8:
                        begin
                            REST1 = 0; REST2 = 0; REST3 = 1; REST4 = 0; REST5 = 1;
                        end
                     
                        7:
                        begin
                            REST1 = 0; REST2 = 1; REST3 = 0; REST4 = 0; REST5 = 1;
                        end
                     
                        6:
                        begin
                            REST1 = 1; REST2 = 0; REST3 = 0; REST4 = 0; REST5 = 1;
                        end
                     
                        5:
                        begin
                            REST1 = 0; REST2 = 0; REST3 = 0; REST4 = 0; REST5 = 1;
                        end
                     
                        4:
                        begin
                            REST1 = 0; REST2 = 0; REST3 = 0; REST4 = 1; REST5 = 0;
                        end
                        
                        3:
                        begin
                            REST1 = 0; REST2 = 0; REST3 = 1; REST4 = 0; REST5 = 0;
                        end
                        
                        2:
                        begin
                            REST1 = 0; REST2 = 1; REST3 = 0; REST4 = 0; REST5 = 0;
                        end
                        
                        1:
                        begin
                            REST1 = 1; REST2 = 0; REST3 = 0; REST4 = 0; REST5 = 0;
                        end
                     endcase
                end         
        end
endmodule
