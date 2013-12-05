% ------------------------------------------------------------------
% Lucy-Richardson algoritm to calculate T including 
% functions below:
% Psi-time distribution for iterations
% Q-inverse probability of P
% P-local distribution at a dwell point(a Gaussian distribution)
% Phi-removal distribution
% ------------------------------------------------------------------
% clear;clc;close all;
%% grid INI
function [Ek,T]=FLR(Ex,Ey,Rx,Ry,Rz)
xr=Rx;yr=Ry;
xd=Ex;yd=Ey;
[mr,nr]=size(xr);
Nr=mr*nr;
[md,nd]=size(xd);
Nd=md*nd;
clear mr nr ;
%---------------------------Iteration--------------------------------
%% INI for iteration
T=(1/1000)*ones(Nd,1);%inatial T to optimize
Ed=reshape(Rz,Nr,1);
hwait=waitbar(0/1000,'迭代中...');
generation=50;
%% Iteration
 for I=1:generation
    Ek=zeros(Nr,1);
    %R cross Tk
    for i=1:Nr
        for j=1:Nd
            Ek(i)=Ek(i)+T(j)*Removal(xr(i),yr(i),xd(j),yd(j));
        end
    end
    % factor =Ed/Ek  factor[Nr,1]
    FactorR=Ed./Ek;
    % Sum作为P归一化的分母
    SumRemoval=zeros(Nd,1);
    for i=1:Nd
        for j=1:Nr
            SumRemoval(i)=SumRemoval(i)+Removal(xr(j),yr(j),xd(i),yd(i));
        end
    end
    FactorL=zeros(Nd,Nr);
    for i=1:Nd
        for j=1:Nr
            FactorL(i,j)=Removal(xr(j),yr(j),xd(i),yd(i))/SumRemoval(i);
        end
    end
   
    Factor=FactorL*FactorR;
     e=max(abs((Factor-ones(Nd,1))));
%     eploty=zeros(generation,1);
%     eploty(I)=e;
    waitbar(I/generation,hwait,['迭代中 I=' [num2str(I)] '...残差' num2str(e) ]);
    %judge convergence
%     for i=1:Nd
%         if abs(factor(i)-1)<e
%             Tfinal(i)=T(i);
%         end
%     end
    for i=1:Nd
        T(i)=T(i)*Factor(i);
    end
%     if sum(find(Tfinal==0))==0;
%         break;
%     end

 end
waitbar(I/generation,hwait,['迭代结束.残差' num2str(e) ]);

T=reshape(T,md,nd)
clear md nd










    