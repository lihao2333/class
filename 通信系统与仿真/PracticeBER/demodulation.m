function  demod_out = demodulation(demod_in,mod_mode)
%%*************************************************************************
%%Function information:
%%由信道信号的复数值解调对应的二进制序列(In this program,the channel value are demodulated.)
%%-------------------------------------------------------------------------
%%First time   : 3/25/2002                                           
%%Newest modified time:6/20/2002                                         
%%Programmer:Xuewei Mao
%% Modified by Alin 2003-5-7 for improve its speed
%% Modified by Alin 2003-5-7 for improve its speed
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
%% Here,the method for the four modulation modes is the same ,so see the note
%%for QPSK, and the note for the other three is omitted. 
%%-------------------------------------------------------------------------

%% Function discription:
%%-------------------------------------------------------------------------
%% 由信道信号的复数值找出对应的二进制序列。方法如下：由信道值，
%%求出该值与星座图中所有点的距离，找出距离最小的点，该点对应的
%%二进制序列及为该信道对应的解调结果。
%% In this program,the channel value are demodulated.
%% The process: firstly,calculate  the distance between the channel value
%% and all the constellation points.then,find the shortest distance,thus ,the point
%% is the one.At last,put out the binary sequence symbolizing the point.   
%%-------------------------------------------------------------------------

%% Input: 
%%-------------------------------------------------------------------------
%% demod_in :输入信道值  (the input channel value)
%%-------------------------------------------------------------------------
%% Output:
%%-------------------------------------------------------------------------
%% demod_out:解调结果 (demodulation output(binary) )
%%-------------------------------------------------------------------------
%% Global Variable:
%%-------------------------------------------------------------------------
%%  g_RT
%%-------------------------------------------------------------------------
%%*************************************************************************
%system_parameters  
demod_out = [];
DEMOD_OUT = [];
switch (mod_mode)
case 2
    %BPSK modulation
    s2=[-1;1]/sqrt(2);
    c2 = [0 1];
    L = length(demod_in);
    [tmp, index] = min(abs(s2(:,ones(1,L))-demod_in(ones(2,1),:)));% 最小值对应的星座点序号的二进制表示即为解调结果
    demod_out = c2(index);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 4
    %QPSK modulation
    s4=[-1-j; -1+j; 1-j; 1+j]/sqrt(2);
    c4 = [0 0; 0 1; 1 0; 1 1];
    L = length(demod_in);
    [tmp, index] = min(abs(s4(:,ones(1,L))-demod_in(ones(4,1),:)));% 最小值对应的星座点序号的二进制表示即为解调结果
    demod_out = c4(index,:);
    demod_out = reshape(transpose(demod_out),1,2*L);
    %soft
%     demod_in = reshape(demod_in,1,[]);
%     demod_out(1,:)=real(demod_in);
%     demod_out(2,:)=imag(demod_in);
%     demod_out = reshape(demod_out,1,2*L);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 8
    % 8PSK
    s8=[1; (1+j)/sqrt(2); (-1+j)/sqrt(2); +j; (1-j)/sqrt(2); -j; -1; (-1-j)/sqrt(2)];
    c8 = de2bi([0:7],'left-msb');
    L = length(demod_in);
    [tmp, index] = min(abs(s8(:,ones(1,L))-demod_in(ones(8,1),:)));% 最小值对应的星座点序号的二进制表示即为解调结果
    demod_out = c8(index,:);
    demod_out = reshape(transpose(demod_out),1,3*L);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 16
    % 16QAM
    s16=[-3-3*j;   -3-j;   -3+3*j;   -3+j; ...   
        -1-3*j;   -1-j;   -1+3*j;   -1+j; ...
        3-3*j;    3-j;    3+3*j;    3+j; ...
        1-3*j;    1-j;    1+3*j;    1+j]/sqrt(10);
    c16 = de2bi([0:15],'left-msb');
    L = length(demod_in);
    [tmp, index] = min(abs(s16(:,ones(1,L))-demod_in(ones(16,1),:)));% 最小值对应的星座点序号的二进制表示即为解调结果
    demod_out = c16(index,:);
    demod_out = reshape(transpose(demod_out),1,4*L);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 64
    %64_QAM
    s64=[-7-7*j;  -7-5*j; -7-j; -7-3*j; -7+7*j; -7+5*j; -7+j; -7+3*j;...  
      -5-7*j;  -5-5*j; -5-j; -5-3*j; -5+7*j; -5+5*j; -5+j; -5+3*j;... 
      -1-7*j;  -1-5*j; -1-j; -1-3*j; -1+7*j; -1+5*j; -1+j; -1+3*j;...
      -3-7*j;  -3-5*j; -3-j; -3-3*j; -3+7*j; -3+5*j; -3+j; -3+3*j;...
       7-7*j;   7-5*j;  7-j;  7-3*j;  7+7*j;  7+5*j;  7+j;  7+3*j;...
       5-7*j;   5-5*j;  5-j;  5-3*j;  5+7*j;  5+5*j;  5+j;  5+3*j;...
       1-7*j;   1-5*j;  1-j;  1-3*j;  1+7*j;  1+5*j;  1+j;  1+3*j;...
       3-7*j;  3-5*j;  3-j;  3-3*j;  3+7*j;  3+5*j;  3+j;  3+3*j ]/sqrt(42);
    c64 = de2bi([0:63],'left-msb');
    L = length(demod_in);
    [tmp, index] = min(abs(s64(:,ones(1,L))-demod_in(ones(64,1),:)));% 最小值对应的星座点序号的二进制表示即为解调结果
    demod_out = c64(index,:);
    demod_out = reshape(transpose(demod_out),1,6*L);
otherwise
    disp('Error! Please input again');        
end
      
