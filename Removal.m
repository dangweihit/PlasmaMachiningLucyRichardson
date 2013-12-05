%removal poly
%function to calculate the depth at (xr,yr) when the torch is at(xd,yd)
function z=Removal(xr,yr,xd,yd)
% p1=0.124;
% p2=-1.936;
% p3=11.25;
% p4=-29.75;
% p5=34.99;
% p6=-14.74-0.5038;
% offset=2.3;
% d=norm(xd-xr,yd-yr);
a=0.3014;
c=0.4543;
if  ((xd-xr)^2+(yd-yr)^2)<=1.3^2
%    z=1.2-(1.2/6)*sqrt((xr-xd)^2+(yr-yd)^2);
distance=sqrt((xd-xr)^2+(yd-yr)^2);
   z=a*exp(-(distance/c).^2);
else
    z=0;
end
return

% function z=Removal(xr,yr,xd,yd)
% if ((xr-xd)^2+(yr-yd)^2)<64
%    z=1.4-(1.4/6)*sqrt((xr-xd)^2+(yr-yd)^2);  %fitted from the measurement
% 
% else
%     z=0;
% end
% return

