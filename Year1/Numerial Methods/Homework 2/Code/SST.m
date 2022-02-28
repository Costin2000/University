function [x] = SST (U,b)
  %am folosit algoritmul prezentat la laboratorul 3
  [n n] = size(U);
  x=zeros(n,1);
  
  for i = n: -1 : 1
    if(i==n)
      s=0;
    endif
    s = U(i,i+1:n) * x(i+1:n);
    x(i) = (b(i) - s)/U(i,i);
  endfor
endfunction
