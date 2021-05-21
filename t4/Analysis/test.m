close all
clear all
format long

%-------------------------------------------------------------------------
%Gain stage
%-------------------------------------------------------------------------

%Constants and circuit specs
VT=0.0258649170201;
BFN=178.7;
VAFN=69.7;
RE1=100;
RC1=1e3;
RB1=80e3;
RB2=20e3;
VBEON=0.7;
VCC=12;
RS=100;

%OP analysis
RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1
