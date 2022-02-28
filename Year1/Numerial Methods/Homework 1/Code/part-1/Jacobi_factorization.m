function [G_J, c_J] = Jacobi_factorization(A, b)
  D = diag(diag(A));
  L = -tril (A) + D;
  U = -triu (A) + D;
  N = D ;
  P = L + U ;
  G_J = inv(D) * P ;
  c_J = inv(N) * b ;
endfunction
