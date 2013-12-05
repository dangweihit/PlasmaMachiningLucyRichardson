%main_sin
%main
clear
clc    
close all

%% target-detection=removal
length=5;
width=1;
[Dx,Dy]=meshgrid(0:0.25:width,0:0.25:length);
[dm,dn]=size(Dx);
Dz=0.2*sin(2*Dy)+0.2;
% surf(Dx,Dy,Dz)
clear dm dn
%% 
[Tx,Ty,Tz]=Target(Dx,Dy);
Ex=Tx;Ey=Ty;Ez=-Tz+Dz;

[Rx,Ry,Rz]=Discretization(Ex,Ey,Ez,1,1);
[E,T]=FLR(Ex,Ey,Rx,Ry,Rz);

% figure(1);
% subplot(2,2,1)
% mesh(Rx,Ry,Rz);
% subplot(2,2,3)
% mesh(Rx,Ry,reshape(E,26,26));
% subplot(2,2,4)
% mesh(Rx,Ry,Rz-reshape(E,26,26));
% subplot(2,2,2)
% mesh(Rx,Ry,reshape(T,26,26));
Rebuild;
% Tselect=T(1:21,9:17);
Tsum=sum(sum(T));
T_second=T*60