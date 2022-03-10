`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2021 07:31:53 AM
// Design Name: 
// Module Name: topModule
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


module topModule(mant1, mant2, exp1, exp2, op, clear, load, clock, expRez, mantRez
    );
    
    input [23:0] mant1;
    input [23:0] mant2;
    input [7:0] exp1;
    input [7:0] exp2;
    input op;
    input clear, load, clock;
    output [7:0] expRez;
    output [23:0] mantRez;
    
    wire [56:0] rezModul7;
    wire [15:0] rezM11;
    wire [8:0] rezM12;
    wire [15:0] rout1;
    wire [47:0] rout2;
    reg16 registru1St({exp1, exp2}, rout1, clear, load, clock);
    reg47 registru1Dr({mant1, mant2}, rout2, clear, load , clock);
 
 //gt seg 1
    Modul1 m1(rout1, rezM11, rezM12);
    Modul7 m7(rout2, rezM12, rezModul7);
  //gt seg 2
    wire [15:0] rezreg2St;
    wire [56:0] rezreg2Dr;
    reg16 registru2St(rezM11,   rezreg2St, clear , load ,clock);
    reg56 registru2Dr(rezModul7, rezreg2Dr, clear, load, clock);
     
     //gt seg 3
     wire [7:0] rezM2;
     wire [47:0] rezM4;
     Modul2 m2(rezreg2St, rezM2);
     Modul4 m4(rezreg2Dr, rezM4);
     
     //gt seg 4
     wire [7:0] rezReg3St;
     wire[47:0] rezReg3Dr;
     reg7 registru3St(rezM2, rezReg3St, clear, load ,clock);
     reg47 registru3Dr(rezM4,rezReg3Dr, clear, load, clock);
     
     //gt seg 5
     wire [25:0] rezM5;
     Modul5 m5(rezReg3Dr, rezM5, op);

     //gt seg 6
     wire [7:0] rezReg4St;
     wire [25:0] rezReg4Dr;
     reg7 registru4St(rezReg3St, rezReg4St, clear, load, clock);
     reg25 registru4Dr(rezM5, rezReg4Dr, clear, load , clock);
     
     //gt seg 7 
     wire [23:0] rezM61;
     wire [8:0] rezM62;
     wire [7:0] rezM3;
     
     Modul6 m6(rezReg4Dr, rezM61, rezM62);    
     Modul3 m3( rezReg4St, rezM62, rezM3);
      
     //gt seg 8
     
     wire [7:0] rezReg5St;
     wire [23:0] rezReg5Dr;
     reg7 registru5St(rezReg4St - rezM62[7:0], rezReg5St, clear, load, clock);
     reg23 registru5Dr(rezM61, rezReg5Dr, clear, load ,clock);
     
     
     
    assign expRez = rezReg4St - rezM62;
    assign mantRez = rezM61;
    
endmodule

