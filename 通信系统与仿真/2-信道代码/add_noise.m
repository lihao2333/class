function outdata=add_noise(indata,attn)
%% function discription:add gauss noise
%% input parameters
%%      indata:�������
%%      attn��������׼��
%% output parameters
%%      outdata��������֮��ķ���

[r,c]=size(indata);
item=randn(r,c).*attn;
qtem=randn(r,c).*attn;
noise=item+i.*qtem;

outdata=indata+noise;