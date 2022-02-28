function [centroids] = clustering_pc(points, NC)
matrCluster=zeros(NC,size(points)(1,1));
 
  for i=1:NC
    j=i;
    nrEl=1;
    while(j<=size(points)(1,1))
        matrCluster(i,nrEl)=j;
        nrEl++;
        j=j+NC;
    endwhile
  endfor
 
  %primul centroid   (matrice)
 
  %matrCluster
 
  for i=1:NC
      nonzeroVec = nonzeros(matrCluster(i,:));
        for j=1:size(points)(1,2)
          suma=0;
          for z=1:(size(nonzeroVec)(1,1))
            suma=suma+points(nonzeroVec(z,1),j);
          endfor
          if((size(nonzeroVec)(1,1))!=0)
            centroids0(i,j)=suma/(size(nonzeroVec)(1,1));
          endif
        endfor
  endfor  
  %centroids0  

   %----------------------------------------------------------------------------
   newCluster=zeros(NC,size(points)(1,1));%initializez noua matrice
     
     for i=1:size(points)(1,1)
       distMin=norm(centroids0(1,:)-points(i,:));
       poz=1;
       for j=2:NC
         if(distMin>norm(centroids0(j,:)-points(i,:)))
          distMin=norm(centroids0(j,:)-points(i,:));
          poz=j;
         endif
       endfor
      newCluster(poz,length(nonzeros(newCluster(poz,:)))+1)=i;
     endfor
    % newCluster
     
     
     for i=1:NC
        nonzeroVec = nonzeros(newCluster(i,:));
          for j=1:size(points)(1,2)
            suma=0;
            for z=1:(size(nonzeroVec)(1,1))
              suma=suma+points(nonzeroVec(z,1),j);
            endfor
            if((size(nonzeroVec)(1,1))!=0)
              centroids(i,j)=suma/(size(nonzeroVec)(1,1));
            endif
          endfor
      endfor
      %centroids
   %----------------------------------------------------------------------------
   while norm(centroids-centroids0)>0.00001
     centroids0=centroids;
     newCluster=zeros(NC,size(points)(1,1));%initializez noua matrice
     clear centroids;
     for i=1:size(points)(1,1)
       distMin=norm(centroids0(1,:)-points(i,:));
       poz=1;
       for j=2:NC
         if(distMin>norm(centroids0(j,:)-points(i,:)))
          distMin=norm(centroids0(j,:)-points(i,:));
          poz=j;
         endif
       endfor
      newCluster(poz,length(nonzeros(newCluster(poz,:)))+1)=i;
     endfor
     %newCluster
     
     
     for i=1:NC
        nonzeroVec = nonzeros(newCluster(i,:));
          for j=1:size(points)(1,2)
            suma=0;
            for z=1:(size(nonzeroVec)(1,1))
              suma=suma+points(nonzeroVec(z,1),j);
            endfor
            if((size(nonzeroVec)(1,1))!=0)
              centroids(i,j)=suma/(size(nonzeroVec)(1,1));
            endif
          endfor
      endfor
    endwhile
  %centroids    
endfunction
