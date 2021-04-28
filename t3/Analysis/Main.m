format long

%Define the constants
f=50; %Hz (Pls dont change this one)
A=230; %V
n=10; %Windings in the transformer
Periods= 5; %Number of periods 
C1 = 88; %uF
R1 = 52; %Kohm
R2 = 6.02; %Kohm
%tau = C1*R1*10e3;

%Define the diode model parameters
nD = 18 %(number of diods)
Von = 0.7; %V
Rd = 80 %Ohm


plots(n, f, A, Periods, Von, R1, C1, R2, Rd, nD)

%create the circuits for the ngspice
MU = WriteSim (R1, R2, C1, n, A, nD);



%{
%Calculate the R_eq and the time constant
[Req, tau, V_2] = Solver_t2_2(Data,V);

%tran analysis (both nat and forced)
Data(9)= Data(9)*1e-6 %convert to farad

start = 0;    %t=0s
stop = 20e-3; %t=20ms
freq = 1000; %Hz

trans (Data, V, V_2, Req, tau, start, stop, freq);

%freq analysis
fstart = -1
fstop = 6
freqResponcev2 (Data, fstart, fstop, Req)
%gg
%}
