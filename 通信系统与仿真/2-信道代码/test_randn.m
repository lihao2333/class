
% 两种画概率分布函数的方法
clc
clear
length=100000;
variable=randn(1,length);
%-------Method 1--------------

[f,xi] = ksdensity(variable); 
plot(xi,f,'r-'); 
%-------Method 2--------------
x=linspace(min(variable),max(variable),100);
dx=x(2)-x(1);
n=hist(variable,x)./length./dx;
hold on;
plot(x,n,'b-')

x=linspace(min(variable),max(variable),50);
dx=x(2)-x(1);
n=hist(variable,x)./length./dx;
hold on;
plot(x,n,'k-')