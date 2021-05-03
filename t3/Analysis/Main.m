format long


%Define the constants
f=50; %Hz (Pls dont change this one)
A=230; %V
n=10; %Windings in the transformer
Periods= 5; %Number of periods 

%Define the diode model parameters
nD = 18 %(number of diods)
Von = 12/nD; %V
Rd = 7.058990e+01 %Ohm

Ending = '\\ \hline';

%Unoptimized analysis

C1 = 2.5; %uF
R1 = 2.5; %Kohm
R2 = 2; %Kohm

[vRipple,avrError,Vmean] = plots(n, f, A, Periods, Von, R1, C1, R2, Rd, nD, 1);

%create the circuits for the ngspice
MU = WriteSim (R1, R2, C1, n, A, nD);


FileP = fopen('InputParameters.tex','w');
nu = '\nu'
omega = '\Omega'

fprintf(FileP, 'Tranformer Windings & %f %s\n', n, Ending)
fprintf(FileP, 'Number of Diodes & %f %s\n', nD, Ending)
fprintf(FileP, 'C1($%s F$) & %f %s\n',nu, C1, Ending)
fprintf(FileP, 'R1($K%s$)& %f %s\n', omega, R1, Ending)
fprintf(FileP, 'R2($K%s$)& %f %s\n', omega, R2, Ending)
fclose(FileP);


File1 = fopen('OutputResults.tex','w');

fprintf(File1, '$V_{Ripple}$(V) & %f %s\n', vRipple, Ending)
fprintf(File1, '$V_{average}$(V) & %f %s\n', Vmean, Ending)
fprintf(File1, '$V_{deviation}$(V) & %f %s\n', avrError, Ending)
fprintf(File1, 'Cost(MU) & %f %s\n', MU, Ending)
fclose(File1);


%Optimized analysis

C1 = 295; %uF
R1 = 84; %Kohm
R2 = 6.07; %Kohm

[vRipple,avrError,Vmean] = plots(n, f, A, Periods, Von, R1, C1, R2, Rd, nD, 2);

%create the circuits for the ngspice
MU_op = WriteSim (R1, R2, C1, n, A, nD);


FileV = fopen('OutputResults_Op.tex','w');

fprintf(FileV, '$V_{Ripple}$(V) & %f %s\n', vRipple, Ending)
fprintf(FileV, '$V_{average}$(V) & %f %s\n', Vmean, Ending)
fprintf(FileV, '$V_{deviation}$(V) & %f %s\n', avrError, Ending)
fprintf(FileV, 'Cost(MU) & %f %s\n', MU_op, Ending)
fclose(FileV);
