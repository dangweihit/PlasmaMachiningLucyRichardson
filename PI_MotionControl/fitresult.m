%fitresult
x=X
p1=0.124;
p2=-1.936;
p3=11.25;
p4=-29.75;
p5=34.99;
p6=-14.74;

f=p1*x.^5+p2*x.^4+p3*x.^3+p4*x.^2+p5*x+p6;
plot(X,f)