function MU = WriteSim (R1, R2, C1, n, Va, nD)

f= 50; %Hz;
de = "Default";
u = "u";
k = "k";
d = "D";
m = 1/n;

Dn = nD %number of diodes
MU=0

%Sim1-------------------------------------------------------------------------------------------------------
Sim1 = fopen('Sim_t3.cir','w');

fprintf(Sim1, ".OP \n")

fprintf(Sim1, ".param n={1/%f} \n", n)

fprintf(Sim1, "**Voltage source ****************************************** \n")
fprintf(Sim1, "Vc Ph 0  dc sin(0 %f %f) \n", Va, f)
fprintf(Sim1, "\n")

fprintf(Sim1, "**Transformer ****************************************** \n")
fprintf(Sim1, "F1 Ph 0  E1  n \n")
fprintf(Sim1, "E1 vac vacref Ph 0 n \n")
fprintf(Sim1, "\n")

fprintf(Sim1, "** Rectifier****************************************** \n")
fprintf(Sim1, "DR1 vac 1 %s \n", de)
fprintf(Sim1, "DR2 GND vac %s \n", de)
fprintf(Sim1, "DR3 vacref 1 %s \n", de)
fprintf(Sim1, "DR4 GND vacref %s \n", de)
MU = MU + 0.4
fprintf(Sim1, "\n")

fprintf(Sim1, "**First regulation ************************************* \n")
fprintf(Sim1, "C1 1 GND %f%s \n", C1,u)
fprintf(Sim1, "R1 1 GND %f%s \n", R1, k)
fprintf(Sim1, "R2 1 2 %f%s \n", R2, k)
fprintf(Sim1, "\n")
MU = MU + C1 + R1 + R2 

fprintf(Sim1, "**Final regulation**************************************** \n")

for i = 1:Dn-1
fprintf(Sim1, "D%i %i %i %s \n", i, (i+1), (i+2), de)
MU = MU + 0.100000000000001 %conpensate for the precision loss
lasti=i;
endfor
fprintf(Sim1, "D%i %i GND %s \n", (lasti+1), (lasti+2), de)
MU = MU + 0.1
fprintf(Sim1, "\n")
fprintf(Sim1, "******************************************** \n")
fprintf(Sim1, ".model %s D \n", de)
fprintf(Sim1, ".csparam Mu=%f \n", MU)
fprintf(Sim1, "\n")
fprintf(Sim1, "******************************************** \n")
fprintf(Sim1, ".END \n")

fclose(Sim1);


end
