%target face
function [Tx,Ty,Tz]=Target(Dx,Dy);
Tx=Dx;Ty=Dy;
[m,n]=size(Dx);
% wpOrigin=[Dx(m/2,n/2),Dy(m/2,n/2)];
Tz=zeros(m,n);%Æ½Ãæ
% for i=1:m   %ÇúÃæ
%     for j=1:n
%         Tz(i,j)=60+sqrt(-(Tx(i,j)-wpOrigin(1))^2-...
%             (Ty(i,j)-wpOrigin(2))^2+65^2);
%     end
% end
% end