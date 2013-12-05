%discrete detection to removal
function [Ex,Ey,Ez]=Discretization(Rx,Ry,Rz,xstep,ystep)
[m,n]=size(Rx);
x=1:xstep:m;
y=1:ystep:n;

Ex=Rx(x,y);
Ey=Ry(x,y);
Ez=Rz(x,y);


end


