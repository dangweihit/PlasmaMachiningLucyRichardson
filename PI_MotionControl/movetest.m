%movetest
clc
[m,n]=size(X);
N=m*n;

for i=1:N
    disp([X(i),Y(i)]);
    pause(1.5);
end