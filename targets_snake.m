%targets_snake
X=Dx;
Y=Dy;
Y(:,2)=flipud(Y(:,2));
Y(:,4)=flipud(Y(:,4));
[m,n]=size(X);
Z=ones(m,n);
U=zeros(m,n);
V=zeros(m,n);
W=zeros(m,n);
v=0.5*ones(m,n);
T=ones(m,n);
[m,n]=size(X);
N=m*n;
clear m n;
I=reshape(X,N,1);
J=reshape(Y,N,1);
K=reshape(Z,N,1);
plot3(I,J,K);
grid on;


