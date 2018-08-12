
%% example of the simulation with code
%% �Աȱ�������ĺô�

clear
clc
tic
%%% ---------- simulation parameter ---------------------------
modLevel=4;% ���ƽ���
num_bit=100;      %% bit��

SNR_Arr= [0:2:10];
numSNR=length(SNR_Arr);
numFrame_Arr= ones(1,numSNR)*1500;
TsigPower=1;% �źŹ���Ϊ1

%----------�������--------
Q=[1 1 1; 1 1 0; 1 0 1;0 1 1];
G=[eye(4), Q]; % ���ɾ���
H=[Q.',eye(3)]; %�ල����
% HPattern=[bi2de(H(:,1:4).','left-msb')]; % ���ں�У���ӽ��жԱȵġ�����������ں������λ����������ǲ���ͳ�Ƶġ�

for ns=1:numSNR
    %% -------------------------------------
    SNR=SNR_Arr(ns);
    numFrame=numFrame_Arr(ns);   
    
    SNR_linear=10^(SNR/10);% dBֵ��Ϊ����ֵ
    NoisePower = TsigPower/SNR_linear;%������������
    NoiseAmp=sqrt(NoisePower/2);%
      
    %%-------initialization----------
    num_total_error=0;
    num_total_error_ham=0;
    for nf=1:numFrame
        %% ----------------���Ͷ�--------------------
        %---------�������bit����---δ����ֱ�ӵ���------------------------
        seriBit =randi([0 1],1,num_bit);
        DataModed=modulation(seriBit,modLevel);   % ԭʼ��Ϣbit���е���
        %-------- ��Ϣbit�����������е���----------------------------- 
        Bitmat=reshape(seriBit,4,num_bit/4).';
        matcode=mod(Bitmat*G,2);  % ���б���
        BitCoded=reshape(matcode.',1,[]);
        pad=4-rem(size(BitCoded,2),4); %����16QAM��bit���г�����Ҫ��4�ı���
        BitCodedwiPad=[BitCoded zeros(1,pad)];%����
        DataModedwiHam=modulation(BitCodedwiPad,modLevel);  % ������bit���е���      
        
       %% ******************** �ŵ� *********************************************  
        %---------------rayleigh channel-----------------------------------
        % ��ҵ3�����ڴ˴��� rayleigh˥�� �Ա���rayleigh˥���� �����δ��������ܲ��
        
        % -----add gaussian noise-----------------
        Rdata=add_noise(DataModed,NoiseAmp);
        RdatawiHam=add_noise(DataModedwiHam,NoiseAmp);
        
       %% ******************** ���ն� *********************************************     
        % ------------ demodulation---------------------
        BitDemoded=demodulation(Rdata,modLevel);
        BitDemodedwiHam=demodulation(RdatawiHam,modLevel);
        %-----------------decode-------------------------------
        BitDemodedwiHam=BitDemodedwiHam(1:size(BitDemodedwiHam,2)-pad);
        
        matHam=reshape(BitDemodedwiHam,7,size(BitDemodedwiHam,2)/7).';
        s=mod(matHam*H.',2);   % ��У�����ȥ���õ�У���� ���SNR��ķǳ��������ȫ0
        errorham=zeros(25,4);
        for i=1:size(s,1)
            s_index=bi2de(s(i,:),'left-msb');
            switch s_index
                case 7
                    errorham(i,1)=1;
                case 6
                    errorham(i,2)=1;
                case 5
                    errorham(i,3)=1;
                case 3
                    errorham(i,4)=1;
            end
        end
        matHamDecoded=mod(errorham+matHam(:,1:4),2);
        BitDecoded=reshape(matHamDecoded.',1,[]);
        % ��ҵ1����д���ӵ�63-80�� ��δ�����ʲô���ã�switch������ô���
        % ��ҵ2�����63-80�� �ĳ�һ���Ӻ��������������н��е���
        % ------- calculate  rawBER  û�б���� --------------------
        num_error_bit=sum(abs(seriBit-BitDemoded));
        num_total_error=num_total_error+num_error_bit;
        % ------- calculate  BER  �б���� --------------------
        num_error_bit_ham=sum(abs(seriBit-BitDecoded));
        num_total_error_ham=num_total_error_ham+num_error_bit_ham;
    end   %% end for nf
    BER(ns) = num_total_error/(num_bit*nf);
    BERham(ns) = num_total_error_ham/(num_bit*nf);
    
end  %% end for ns
semilogy(SNR_Arr,BER,'r-',SNR_Arr,BERham,'b-');
legend('BER without Hamming code','BER with Hamming code');
grid on;