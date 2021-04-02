function [Vph, Vm] = nodeSolverPhasor(Data, w)
  
format long

%data  = [R1,R2,R3,R4,R5,R6,R7,Va,C,Kb,Kc]

for i= 1:7
  Data(i) = 1/Data(i);
endfor

G1 = Data(1);
G2 = Data(2);
G3 = Data(3);
G4 = Data(4);
G5 = Data(5);
G6 = Data(6);
G7 = Data(7);
Va = 1;
C  = Data(9);
Kb = Data(10);
Kd = Data(11);
I = 1;
O = 0;

Zc = 1/(i*w*C);
Yc = 1/Zc;

A = [G1 (-G1-G2-G3) G2  O      G3       O      O     O;...
     O   Kb+G2     -G2  O     -Kb       O      O     O;...
     O   Kb         O   O     -Kb-G5    G5+Yc  O     -Yc;...
     O   O          O  -G6     O        O      G6+G7 -G7;...
     O   G3         O   G4    -G3-G4-G5 G5+Yc  G7    -G7-Yc;...
     I   O          O   -I     O        O      O      O;...
     O   O          O   Kd*G6 -I        O      -Kd*G6 I;...
     O   O          O   I      O        O      O      O];

B = [O; O; O; O; O; Va; O; O];

V = A\B;

for i = 1:length(V)
  Vm(i) = abs(V(i));
  Vph(i) = arg(V(i));
endfor
 
 
%define the names for the variables
Vi = ['V1'; 'V2'; 'V3'; 'V4'; 'V5'; 'V6'; 'V7'; 'V8'];
Ending = '\\ \hline';

%voltage
FileV = fopen('Voltages_4.tex','w');
for i = 1:8
  Volt = '%s%s & %f %s \n';
  fprintf(FileV, Volt, Vi(i,1), Vi(i,2), Vm(i), Ending)
endfor
%output on volts
fclose(FileV);
  
  
  
endfunction
