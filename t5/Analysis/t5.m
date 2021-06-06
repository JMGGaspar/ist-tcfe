format long

%constants
C1= 110e-9
C2= 180.3278689e-9
R1= 5e3
R2=0.5e3
R3=100e3
R4=1e3

Vin_ph= 0;
Vin_m = 10e-3;

Ending = '\\ \hline';
Ohm = '\Omega'

File1 = fopen('inputs.tex','w');
fprintf(File1, '$R_1$ & $%.2f %s$ %s\n',R1,Ohm , Ending)
fprintf(File1, '$R_2$ & $%.2f %s$ %s\n',R2,Ohm , Ending)
fprintf(File1, '$R_3$ & $%.2f %s$ %s\n',R3,Ohm , Ending)
fprintf(File1, '$R_4$ & $%.2f %s$ %s\n',R4,Ohm , Ending)
fprintf(File1, '$C_1$ & $%e F$ %s\n', C1, Ending)
fprintf(File1, '$C_2$ & $%e F$ %s\n', C2, Ending)
fclose(File1);


f = logspace(1, 6, 10000);
 
[V1_m,V1_ph] = HighPassFilter(C1,R1,f);

[V2_m,V2_ph] = amplifier(R3,R4,f);

[V3_m,V3_ph] = LowPassFilter(C2,R2,f);

[Gain, cFreq] = circuitAnalysis(V1_m, V1_ph, V2_m, V2_ph, V3_m, V3_ph, Vin_m, f);



%Input Impedance (f=f_c)

Z1 = R1 + 1/(j*2*pi*cFreq*C1)

%Output Impedance (f=f_c)

ZO = R2/(j*2*pi*cFreq*C2)/ (R2+1/(j*2*pi*cFreq*C2))


File3 = fopen('impedances.tex','w');

fprintf(File3, '$Re(Z_{in})(%s)$ & %e %s\n',Ohm , real(Z1), Ending)
fprintf(File3, '$Im(Z_{in})(%s)$ & %e %s\n',Ohm , imag(Z1), Ending)
fprintf(File3, '$Re(Z_{out})(%s)$ & %e %s\n', Ohm, real(ZO), Ending)
fprintf(File3, '$Im(Z_{out})(%s)$ & %e %s\n', Ohm, imag(ZO), Ending)
fclose(File3);

% custo sem OP AMP 124.66
cost = 13447.65204

Merit = 1/(cost*(1e-6+abs(100-10^(Gain/20))+abs(1000-cFreq)))

File2 = fopen('outputs.tex','w');
fprintf(File2, 'Gain & %.5f dB %s\n',Gain, Ending)
fprintf(File2, 'Central Frequency & %.2f Hz %s\n',cFreq, Ending)
fprintf(File2, 'Cost & %.2f MU %s \n',cost, Ending)
fprintf(File2, 'Merit & %e %s\n', Merit, Ending)
fclose(File2);
