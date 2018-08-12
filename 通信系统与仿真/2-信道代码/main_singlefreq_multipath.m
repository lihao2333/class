%%单频信号经过多径时变信道
%  时延大小随时间变化，
%  这里的时变 是人为设定的； 实际中时变 大多因为移动性导致
clc
clear all;
f=10;%输入的单频信号频率
dt=0.01;t=0:dt:10;
L=2;  %径数
taof=2*rand(1,L);  %多普勒偏移   
fai0=rand(1,L)*2*pi; %每径的初始相位
st=cos(2*pi*f*t);   % 原始单频信号

for i=1:L
    fai(i,:)=2*pi*taof(i)*t;
    s(i,:)=cos(2*pi*f*t+fai(i,:)+fai0(i));
end
rt=sum(s)/sqrt(L);  % 将信号经过多径的结果相加

%---------信号频谱---------
[ff sf]=T2F(t,st);

[ff rf]=T2F(t,rt);

%-----------画图----------
figure(1)
subplot(211)
plot(t,st); xlabel('t');ylabel('s(t)');title('输入单频信号');
axis([0 2 -1.5 1.5]);
subplot(212)
plot(t,rt);xlabel('t');ylabel('s(t)');title('经过L径后接收信号');

figure(2)
subplot(211)
plot(ff,sf);xlabel('f');ylabel('s(f)');
title('原输入信号的频谱');
axis([0 20 0 1]);
subplot(212)
plot(ff,rf);xlabel('f');ylabel('r(f)');
axis([0 20 0 1]);
title('多径信道输出信号的频谱');



