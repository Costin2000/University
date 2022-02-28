function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
  
  fisierPtr = fopen(nume,'r');%deschid fisierul
  
  N=fscanf(fisierPtr,'%f',1);%citesc numarul de siteuri
  for i = 1 : N
    fscanf(fisierPtr,'%f',1);
    x=fscanf(fisierPtr,'%f',1);
    for j = 1 : x
      fscanf(fisierPtr,'%f',1);
      %aceste date se pot pierde deoarece nu imi sunt de folos
    endfor
  endfor
  
  % retin val1 si val2 din fisier
  val1=fscanf(fisierPtr,'%f',1);
  val2=fscanf(fisierPtr,'%f',1);
  
  fclose(fisierPtr);%inchid fisierul
  
  fisIesire=strcat(nume,".out");
  
  %deschid fisierul de iesire
  
  fisIesirePtr = fopen(fisIesire,'w');
  
  fprintf(fisIesirePtr, '%i \n', N);
  fprintf(fisIesirePtr,'\n');
  
  %afisiez rezultatul functiei Iterative
  fprintf(fisIesirePtr, '%.6f \n', Iterative(nume, d, eps));
  fprintf(fisIesirePtr,'\n');
 
  %afisiez rezultatul functiei Algebraic
  fprintf(fisIesirePtr, '%.6f \n', Algebraic(nume, d)); 
  fprintf(fisIesirePtr,'\n');
  
  R1=Iterative(nume, d, eps);
  R2=Algebraic(nume, d);
  PR=Algebraic(nume, d);
  vecIndici = 1:N;
  
  %sortez vectorul si ordonez si vectorul cu indici
  for i=1:(N-1)
    for j=(i+1):N
      %in if iau si cazul in care diferenat e mai mica de 10^(-6)
      if PR(i,1) < PR(j,1) || abs(PR(j,1)-PR(i,1))<0.000001
        aux1=PR(j,1);
        PR(j,1)=PR(i,1);
        PR(i,1)=aux1;
        
        aux2=vecIndici(1,i);
        vecIndici(1,i)=vecIndici(1,j);
        vecIndici(1,j)=aux2;
      endif
    endfor
  endfor
  
  for i=1:N
    y = Apartenenta(PR(i,1), val1, val2);
    fprintf(fisIesirePtr, '%i %i %.6f\n', i, vecIndici(i), y);
  endfor
  
  fclose(fisIesirePtr);%inchid fisierul
  
  
endfunction