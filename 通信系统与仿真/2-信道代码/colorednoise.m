function signal_f_n=bgnoise(signal_fading,sigma,filter_type)
%% 功能：给时域信号加上有色的背景噪声
%% INPUT:
%       signal_fading衰落后的数据,行向量
%       snr:AWGN
%       filter_type:the type of FIR filter

    if filter_type==0
        a=[1 0.2137 0.9403 0.1697 0.9606];%%四极点滤波器
        b=[1];
    elseif filter_type==1
        a=[1 0.0166 0.0564 0.1988 0.1808 0.0136 0.2213 0.2634];%%8极点
        b=[1];
    elseif filter_type==2
        a=[1 0.0399 0.0348 0.1232 0.1125 0.0570 0.1427 0.1966...
           0.0123 0.0293 0.3201 0.0675 0.0676 0.0513 0.0184 0.1388];%%16极点
        b=[1];
    else
        disp('error');
    end%%数据来源：《基于电力线通信技术的仿真与系统实现研究》p21
    
    n=length(signal_fading);
    white_noise=(randn(1,n)+i*randn(1,n)) *sigma;%%高斯白噪声
    color_noise=filter(b,a,white_noise);%%通过滤波器得到有色噪声
    signal_f_n=signal_fading+color_noise;



end