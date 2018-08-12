% 该代码实现CRC编码，编码的冗余bit个数=CRC多项式长度-1
%  作业2：把本代码 改成讲义中的 CRC多项式[11001] 和 待编码数据 10110011，验证校验bit是否正确
%------------------------------
clc
clear
gen = [1 0 1 1]; % 校验多项式 
data = [0 0 1 1 1 1 1 1 0 0 1 1 1]; % 原始信号
glen = length(gen); 
%----如果多项式第一位是0，那么要从第二位开始算起-----------------------
while gen(1) == 0    
    gen = gen(2:glen);    
    glen = length(gen); 
end
%-------数据补0- 当作被除数--------------------------------
data_back = data; 
for m = 1:glen-1   
    data = [data 0]; 
end
dlen = length(data); 
%--------开始做除法------------------------
% 作业1：解释21-29行 每一步的功能

cr = data(1:glen-1);
for p = glen:dlen 
    cr(glen) = data(p); 
    if cr(1)         
        cr = xor(cr(2:glen), gen(2:glen));   %异或运算，相当于除法    
    else
        cr = cr(2:glen);
    end
end
%--------得到校验bit，放在数据bit之后----------------------
cr = [data_back cr];