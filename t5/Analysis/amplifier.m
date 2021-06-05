function [Magnitude,Fase] = amplifier(R3,R4)
 %Function that calculates the magnitude and the phase of the non inverting OpAmp amplifier
%using the values of the resistors


V = 1 + R3/R4; %V=Vout/Vin
Magnitude = 20*log10(V); %magnitude in decibels
Fase=(180/pi)*arg(V); %angle in degrees

endfunction
