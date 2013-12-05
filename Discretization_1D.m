%discrete detection to removal
function [Ex,Ey,Ez]=Discretization_1D(Rx,Ry,Rz,xstep)
[m,n]=size(Rx);
x=1:xstep:m;
Ex=Rx(x);
Ey=Ry(x);
Ez=Rz(x);


end


