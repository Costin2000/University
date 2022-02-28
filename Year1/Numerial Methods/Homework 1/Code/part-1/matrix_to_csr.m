function [values, colind, rowptr] = matrix_to_csr(A)
 n=size(A)(1,1); %nr de linii
  nz=nnz(A);%nr de elemente nenule
 
  %construim vectorul values,colind;
  values=zeros(1,nz);
  colind=zeros(1,nz);
 
  nrEl=1;
  nrElRowptr=1;
  for i=1:size(A)(1,1)
    test=1;
    for j=1:size(A)(1,2)
      if A(i,j)!=0
        if test==1
          rowptr(1,nrElRowptr)=nrEl;
          test=0;
          nrElRowptr++;
        endif
        values(1,nrEl)=A(i,j);
        colind(1,nrEl)=j;
        nrEl++;      
      endif
    endfor
  endfor
 
  rowptr(1,nrElRowptr)=nz+1;
endfunction
