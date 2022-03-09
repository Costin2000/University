module sim1();
    reg clk, reset, Ron1, Ron5, Ron10, Rest; 
    wire Rest1, Rest5, Ceai, Procesare;
    wire [2:0] stare;
    
    initial begin

    clk = 0;
    reset = 0;
    Ron1 = 0;
    Ron5 = 0;
    Ron10 = 0;
    Rest = 0;
    
    end
    
    automat_V1_wrapper instance1(Ceai, Procesare, Rest1, Rest5, Rest, Ron10, Ron1, Ron5, clk, reset, stare);
    always #10clk = ~clk;
    
    initial begin 
    #0 reset = 1;
    #1 reset = 0;
    
   
    #49 Ron1 = 1;
    #20 Ron1 = 0;
  
    #20 Ron1 = 1;
    #20 Ron1 = 0;
    
    #20 Ron1 = 1;
    #20 Ron1 = 0;
    
    #60 Ron5 = 1;
    #20 Ron5 = 0;
    
    #60 Ron1 = 1;
    #20 Ron1 = 0;
    
    #20 Ron10 = 1;
    #20 Ron10 = 0;
    
    #60 Ron1 = 1;
    #20 Ron1 = 0;
    
    #20 Ron1 = 1;
    #20 Ron1 = 0;
    
    #20 Rest = 1;
    #20 Rest = 0;
    
    #60 Ron10 = 1;
    #20 Ron10 = 0;
    
    #60 Ron10 = 1;
    #20 Ron10 = 0;
    
    #20 Ron1 = 1;
    #20 Ron1 = 0;
    
    
    #60 Ron1 = 1;
    #20 Ron1 = 0;
    
    #20 Ron1 = 1;
    #20 Ron1 = 0;
    
    #20 reset = 1;
    #1 reset = 0;
    
    #19 Ron1 = 1;
    #20 Ron1 = 0;
    
    #20 Ron10 = 1;
    #20 Ron10 = 0;
    
    
    #5000 $finish;
    #5000 $stop;
    end
endmodule
