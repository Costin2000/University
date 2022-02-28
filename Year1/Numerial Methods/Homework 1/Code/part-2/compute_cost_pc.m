function [cost] = compute_cost_pc(points, centroids)
  cost=0;
  for i=1:size(points)(1,1)
    distMin=norm(points(i,:)-centroids(1,:));
    linie=1;
    for j=2:size(centroids)(1,1)
      if distMin>norm(points(i,:)-centroids(j,:))
        distMin=norm(points(i,:)-centroids(j,:));
      endif
    endfor
    cost=cost+distMin;
  endfor 
endfunction

