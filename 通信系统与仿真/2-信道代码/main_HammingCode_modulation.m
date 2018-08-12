
%% example of the simulation with code
%% 对比编码带来的好处

clear
clc
tic
%%% ---------- simulation parameter ---------------------------
modLevel=4;% 调制阶数
num_bit=100;      %% bit数

SNR_Arr= [0:2:10];
numSNR=length(SNR_Arr);
numFrame_Arr= ones(1,numSNR)*1500;
TsigPower=1;% 信号功率为1

%----------编码参数--------
Q=[1 1 1; 1 1 0; 1 0 1;0 1 1];
G=[eye(4), Q]; % 生成矩阵
H=[Q.',eye(3)]; %监督矩阵
% HPattern=[bi2de(H(:,1:4).','left-msb')]; % 用于和校验子进行对比的。如果错误是在后面的三位，这个错误是不用统计的。

for ns=1:numSNR
    %% -------------------------------------
    SNR=SNR_Arr(ns);
    numFrame=numFrame_Arr(ns);   
    
    SNR_linear=10^(SNR/10);% dB值换为线性值
    NoisePower = TsigPower/SNR_linear;%计算噪声功率
    NoiseAmp=sqrt(NoisePower/2);%
      
    %%-------initialization----------
    num_total_error=0;
    num_total_error_ham=0;
    for nf=1:numFrame
        %% ----------------发送端--------------------
        %---------随机产生bit数据---未编码直接调制------------------------
        seriBit =randi([0 1],1,num_bit);
        DataModed=modulation(seriBit,modLevel);   % 原始信息bit进行调制
        %-------- 信息bit汉明编码后进行调制----------------------------- 
        Bitmat=reshape(seriBit,4,num_bit/4).';
        matcode=mod(Bitmat*G,2);  % 进行编码
        BitCoded=reshape(matcode.',1,[]);
        pad=4-rem(size(BitCoded,2),4); %进行16QAM的bit序列长度需要是4的倍数
        BitCodedwiPad=[BitCoded zeros(1,pad)];%补零
        DataModedwiHam=modulation(BitCodedwiPad,modLevel);  % 编码后的bit进行调制      
        
       %% ******************** 信道 *********************************************  
        %---------------rayleigh channel-----------------------------------
        % 作业3：请在此处加 rayleigh衰落 对比在rayleigh衰落下 编码和未编码的性能差距
        
        % -----add gaussian noise-----------------
        Rdata=add_noise(DataModed,NoiseAmp);
        RdatawiHam=add_noise(DataModedwiHam,NoiseAmp);
        
       %% ******************** 接收端 *********************************************     
        % ------------ demodulation---------------------
        BitDemoded=demodulation(Rdata,modLevel);
        BitDemodedwiHam=demodulation(RdatawiHam,modLevel);
        %-----------------decode-------------------------------
        BitDemodedwiHam=BitDemodedwiHam(1:size(BitDemodedwiHam,2)-pad);
        
        matHam=reshape(BitDemodedwiHam,7,size(BitDemodedwiHam,2)/7).';
        s=mod(matHam*H.',2);   % 用校验矩阵去检错得到校验子 如果SNR设的非常大，这就是全0
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
        % 作业1：请写出从第63-80行 这段代码是什么作用，switch部分怎么理解
        % 作业2：请把63-80行 改成一个子函数，在主函数中进行调用
        % ------- calculate  rawBER  没有编码的 --------------------
        num_error_bit=sum(abs(seriBit-BitDemoded));
        num_total_error=num_total_error+num_error_bit;
        % ------- calculate  BER  有编码的 --------------------
        num_error_bit_ham=sum(abs(seriBit-BitDecoded));
        num_total_error_ham=num_total_error_ham+num_error_bit_ham;
    end   %% end for nf
    BER(ns) = num_total_error/(num_bit*nf);
    BERham(ns) = num_total_error_ham/(num_bit*nf);
    
end  %% end for ns
semilogy(SNR_Arr,BER,'r-',SNR_Arr,BERham,'b-');
legend('BER without Hamming code','BER with Hamming code');
grid on;