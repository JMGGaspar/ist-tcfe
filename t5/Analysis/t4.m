format long

%define the constants
%NPN transistor
VT=25e-3;
BFN=178.7;
VAFN=69.7;
VBEON=0.7;


%PNP transistor
BFP = 227.3;
VAFP = 37.2;
VEBON = 0.7;


%circuit constants

Vampl = 10e-3;
VCC = 12;
RS = 100;
Rload = 8;

%optmizable
RC1 = 600;
RB1 = 87e3;
RB2 = 23e3;
RE1 = 160;
RE2 = 48;

Ci=0.003e-3;
Cb=0.07e-3;
Co=39e-6;

Ending = '\\ \hline';
Ohm = "\Omega"
File1 = fopen('inputs.tex','w');

fprintf(File1, '$R_{c1}(%s)$ & %e %s\n',Ohm , RC1, Ending)
fprintf(File1, '$R_{b1}(%s)$ & %e %s\n',Ohm , RB1, Ending)
fprintf(File1, '$R_{b2}(%s)$ & %e %s\n',Ohm , RB2, Ending)
fprintf(File1, '$R_{e1}(%s)$ & %e %s\n',Ohm , RE1, Ending)
fprintf(File1, '$R_{e2}(%s)$ & %e %s\n',Ohm , RE2, Ending)

fprintf(File1, '$C_{i}(F)$ & %e %s\n' , Ci, Ending)
fprintf(File1, '$C_{b}(F)$ & %e %s\n' , Cb, Ending)
fprintf(File1, '$C_{0}(F)$ & %e %s\n' , Co, Ending)


fclose(File1);


 
Cost = WriteSim(VCC, Vampl, RS, RC1, RB1, RB2, RE1, RE2, Rload, Ci, Cb, Co)

[IC2,IC1,RB] = OP(VCC, RB1, RB2, RE1, RC1, VBEON, BFN, RE2, VEBON, BFP);

[ZI, ZO, gm1, Rpi1, Ro1, AV2, AV_DB] = Impedances(IC2, VAFP, BFP, RE2, RE1, RC1, VAFN, BFN, VT, RB, RS, IC1);

Merit = freqA(RS, RC1,RE1,RB, Rload, Ci, Cb, Co, Cost, gm1, Ro1, Rpi1, AV2,AV_DB)