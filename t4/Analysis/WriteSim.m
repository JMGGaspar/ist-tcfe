function MU = WriteSim(VCC, Vampl, RS, RC1, RB1, RB2, RE1, RE2, Rload, Ci, Cb, Co)

format long

de = "Default";
u = "u";
k = "k";
m = "m";
d = "D";
f = 1e3;
MU=0;

%Sim1-------------------------------------------------------------------------------------------------------
Sim1 = fopen('Sim_t4.cir','w');

fprintf(Sim1, ".OP \n");


fprintf(Sim1, "**Voltage source ****************************************** \n");
fprintf(Sim1, "Vcc vcc 0 %f \n", VCC);
fprintf(Sim1, "Vin in 0 0 ac 1.0 sin(0 %f %f) \n", Vampl, f);
fprintf(Sim1, "Rin in in2 %f \n", RS);
MU = MU + RS/1000;
fprintf(Sim1, "\n");

fprintf(Sim1, "**coupling capacitor ****************************************** \n");
fprintf(Sim1, "Ci in2 base  %f \n", Ci);
MU = MU + Ci/(1e-6);
fprintf(Sim1, "\n");

fprintf(Sim1, "** bias circuit****************************************** \n");
fprintf(Sim1, "Rb1 vcc base %f \n", RB1);
fprintf(Sim1, "Rb2 base 0 %f \n", RB2);
MU = MU + RB2/1000+RB1/1000;
fprintf(Sim1, "\n");

fprintf(Sim1, "**gain stage ************************************* \n");
fprintf(Sim1, "Q1 coll base emit BC547A \n");
fprintf(Sim1, "Rc vcc coll %f \n", RC1);
fprintf(Sim1, "Re emit 0 %f \n", RE1);
MU = MU + RE1/1000+RC1/1000 + 0.1;
fprintf(Sim1, "\n");

fprintf(Sim1, "** bypass capacitor ************************************* \n");
fprintf(Sim1, "Cb emit 0 %f \n", Cb);
MU = MU + Cb/(1e-6);
fprintf(Sim1, "\n");

fprintf(Sim1, "**output stage ************************************* \n");
fprintf(Sim1, "Q2 0 coll emit2 BC557A \n");
fprintf(Sim1, "Rout emit2 vcc %f \n", RE2);
MU = MU + RE2/1000 + 0.1;
fprintf(Sim1, "\n");

fprintf(Sim1, "**output coupling capacitor ************************************* \n");
fprintf(Sim1, "Co emit2 out %f \n", Co);
MU = MU + Co/(1e-6);
fprintf(Sim1, "\n");

fprintf(Sim1, "**load ************************************* \n");
fprintf(Sim1, "Rload out2 0 %f \n", Rload);
fprintf(Sim1, "Vout out out2 0 \n");
MU = MU + Rload/(1e3);
fprintf(Sim1, "\n");

fprintf(Sim1, "******************************************** \n");
fprintf(Sim1, ".csparam Mu=%f \n", MU);
fprintf(Sim1, "\n");
fprintf(Sim1, "******************************************** \n");
fprintf(Sim1, ".END \n");

fclose(Sim1);


end
