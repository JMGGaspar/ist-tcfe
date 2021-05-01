format long

%Define the constants
f=50; %Hz (Pls dont change this one)
A=230; %V
n=10; %Windings in the transformer
Periods= 5; %Number of periods 
C1 = 295; %uF
R1 = 84; %Kohm
R2 = 6.07; %Kohm
%tau = C1*R1*10e3;

%Define the diode model parameters
nD = 18 %(number of diods)
Von = 12/nD; %V
Rd = 7.058990e+01 %Ohm


[vRipple,avrError,Vmean] = plots(n, f, A, Periods, Von, R1, C1, R2, Rd, nD);

%create the circuits for the ngspice
MU = WriteSim (R1, R2, C1, n, A, nD);


%define the names for the variables
Ending = '\\ \hline';


FileV = fopen('OutputResults.tex','w');

fprintf(FileV, '$V_{Ripple}$(V) & %f %s\n', vRipple, Ending)
fprintf(FileV, '$V_{average}$(V) & %f %s\n', Vmean, Ending)
fprintf(FileV, '$V_{deviation}$(V) & %f %s\n', avrError, Ending)
fprintf(FileV, 'Cost(MU) & %f %s\n', MU, Ending)
fclose(FileV);