% Example of Hamming code
clc
clear
Q=[1 1 1; 1 1 0; 1 0 1;0 1 1];
G=[eye(4), Q]; % 生成矩阵
x=[0 1 0 1];   %待编码序列
A=mod(x*G,2)  % 编码
H=[Q.',eye(3)]; %监督矩阵

mod(A*H.',2)  % 如果不是0，就说明有错，这是检错
mod(H*A.',2)


%  if the second bit is wrong
E=[0 0 0 0 0 0 1]; % 错误图样
B=A+E;

s=mod(B*H.',2)   %校正子
mod(E*H.',2)-s

%----------最小码距的统计-----------------------

X = de2bi([0:15],'left-msb'); % k=4 位所有信息序列的可能
A=mod(X*G,2)  % 编码  后所有码字
D = pdist(A,'minkowski',1);
D_min=min(D)

