function [A, b] = generate_probabilities_system(rows)
rand=0;
nrDeInters=0;

while rand!=rows
  rand++;
  nrDeInters=nrDeInters+rand;
endwhile

%constructie matrice aux(labirintul)

matrAux=zeros(rows+2,(rows+2)*2-1);
matrAux(2,(((rows+2)*2-1)+1)/2)=1;
numarator=2;

for i= 3:(size(matrAux)(1,1)-1)
  for j= 2:(size(matrAux)(1,2)-1)
    if matrAux(i-1,j-1)!=0 || matrAux(i-1,j+1)!=0
      matrAux(i,j)=numarator;
      numarator++;
    endif
  endfor
endfor

%constructie A folosint labirintul creeat

A=zeros(nrDeInters,nrDeInters);

for i= 2:(size(matrAux)(1,1)-1)
  for j= 2:(size(matrAux)(1,2)-1)
    if matrAux(i,j)!=0
      nrVecini=0;
      
      if matrAux(i-1,j-1)!=0
        A(matrAux(i,j),matrAux(i-1,j-1))=-1;
        nrVecini++;
      endif
      
      if matrAux(i-1,j+1)!=0
        A(matrAux(i,j),matrAux(i-1,j+1))=-1;
        nrVecini++;
      endif
      
      if matrAux(i,j-2)!=0
        A(matrAux(i,j),matrAux(i,j-2))=-1;
        nrVecini++;
      endif
      
      if matrAux(i,j+2)!=0
        A(matrAux(i,j),matrAux(i,j+2))=-1;
        nrVecini++;
      endif
      
      if matrAux(i+1,j-1)!=0
        A(matrAux(i,j),matrAux(i+1,j-1))=-1;
        nrVecini++;
      endif
      
      if matrAux(i+1,j+1)!=0
        A(matrAux(i,j),matrAux(i+1,j+1))=-1;
        nrVecini++;
      endif
      
      if nrVecini==4
        nrVecini=5;
      endif
      
      if nrVecini==2
        nrVecini=4;
      endif
      
      A(matrAux(i,j),matrAux(i,j))=nrVecini;
    endif
  endfor
endfor

% constructie b

b=zeros(nrDeInters,1);

for j=rows:(-1):1
  b(nrDeInters+1-j,1)=1;
endfor
endfunction
