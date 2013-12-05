%generate the grid for move
function [X,Y,Z]=GridGen(xdis,ydis)
[X,Y]=meshgrid(xdis(1):xdis(2):xdis(3),ydis(1):ydis(2):ydis(3));
Z=0.1.*sqrt(X.^2+Y.^2);
end