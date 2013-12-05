%function to calculate the depth at (xr,yr) when the torch is at(xd,yd)
function z=Removal(xr,yr,xd,yd)
% d=norm(xd-xr,yd-yr);
if  ((xd-xr)^2+(yd-yr)^2)<16
%    z=1.2-(1.2/6)*sqrt((xr-xd)^2+(yr-yd)^2);
   z=-0.2276*exp(-(4/2.517)^2)+0.2276*exp(-(sqrt((xd-xr)^2+(yd-yr)^2) /2.517)^2);
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

