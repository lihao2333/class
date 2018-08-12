function fading = JakesIV(Path_Ampli,An,Bn,Wn,Phase,NumOfFreq,LengthOfBurst,UpdatesPerBurst,UpdateInterval,t_tmp,dt)
%%-------------------------------------------------------------------------
%% Function discription:
%%-------------------------------------------------------------------------
%% Rayleigh fading generator using Jakes model
%% Independent Rayleigh fading processes are provided using offsets.


%% Input: 
%%-------------------------------------------------------------------------
%% Path_Ampli: the amplitude gain per path 
%% An,Bn,Wn:  parameters used to generate fading
%% NumOfFreq: number of different frequecies used to generate fading
%% Offset:  different offset means different fading
%% UpdateInterval: period that fading weights is kept unchanged
%% UpdatesPerBurst: how many times fading weights are updated during one processing period
%% LengthOfBurst: the length of one processing period depend on not only
%%                frame length but only oversamping rate
%% t_tmp: the time index inside this function
%% dt:  the basic time interval
%%-------------------------------------------------------------------------
%% Output:
%%  fading is the Rayleigh fading weights
%%-------------------------------------------------------------------------
%% 



%%-------------------------------------------------------------------------
%% Fading
%% ival  the I component of Rayleigh fading
%% qval  the Q component of Rayleigh fading
%%-------------------------------------------------------------------------


%%-----------------------------------------------------------------------
%% Parameters for fading generating
%%-----------------------------------------------------------------------

M_OSCIL=NumOfFreq; %  8
M_TONES=M_OSCIL+1;
N_MAGIC=M_OSCIL*4+2;  %34  为了对总能量的归一


for k=1:UpdatesPerBurst
      %Reset sum 
      ival = 0;
      qval = 0;
     for n = 1:M_TONES     
        cosine = cos(Wn(n)*t_tmp*dt+Phase(n));
        ival = ival+An(n) * cosine;
        qval = qval+Bn(n) * cosine;
     end
     %scale=2*/sqrt(N_MAGIC); In order to unify the output power,then changed to
     scale=1.41421356237310/sqrt(N_MAGIC);
     for jj=k:k+UpdateInterval-1
        ival_scale(jj)= ival * scale;
        qval_scale(jj)= qval * scale;
    end
    k=k+UpdateInterval;
    t_tmp=t_tmp+UpdateInterval;
    
end 

fading_output=ival_scale+j*qval_scale;
Weighted_fading_output=Path_Ampli*fading_output;
fading=Weighted_fading_output(1:LengthOfBurst);
 
 
    
       