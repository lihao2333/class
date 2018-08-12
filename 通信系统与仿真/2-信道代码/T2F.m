function [f,sf2]=T2F(t,st)
% 对信号进行傅里叶变换，输出信号频谱
dt=t(2)-t(1);
T=t(end);
df=1/T;
N=length(st);

f=0:df:N/2*df;
sf=fft(st);
sf=abs(sf)/N;
sf2 = sf(1:N/2+1);
sf2(2:end-1) = 2*sf2(2:end-1);