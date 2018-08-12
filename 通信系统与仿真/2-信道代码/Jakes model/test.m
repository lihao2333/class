%--------
clear
clc


LengthOfBurst=512*21;
UpdatesPerBurst=512*21;

NumOfTaps=3;
switch NumOfTaps
    case 1,MAX_Delay_Sample=1;case 3,MAX_Delay_Sample=64; case 6,MAX_Delay_Sample=80; case 12,MAX_Delay_Sample=88; case 24,MAX_Delay_Sample=92; 
end
dt=12.5e-9;
fd_max=30;

model=1; %%指数模型
itn_sample=[1:NumOfTaps].*500;
numFrame=1;

%InData=rand(1,LengthOfBurst); 
tem_re=ones(1,LengthOfBurst);
tem_im=0.*rand(1,LengthOfBurst);
InData=tem_re+i.*tem_im;

[RndPhase,Path_Delay,Path_Average_Amp,fore_data,RMS_Delay_Sample] = channel_initialize(MAX_Delay_Sample,NumOfTaps,model);

fading_indx=1;

[OutData,Fading]=multipath_channel(InData,fd_max,NumOfTaps,LengthOfBurst,UpdatesPerBurst,itn_sample,dt,RndPhase,Path_Delay,Path_Average_Amp);


plot(abs(Fading(1,:)));
axis([1,LengthOfBurst,0,1])

