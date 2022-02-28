function B = PR_Inv(A)
  [Q R] = GramSchmidt(A);
  marime=size(A)(1,1);
  
  B=zeros(marime,marime);
  I=eye(marime);
  
  for i = 1 : marime
    aux = SST(R, Q' * I(:,i));
    B(:,i)=aux;
  endfor
endfunction
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Se va inlocui aceasta linie cu descrierea algoritmului de inversare 