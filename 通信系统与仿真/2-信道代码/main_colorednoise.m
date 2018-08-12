clc
clear
clear
clc
tic
%%% ---------- simulation parameter ---------------------------
modLevel=4;% ���ƽ���
num_bit=100;      %% bit��

SNR_Arr= [0:2:10];
numSNR=length(SNR_Arr);
numFrame_Arr= ones(1,numSNR)*1000;
TsigPower=1;% �źŹ���Ϊ1

%bgnoise_type=2;  % 0: 4����  1��8����   2��16����  �˲���

for ns=1:numSNR
    %% -------------------------------------
    SNR=SNR_Arr(ns);
    numFrame=numFrame_Arr(ns);   
    
    SNR_linear=10^(SNR/10);% dBֵ��Ϊ����ֵ
    NoisePower = TsigPower/SNR_linear;%������������
    NoiseAmp=sqrt(NoisePower/2);%
      
    %%-------initialization----------
    num_total_error0=0;
    num_total_error1=0;
    num_total_error2=0;
    num_total_error3=0;
    for nf=1:numFrame
        %% ----------------���Ͷ�--------------------
        %---------�����������---------------------------
        seriBit =randi([0 1],1,num_bit);
        
        %%-------- QPSK ���� -----------------------------
        DataModed=modulation(seriBit,modLevel);       
        
        %% ******************** �ŵ� *********************************************      
        % -----add colored noise-----------------
         Rdata0=colorednoise(DataModed,NoiseAmp,0);
          Rdata1=colorednoise(DataModed,NoiseAmp,1);
           Rdata2=colorednoise(DataModed,NoiseAmp,2);
             Rdata3=add_noise(DataModed,NoiseAmp);
        %% ******************** ���ն� *********************************************     
        % ------------QPSK demodulation---------------------
        BitDemoded0=demodulation(Rdata0,modLevel);
         BitDemoded1=demodulation(Rdata1,modLevel);
          BitDemoded2=demodulation(Rdata2,modLevel);
           BitDemoded3=demodulation(Rdata3,modLevel);
        % ------- calculate BER --------------------
        %num_error_bit=sum(abs(seriBit-BitDemoded));
        num_total_error0=num_total_error0+sum(abs(seriBit-BitDemoded0));
         num_total_error1=num_total_error1+sum(abs(seriBit-BitDemoded1));
         num_total_error2=num_total_error2+sum(abs(seriBit-BitDemoded2));
          num_total_error3=num_total_error3+sum(abs(seriBit-BitDemoded3));
    end   %% end for nf
    BER0(ns) = num_total_error0/(num_bit*nf);
     BER1(ns) = num_total_error1/(num_bit*nf);
      BER2(ns) = num_total_error2/(num_bit*nf);
      BER3(ns) = num_total_error3/(num_bit*nf);
end  %% end for ns

semilogy(SNR_Arr,BER0,'r-');
hold on;
semilogy(SNR_Arr,BER1,'g-');
hold on;
semilogy(SNR_Arr,BER2,'b-');
hold on;
semilogy(SNR_Arr,BER3,'k-');
      
   
