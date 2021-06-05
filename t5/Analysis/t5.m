format long

%constants
C1= 220e-9
C2= 220e-9
R1= 1e3
R2=1e3
R3=100e3
R4=1e3

Vin_ph= 0;
Vin_m = 10e-3;

f = logspace(1, 6, 10000);
 
[V1_m,V1_ph] = HighPassFilter(C1,R1,f);

[V2_m,V2_ph] = amplifier(R3,R4,f);

[V3_m,V3_ph] = LowPassFilter(C2,R2,f);

[Gain, cFreq] = circuitAnalysis(V1_m, V1_ph, V2_m, V2_ph, V3_m, V3_ph, Vin_m, f)
