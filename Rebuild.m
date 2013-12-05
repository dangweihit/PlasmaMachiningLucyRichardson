% Rebuild the surface with finer grid
[Sx,Sy]=meshgrid(0:0.05:width,0:0.05:length);
% [Sx,Sy]=meshgrid(0.4:0.05:0.6,1:0.05:4);
[m,n]=size(Sx);
Ns=m*n;
Sz=zeros(Ns,1);
[mj,nj]=size(Ex);
Nj=mj*nj;
rebuildwait=waitbar(0/Ns);
for	i=1:Ns
        for j=1:Nj
            Sz(i)=Sz(i)+T(j)*Removal(Sx(i),Sy(i),Ex(j),Ey(j));
        end
    waitbar(i/Ns,rebuildwait,'SURFACE REBUIDING');
end
average=sum(sum(Sz))/Ns;
PV=max(Sz)-min(Sz)
RMS=sqrt(sum(sum((Sz-average).^2/Ns)))
Sz=reshape(Sz,m,n);

% mesh(Sx,Sy,Sz-(0.2*sin(Sy)+0.2));
figure(2);
mesh(Sx,Sy,Sz);
%  colormap(gray);
% Tselect=T(1:21,9:17);
