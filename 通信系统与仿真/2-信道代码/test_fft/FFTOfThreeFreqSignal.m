
clc
clear
%% ���ȴ���һ��������Ϊfs=100Hz������ΪK=1000��ʱ��t=fs*K������ʱ����nΪn=linspace(dt,t,K);
%%�����źŵ�ʱ����Ͳ���Ƶ��
dt=0.01;
fs=1/dt; 
K=1000;
t=dt*K;
n=linspace(dt,t,K);%% ����ź�
x1=5*sin(2*pi*5*n);
x2=10*sin(2*pi*10*n);
x3=5*sin(2*pi*15*n);
x=x1+x2+x3;
subplot(3,1,1)
plot(x);
xlabel('ʱ����');
ylabel('y��');
legend('ʱ���ź�')

%% fft�任
N=K;
a=fft(x,N);
a=abs(a)/N;
subplot(3,1,2);
plot(a);
legend('fft�任���ԭʼƵ��');

%% ��fft�任��Ƶ��������һ������
f=(1:N/2)*fs/N; 
subplot(3,1,3);
plot(f,2*a(1:N/2));
xlabel('f/Hz');
ylabel('����P');
legend('fft�任���Ƶ�ʽ�����ȷ�����Ƶ��ͼ');
%% ���޸�һ��N��ֵ����������Ƶ��ͼ�ᷢ��ʲô�仯��ԭʼ�źŵ�Ƶ�ʵ�Ϊ5Hz��10Hz��15Hz��
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
    ylabel('����P');
end