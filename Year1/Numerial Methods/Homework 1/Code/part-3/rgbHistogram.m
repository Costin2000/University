function [sol] = rgbHistogram(path_to_image, count_bins)
  imag=imread(path_to_image);
  %imag(:,:,1)
  matriceRosu=imag(:,:,1);
  matriceGalb=imag(:,:,2);
  matriceAlba=imag(:,:,3);
  
  vectorRosu=reshape(matriceRosu,1,[]);
  vectorGalb=reshape(matriceGalb,1,[]);
  vectorAlba=reshape(matriceAlba,1,[]);
  
  vectorCB=linspace(0,256,count_bins+1);

  bincountsRosu = histc(vectorRosu,vectorCB);
  bincountsRosu(end)=[];
  
  bincountsGalb = histc(vectorGalb,vectorCB);
  bincountsGalb(end)=[];
  
  bincountsAlba = histc(vectorAlba,vectorCB);
  bincountsAlba(end)=[];
  
  sol=[bincountsRosu,bincountsGalb,bincountsAlba];
  
endfunction