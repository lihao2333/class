function [ FadingSignal,Chan_Coef ] = multipath_channel_simple(Path_Delay,Path_Power,Data_Tx)

% Generate FadingWeight  没有时间相关性

% Scale tap powers to total power 1.0 and convert to amplitudes
TotalPower = sum(Path_Power);                             % unify the power
Scaled_Path_Average_Power = Path_Power./TotalPower;
Path_Average_Amp = sqrt(Scaled_Path_Average_Power);              % the amplitude of each tap


NumOfTaps = length(Path_Delay);
FadingWeight = zeros(1,NumOfTaps);

for loop_Tap = 1:NumOfTaps
    FadingWeight(loop_Tap) = (randn(1,1)+ i*randn(1,1))* Path_Average_Amp(loop_Tap);
end

% Generate FadingSignal

Chan_Coef = zeros(Path_Delay(end)+1,1);
for loop_tap = 1:NumOfTaps
    Chan_Coef(Path_Delay(loop_tap)+1) =FadingWeight(loop_tap);
end
FadingSignal = conv(Chan_Coef,Data_Tx);
     




