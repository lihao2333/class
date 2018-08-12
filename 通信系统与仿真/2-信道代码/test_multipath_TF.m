%---多径信道的时频域特性----------------

clc
clear

%- channel parameters------------------
Path_Delay = [0 8 18 27];
Path_Power = [1  0  0  0]; %[1  0.6  0.4  0.1];

%----------------------
Data_Tx=ones(1,1000);
 [ FadingSignal,Chan_Coef ] = multipath_channel_simple(Path_Delay,Path_Power,Data_Tx);
 
 Htime=abs(Chan_Coef.');
 
 Hfreq= abs( fft(Chan_Coef,1024)).';
 
 subplot(1,2,1)
 stem(Htime,'r');
 subplot(1,2,2)
 plot(Hfreq,'b');
 
 
%------802.11n----------------
 dt=1/(20*10^6);
 Path_Delay=round([0,10,20,30,40,20,30,40,50,60,70,80]*1e-9/dt); 	  
 Path_Power_dB=[0.0,-5.4,-10.8,16.2,-21.7,-3.2,-6.3,-9.4,-12.5,15.6,-18.7,-21.8];
 Path_Power=10.^(Path_Power_dB/10);
 Data_Tx=ones(1,1000);
 [ FadingSignal,Chan_Coef ] = multipath_channel_simple(Path_Delay,Path_Power,Data_Tx); 
 Htime=abs(Chan_Coef.'); 
 Hfreq= abs( fft(Chan_Coef,1024)).';
 plot(Hfreq,'b'); hold on;
 %-------WCDMA----------------
 dt=1/(5*10^6);
 Path_Delay=[0,round(976e-9/dt)];
 Path_Power_dB=[0,-10];
  Path_Power=10.^(Path_Power_dB/10);
 Data_Tx=ones(1,1000);
 [ FadingSignal,Chan_Coef ] = multipath_channel_simple(Path_Delay,Path_Power,Data_Tx); 
 Htime=abs(Chan_Coef.'); 
 Hfreq= abs( fft(Chan_Coef,1024)).';
 plot(Hfreq,'r'); hold on;
  %-------LTE----------------
dt=1/(20*10^6);   
Path_Delay=round([0,30,70,90,110,190,410]*1e-9/dt);
Path_Power_dB=[-0.0,-1.0,-2.0,-3.0,-8.0,-17.2,-20.8]; 
 Path_Power=10.^(Path_Power_dB/10);
 Data_Tx=ones(1,1000);
 [ FadingSignal,Chan_Coef ] = multipath_channel_simple(Path_Delay,Path_Power,Data_Tx); 
 Htime=abs(Chan_Coef.'); 
 Hfreq= abs( fft(Chan_Coef,1024)).';
 plot(Hfreq,'k'); 
