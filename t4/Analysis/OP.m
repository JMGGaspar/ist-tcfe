function [IC2, IC1, RB] = OP(VCC, RB1, RB2, RE1, RC1, VBEON, BFN, RE2, VEBON, BFP)

format long
%Gain

RB=1/(1/RB1+1/RB2);
VEQ = (RB2/(RB1+RB2))*VCC;

IB1 =(VEQ-VBEON)/(RB+(1+BFN)*RE1);
IC1 = IB1*BFN;
IE1 = IB1*(1+BFN);

VE1 = IE1*RE1;
VO1 = VCC - IC1*RC1;
VCE = VO1- VE1;

%output 

VI2 = VO1;
IE2 = (VCC-VEBON-VI2)/RE2;
IC2 = BFP/(BFP+1)*IE2;
VO2 = VCC - RE2*IE2;

endfunction
