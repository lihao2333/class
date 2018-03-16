function outdata=add_noise(indata,attn)
%% function discription:add gauss noise
%% input parameters
%%      indata:输入符号
%%      attn：噪声标准差
%% output parameters
%%      outdata：加噪声之后的符号

[r,c]=size(indata);
item=randn(r,c).*attn;
qtem=randn(r,c).*attn;
noise=item+i.*qtem;

outdata=indata+noise;