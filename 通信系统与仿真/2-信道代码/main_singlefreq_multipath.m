%%��Ƶ�źž����ྶʱ���ŵ�
%  ʱ�Ӵ�С��ʱ��仯��
%  �����ʱ�� ����Ϊ�趨�ģ� ʵ����ʱ�� �����Ϊ�ƶ��Ե���
clc
clear all;
f=10;%����ĵ�Ƶ�ź�Ƶ��
dt=0.01;t=0:dt:10;
L=2;  %����
taof=2*rand(1,L);  %������ƫ��   
fai0=rand(1,L)*2*pi; %ÿ���ĳ�ʼ��λ
st=cos(2*pi*f*t);   % ԭʼ��Ƶ�ź�

for i=1:L
    fai(i,:)=2*pi*taof(i)*t;
    s(i,:)=cos(2*pi*f*t+fai(i,:)+fai0(i));
end
rt=sum(s)/sqrt(L);  % ���źž����ྶ�Ľ�����

%---------�ź�Ƶ��---------
[ff sf]=T2F(t,st);

[ff rf]=T2F(t,rt);

%-----------��ͼ----------
figure(1)
subplot(211)
plot(t,st); xlabel('t');ylabel('s(t)');title('���뵥Ƶ�ź�');
axis([0 2 -1.5 1.5]);
subplot(212)
plot(t,rt);xlabel('t');ylabel('s(t)');title('����L��������ź�');

figure(2)
subplot(211)
plot(ff,sf);xlabel('f');ylabel('s(f)');
title('ԭ�����źŵ�Ƶ��');
axis([0 20 0 1]);
subplot(212)
plot(ff,rf);xlabel('f');ylabel('r(f)');
axis([0 20 0 1]);
title('�ྶ�ŵ�����źŵ�Ƶ��');



