%test removal
clear
clc
x=-5:0.1:5;
y=0.0182-0.2276*exp(-(x/2.517).^2);
plot(x,y);