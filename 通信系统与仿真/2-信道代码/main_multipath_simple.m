%********  这是一个错误的函数， 请分析错误在哪 **********
clc
clear

%%% ---------- simulation parameter ---------------------------
modLevel=4;% 调制阶数
num_bit=100;      %% bit数

SNR_Arr=10000% [0:2:10];
numSNR=length(SNR_Arr);
numFrame_Arr= ones(1,numSNR)*1500;
TsigPower=1;% 信号功率为1

%- channel parameters------------------
Path_Delay = [0 8 18 27];
Path_Power = [1  0.6  0.4  0.1];

for ns=1:numSNR
    %% -------------------------------------
    SNR=SNR_Arr(ns);
    numFrame=numFrame_Arr(ns);   
    
    SNR_linear=10^(SNR/10);% dB值换为线性值
    NoisePower = TsigPower/SNR_linear;%计算噪声功率
    NoiseAmp=sqrt(NoisePower/2);%
      
    %%-------initialization----------
    num_total_error=0;
    
    for nf=1:numFrame
        %% ----------------发送端--------------------
        %---------随机产生数据---------------------------
        seriBit =randi([0 1],1,num_bit);
        
        %%-------- QPSK 调制 -----------------------------
        DataModed=modulation(seriBit,modLevel);       
        
        %% ******************** 信道 *********************************************
        %------  多径衰落---------------
        [ FadingSignal,Chan_Coef ] = multipath_channel_simple(Path_Delay,Path_Power,DataModed);
        
        % -----add gaussian noise-----------------
        Rdata=add_noise(FadingSignal,NoiseAmp);
        
        %% ******************** 接收端 *********************************************     
        % ------------QPSK demodulation---------------------
        BitDemoded=demodulation(Rdata,modLevel);
        
        % ------- calculate BER --------------------
        num_error_bit=sum(abs(seriBit-BitDemoded));
        num_total_error=num_total_error+num_error_bit;
        
        
    end   %% end for nf
    BER(ns) = num_total_error/(num_bit*nf);
    
end  %% end for ns

semilogy(SNR_Arr,BER,'r-');
