% Example of Cyclic code  循环码
%  
% 循环码的生成矩阵是 (x^7+1)的一个因式,而其因式蛮共就4个。
%（7，4）循环码的生成矩阵是 g(x)=x^3+x^2+1  ,
% h(x)= (x^7+1)/g(x)=x^4+x^3+x^2+1, 其互反多项式=x^4+x^2+x+1
% 就是把bit的从左到右的顺序换成从右到左
clc
clear
g=[0 0 0 1 1 0 1];  % g(x)=x^3+x^2+1  
G=[circshift(g.',-3).';circshift(g.',-2).';circshift(g.',-1).';g];
h=[0 0 1 0 1 1 1]; % 是h的互反多项式
H=[circshift(h.',-2).';circshift(h.',-1).';h];
mod(G*H.',2)    %  全零矩阵 说明H是G的监督矩阵

x=[0 1 0 1];   %待编码序列
A=mod(x*G,2)  % 编码

mod(A*H.',2)  % 如果不是0，就说明有错，这是检错


%  if the second bit is wrong
E=[0 1 0 0 0 0 0]; % 错误图样
B=A+E;

s=mod(B*H.',2)   %校正子
mod(E*H.',2)-s

%----------最小码距的统计-----------------------

X = de2bi([0:15],'left-msb'); % k=4 位所有信息序列的可能
A=mod(X*G,2)  % 编码  后所有码字
D = pdist(A,'minkowski',1);
D_min=min(D)

