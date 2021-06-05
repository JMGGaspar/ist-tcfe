function [ZI, ZO, gm1, rpi1, ro1, AV2, AV_DB] = Impedances(IC2, VAFP, BFP, RE2, RE1, RC1, VAFN, BFN, VT, RB, RS, IC1)

%gain stage

gm1=IC1/VT;
rpi1=BFN/gm1;
ro1=VAFN/IC1;

RSB=RB*RS/(RB+RS);

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1));
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1);
AVIsimple_DB = 20*log10(abs(AV1simple));

ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)));
ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)));
ZX1 = ro1*(1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB))/(1/RE1+1/(rpi1+RSB)) ;
ZO1X = 1/(1/ZX1+1/RC1)

ZO1 = 1/(1/ro1+1/RC1);

%output stage

gm2 = IC2/VT;
go2 = IC2/VAFP;
gpi2 = gm2/BFP;
ge2 = 1/RE2;

AV2 = gm2/(gm2+gpi2+go2+ge2)
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2);
ZO2 = 1/(gm2+gpi2+go2+ge2);



%total
gB = 1/(1/gpi2+ZO1);

AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1
AV_DB = 20*log10(abs(AV))
ZI=ZI1
ZO=1/(go2+gm2/gpi2*gB+ge2+gB)
  
  
Ending = '\\ \hline';
Ohm = "\Omega"
File1 = fopen('impedances.tex','w');

fprintf(File1, '$Input impedance(%s)$ & %e %s\n',Ohm , ZI, Ending)
fprintf(File1, '$Output impedance(%s)$ & %e %s\n', Ohm, ZO, Ending)
fclose(File1);
  
endfunction
