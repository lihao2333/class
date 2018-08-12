
clc
clear
%% 首先创建一个采样率为fs=100Hz，长度为K=1000，时长t=fs*K，所以时间轴n为n=linspace(dt,t,K);
%%定义信号的时间轴和采样频率
dt=0.01;
fs=1/dt; 
K=1000;
t=dt*K;
n=linspace(dt,t,K);%% 组合信号
x1=5*sin(2*pi*5*n);
x2=10*sin(2*pi*10*n);
x3=5*sin(2*pi*15*n);
x=x1+x2+x3;
subplot(3,1,1)
plot(x);
xlabel('时间轴');
ylabel('y轴');
legend('时域信号')

%% fft变换
N=K;
a=fft(x,N);
a=abs(a)/N;
subplot(3,1,2);
plot(a);
legend('fft变换后的原始频谱');

%% 对fft变换的频率轴做归一化处理
f=(1:N/2)*fs/N; 
subplot(3,1,3);
plot(f,2*a(1:N/2));
xlabel('f/Hz');
ylabel('功率P');
legend('fft变换后对频率进行正确化后的频谱图');
%% 在修改一下N的值我们来看看频谱图会发生什么变化！原始信号的频率点为5Hz，10Hz，15Hz。
figure(2);
N_list=[50,200,1000,1500];

for i=1:4
    N=N_list(i);
    a=fft(x,N);
    a=abs(a)/N;
    f=(1:N/2)*fs/N;
    subplot(2,2,i);
    plot(f,2*a(1:N/2));
    title(['N=' num2str(N)]);  
    xlabel('f/Hz');
    ylabel('功率P');
end