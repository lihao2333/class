function mod_out=modulation(mod_in,mod_mode)
%%*************************************************************************
%%Function information:
%%-------------------------------------------------------------------------
%%First time   : 3/25/2002                                           
%%Newest modified time:6/20/2002                                         
%%Programmer:Xuewei Mao
%% Modified by Alin 2003-05-07 for improve its speed
%% Modified by Alin 2003-05-29 for improve its speed
%%Version: 0.2
%%-------------------------------------------------------------------------
%%*************************************************************************

%%*************************************************************************
%% Reference:
%%-------------------------------------------------------------------------
%% 
%%-------------------------------------------------------------------------

%% Note:
%%-------------------------------------------------------------------------
%% 
%%-------------------------------------------------------------------------

%% Function discription:
%%-------------------------------------------------------------------------
%%根据输入的调制方式，对输入序列MOD_IN进行调制，分别采用BPSK, QPSK, !6QAM, 64QAM，
%%完成对星座图的映射，输出为Y.转化的方法为：先写出十进制情况下从0 到N-1
%%（N为星座图的点数）所对应的星座坐标；再将输入的二进制序列转化为相应的
%%十进制，以查表的方法查出对应点的复数坐标，即为调制映射后的结果。

%%The OFDM subcarriers shall be modulated by using BPSK, QPSK, 16-QAM, or 64-QAM modulation,
%%depending on the RATE requested. The encoded and interleaved binary serial input data shall
%%be divided into groups of N BPSC (1, 2, 4, or 6) bits and converted into complex numbers 
%%representing BPSK, QPSK, 16-QAM, or 64-QAM constellation points. The conversion shall be
%%performed according to Gray-coded constellation mappings, with the input bit MOD_IN. The
%%output values,MOD_OUT are formed by multiplying the resulting (I+jQ) value by a normalization 
%%factor K MOD , as described in equation d = (I + jQ) × K MOD ) The normalization factor,K MOD,
%%depends on the base modulation mode. Note that the modulation type can be different from the
%%start to the end of the transmission, as the signal changes from SIGNAL to DATA. The purpose
%%of the normalization factor is to achieve the same  average power for all mappings.In practical
%%implementations, an approximate value of the normalization factor can be used, as long as 
%%the device conforms with the modulation accuracy requirements .

%%-------------------------------------------------------------------------

%% Input: 
%%-------------------------------------------------------------------------
%%  mod_in:输入的二进制序列(The sequence to be modulated)
%%-------------------------------------------------------------------------
%% Output:
%%-------------------------------------------------------------------------
%% mod_out:星座图映射后得到的调制复数结果(The output after modulation)
%%-------------------------------------------------------------------------
%% Global Variable:
%%  g_RT (the vector which contains the modulation mode)
%%-------------------------------------------------------------------------
%% Z :选择调制方式的参数 (the parameter to choose the modulation mode)
%%
%% R :输入二进制序列重新排列（按一定要求）后的结果,例如：对16QAM，要把输入序列调整为
%% 4行，length(g_MOD_IN_16QAM )/4  列的矩阵。(Reshape the input binary sequence to be
%% matrix of n-row,m-column .For example,16QAM,will be reshaped into 4-row,
%%length(g_MOD_IN_16QAM))/4 column )
%%
%% B2D :二进制向十进制转化后的结果 (convert the binary sequence to  dec )
%%
%% Temp:星座图阵列 (the  constellation)
%%-------------------------------------------------------------------------
%%********************************************************
%system_parameters  
switch (mod_mode)
case 2 
    Temp=[-1 1];
    mod_out = Temp(mod_in+1);%映射,注意加1，因为matlab没有a(0)项，而是从a(1)开始 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 4
    Temp=[-1-j  -1+j  1-j   1+j];
    mod_in = reshape(mod_in,2,length(mod_in)/2);%将输入序列转化为(2,length(x)/2)的矩阵
    mod_out = Temp([2 1]*mod_in+1)/sqrt(2);%映射,注意加1，因为matlab没有a(0)项，而是从a(1)开始

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 8
    Temp=[1  (1+j)/sqrt(2)  (-1+j)/sqrt(2)   +j (1-j)/sqrt(2) -j -1 (-1-j)/sqrt(2)];
    mod_in = reshape(mod_in,3,length(mod_in)/3);%将输入序列转化为(3,length(x)/3)的矩阵
    mod_out = Temp([4 2 1]*mod_in+1);%映射,注意加1，因为matlab没有a(0)项，而是从a(1)开始
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 16
   Temp=[-3-3*j   -3-j   -3+3*j   -3+j ...   
          -1-3*j   -1-j   -1+3*j   -1+j ...
           3-3*j    3-j    3+3*j    3+j ...
           1-3*j    1-j    1+3*j    1+j]/sqrt(10);
   mod_in = reshape(mod_in,4,length(mod_in)/4);%将输入序列转化为(4,length(x)/4)的矩阵
   mod_out = Temp([8 4 2 1]*mod_in+1);%映射,注意加1，因为matlab没有a(0)项，而是从a(1)开始

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 64
   Temp=[-7-7*j  -7-5*j  -7-j  -7-3*j  -7+7*j  -7+5*j  -7+j  -7+3*j...  
         -5-7*j  -5-5*j  -5-j  -5-3*j  -5+7*j  -5+5*j  -5+j  -5+3*j... 
         -1-7*j  -1-5*j  -1-j  -1-3*j  -1+7*j  -1+5*j  -1+j  -1+3*j...
         -3-7*j  -3-5*j  -3-j  -3-3*j  -3+7*j  -3+5*j  -3+j  -3+3*j...
          7-7*j   7-5*j   7-j   7-3*j   7+7*j   7+5*j   7+j   7+3*j...
          5-7*j   5-5*j   5-j   5-3*j   5+7*j   5+5*j   5+j   5+3*j...
          1-7*j   1-5*j   1-j   1-3*j   1+7*j   1+5*j   1+j   1+3*j...
          3-7*j   3-5*j   3-j   3-3*j   3+7*j   3+5*j   3+j   3+3*j ]/sqrt(42);
   mod_in = reshape(mod_in,6,length(mod_in)/6);%将输入序列转化为(6,length(x)/6)的矩阵
   mod_out = Temp([32 16 8 4 2 1]*mod_in+1);%映射,注意加1，因为matlab没有a(0)项，而是从a(1)开始

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
otherwise
    disp('Error! Please input again');
end
   