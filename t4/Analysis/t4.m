format long

%define the constants
%NPN transistor
VT=25e-3;
BFN=178.7;
VAFN=69.7;
VbeON=0.7;


%PNP transistor
BFP = 227.3;
VAFP = 37.2;
VebON = 0.7;

%circuit constants

Vampl = 10e-3;
Vcc = 12;

Rin = 100;
Rc = 1000;
Rb1 = 80000;
Rb2 = 20000;
Re = 100;
Rout = 100;
Rload = 8;

Ci=1e-3;
Cb=1e-3;
Co=1e-6;


Cost = WriteSim(Vcc, Vampl, Rin, Rc, Rb1, Rb2, Re, Rout, Rload, Ci, Cb, Co)

[Vemit2, Iemit2] = OP(Vcc, Rb1, Rb2, Re, Rc, VbeON, BFN, Rout, VebON, BFP)

