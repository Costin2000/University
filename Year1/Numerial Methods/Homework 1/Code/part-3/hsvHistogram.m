function [sol] = hsvHistogram(path_to_image, count_bins)
  
  imag=imread(path_to_image);
  %size(imag)
  matrHSV=zeros(size(imag));
  
  for i=1:size(imag)(1,1)
    for j=1:size(imag)(1,2)
      a=imag(i,j,1);%pt R
      b=imag(i,j,2);%pt G
      c=imag(i,j,3);%pt B
      
      
      matrHSV(i,j,:)=RGBtoHSV(a,b,c);
    endfor
  endfor


  matriceH=matrHSV(:,:,1);
  matriceS=matrHSV(:,:,2);
  matriceV=matrHSV(:,:,3);
  
  vectorH=reshape(matriceH,1,[]);
  vectorS=reshape(matriceS,1,[]);
  vectorV=reshape(matriceV,1,[]);
  
  
  %vectorCB=linspace(0,1.02,1.01/count_bins);
  aux=(1.01/count_bins);
  
  bincountsH = histc(vectorH,0:aux:1.02);
  bincountsH(end)=[];
  
  bincountsS = histc(vectorS,0:aux:1.02);
  bincountsS(end)=[];
  
  bincountsV = histc(vectorV,0:aux:1.02);
  bincountsV(end)=[];
  
  sol=[bincountsH,bincountsS,bincountsV];
  
  
endfunction