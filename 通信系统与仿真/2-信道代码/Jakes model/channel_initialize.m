function [RndPhase,Path_Delay,Path_Average_Amp,fore_data,RMS_Delay_Sample] = channel_initialize(MAX_Delay_Sample,NumOfTaps,model)
%% Function discription:
%%-------------------------------------------------------------------------
%% Rayleigh fading generator using Jakes model
%% Independent Rayleigh fading processes are provided using offsets.
%% Note:
%%-------------------------------------------------------------------------
%% 信道模型： 
%% model 1 : 指数模型
%% model 2 : 均匀模型

%% Input:
%%-------------------------------------------------------------------------
%% fd_max:  maximum doppler frequency (in [Hz])
%% Max_Delay_Sample: Channel maximum delay   (sample)
%% NumOfTaps: Number of taps of the channel
%% LengthOfBurst : the length of one burst data to transmite
%% UpdatesPerBurst : the number of update times of one burst data block
%% model: 1: exponential model, others: uniform model, 默认为: exponential model
%%-------------------------------------------------------------------------

%%-------------------------------------------------------------------------
%% Output:
%%-------------------------------------------------------------------------
%% An,Bn,Wn,RndPhase,Path_Delay,Path_Average_Amp,group:  parameters used to generate fading
%% RMS_Delay_Sample: Channel maximum delay   (sample)
%%-------------------------------------------------------------------------

M_TONES=9; 
for tap=1:NumOfTaps
    RndPhase(tap,:)=pi*(1-2*rand(1,M_TONES));
end

%%-----------------------------------------------------------------------
%% Initialization of multipath profiles
%%-----------------------------------------------------------------------
Path_Delay=zeros(1,NumOfTaps);
if model==1                                                %%% exponential model
    Path_Delay(1)=0;
    Path_Average_Power(1)=1;
    if NumOfTaps>1
        Dexp_sample=floor(MAX_Delay_Sample/(NumOfTaps-1));
        bili=10^(1.2/NumOfTaps);      %  power rate of adjecent paths is 12/LdB
        for k=2:1:NumOfTaps
            Path_Delay(k)=Dexp_sample*(k-1);
            Path_Average_Power(k) = Path_Average_Power(k-1)/bili; 
        end;
    end
else                                                      %%% uniform model
    M_group=3;   
    Luni=NumOfTaps/M_group;
    Duni=(MAX_Delay_Sample-Luni+1)/(M_group-1);     %%% MAX_Delay_Sample应该满足关系:    MAX_Delay_Sample=2*Duni+Luni-1
    one_group=0:Luni-1;
    kk=0;
    for m=1:M_group
        for k=1:Luni
            kk=kk+1;
            Path_Delay(kk)=one_group(k)+(m-1)*Duni;
        end
    end
    Path_Average_Power=ones(1,NumOfTaps);
end

%%---------------------------------------------------------------
%%              calculate the RMS delay 
%%---------------------------------------------------------------
tao_avg=sum(Path_Average_Power.* Path_Delay)./sum(Path_Average_Power);
tao2_avg=sum(Path_Average_Power.* (Path_Delay.^2))./sum(Path_Average_Power);
RMS_Delay_Sample=sqrt(tao2_avg-tao_avg^2);

%% Scale tap powers to total power 1.0 and convert to amplitudes 
TotalPower = sum(Path_Average_Power);                             % unify the power
Scaled_Path_Average_Power = Path_Average_Power./TotalPower;
Path_Average_Amp = sqrt(Scaled_Path_Average_Power);              % the amplitude of each tap

fore_data=rand(1,MAX_Delay_Sample)+i.*rand(1,MAX_Delay_Sample);  %%必须用复数向量进行初始化，该变量空间用于保存信道前一帧对后一帧的时延影响
