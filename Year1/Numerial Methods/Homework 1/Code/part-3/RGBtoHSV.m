function [hsvVec] = RGBtoHSV (R, G, B)


  R0=double(R)/double(255);
  G0=double(G)/double(255);
  B0=double(B)/double(255);

  Cmax=max([R0,G0,B0]);
  Cmin=min([R0,G0,B0]);
  delta=Cmax-Cmin;
  
  if delta==0 
    H=0;
  else
    
    if Cmax==R0
      H=60*mod((G0-B0)/delta,6);
    endif
  
    if Cmax==G0
      H=60*((B0-R0)/delta+2);
    endif
    
    if Cmax==B0
      H=60*((R0-G0)/delta+4);
    endif
 endif
 H=H/360;
   
   if Cmax==0
     S=0;
   else
     S=delta/Cmax;
   endif
   
   V=Cmax;
   
   %H=H*360;
   %S=S*100;
   %V=V*100;
   
   hsvVec=[H,S,V];
   
endfunction
