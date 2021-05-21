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
RC1 = 1000;
RB1 = 80000;
RB2 = 20000;
RE1 = 100;
RE2 = 100;
Rload = 8;

Ci=1e-3;
Cb=1e-3;
Co=1e-6;

 
Cost = WriteSim(VCC, Vampl, RS, RC1, RB1, RB2, RE1, RE2, Rload, Ci, Cb, Co)

[IC2,IC1,RB] = OP(VCC, RB1, RB2, RE1, RC1, VBEON, BFN, RE2, VEBON, BFP);

[ZI, ZO] = Impedances(IC2, VAFP, BFP, RE2, RE1, RC1, VAFN, BFN, VT, RB, RS, IC1)
