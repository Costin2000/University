`timescale 1ns / 1ps



module orGate(
    a, b, iesire
    );
    
    input a, b;
    output iesire; 
    
    assign iesire = a ^ b;
    
    
endmodule
