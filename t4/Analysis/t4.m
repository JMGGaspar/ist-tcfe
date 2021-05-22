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

 
Cost = WriteSim(VCC, Vampl, RS, RC1, RB1, RB2, RE1, RE2, Rload, Ci, Cb, Co)

[IC2,IC1,RB] = OP(VCC, RB1, RB2, RE1, RC1, VBEON, BFN, RE2, VEBON, BFP);

[ZI, ZO, gm1, Rpi1, Ro1, AV2] = Impedances(IC2, VAFP, BFP, RE2, RE1, RC1, VAFN, BFN, VT, RB, RS, IC1);

Merit = freqA(RS, RC1,RE1,RB, Rload, Ci, Cb, Co, Cost, gm1, Ro1, Rpi1, AV2)