function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1
  
  a = 1 / (val2-val1);
  b=val1/(val1-val2);
  
  if x>=0 && x<val1
    y=0;
  else
    if x>=val1 && x<=val2
      y=a*x+b;
    else
      y=1
    endif
  endif
   
endfunction	