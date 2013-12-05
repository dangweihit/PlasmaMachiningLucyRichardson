%main-1D
%main
clear
clc    
close all

%% target-detection=removal
width=5;
Dx=0:0.25:width;

Dy=zeros(1,length(Dx));
[dm,dn]=size(Dx);
Dz=ones(dm,dn);
clear dm dn

[Tx,Ty,Tz]=Target(Dx,Dy);
Ex=Tx;Ey=Ty;Ez=-Tz+Dz;

[Rx,Ry,Rz]=Discretization_1D(Ex,Ey,Ez,1);
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