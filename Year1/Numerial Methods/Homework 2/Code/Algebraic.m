function R = Algebraic(nume, d)
  
  fisierPtr = fopen(nume,'r');%deschid fisierul
  
  N=fscanf(fisierPtr,'%f',1);%citesc numarul de siteuri
  
  matrAdiacenta=zeros(N,N);
  
  for i=1:N
    %al catelea site
    nrSite=fscanf(fisierPtr,'%f',1);
    %memorez in vector cate lincuri are fiecare site
    nrLink(nrSite)=fscanf(fisierPtr,'%f',1); 
    for j=1:nrLink(nrSite)
      %peste linkul carui site am dat
      linkSite=fscanf(fisierPtr,'%f',1);
      if linkSite!=nrSite %nu se pune 1 pe diagonala principala
        matrAdiacenta(nrSite,linkSite)=1;
      else
        nrLink(nrSite)--;
      endif
    endfor
  endfor
  fclose(fisierPtr);%inchid fisierul
  
  %k este inversa matricei are are pe diagonala numarul de linkuri al fircarui site
   k=zeros(N,N);
   for i=1:N
     k(i,i)=1/nrLink(1,i);
   endfor
   
   M = (k * matrAdiacenta)';
   I=eye(N);%matricea identitate
   
   %folosesc formula data
   R=PR_Inv((I - d * M)) * (1-d)/N * ones(N,1);
   
endfunction