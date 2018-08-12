% Example rate 1/2 convolutional code.
clc
clear
%  作业1：练习读下面的 poly2trellis([5 4],[23 35 0; 0 5 13])，解释 各个数字的含义
% trellis =poly2trellis([5 4],[23 35 0; 0 5 13]);
% The structure field numInputSymbols equals 4 because two bit streams can produce four different input symbols
% while numOutputSymbols equals 8 because three bit streams produce eight different output symbols.
% As there are seven total shift registers, there are  2^7=128 possible states.

% 作业2： 把下面的CC编码和译码模块 替换上一次作业中的Hamming编译码，test CC的效果
%------------编译码参数----------------------
trellis = poly2trellis(3,[7 5]); 
tblen = 15; % 回溯深度，If the code rate is 1/2, a typical value for tblen is about five times the constraint length of the code. 

%----------Msg是信息bit------------------
Msg = [1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1 0 0]; 
MsgwithPad=[Msg, zeros(1,tblen)];

%-----------CC编码---------------------
CodedMsg = convenc(MsgwithPad,trellis); 

%-----------CC译码--------------------------
decoded=vitdec(CodedMsg,trellis,tblen,'cont','hard') ;
DecodedMsg=decoded(tblen+1:end);

%------------译码后和信息bit进行比对----------------------------------
[number,ratio] = biterr(DecodedMsg,Msg);