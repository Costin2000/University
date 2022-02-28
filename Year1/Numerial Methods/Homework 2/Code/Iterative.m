function R = Iterative(nume, d, eps)
  
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
        matrAdiacenta(nrSite,linkSite) = 1;
      else
        %daca se contine pe el scad din numarul de linkuri
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
   
  
  %fac prima iteratie in afara wile-ului
  M=(k*matrAdiacenta)';
  
  R0=zeros(N,1);
  
  for i=1:N
    R0(i,1)=1/N;
  endfor
  
  R=d*M*R0+((1-d)/N)*ones(N,1);
  
  while norm(R-R0)>=eps
    R0=R;
    R=d*M*R0 + ((1-d)/N)*ones(N,1);
  endwhile
  
  R=R0;
endfunction