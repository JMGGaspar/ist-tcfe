function WriteSim (Data, V)

R1 = Data(1);
R2 = Data(2);
R3 = Data(3);
R4 = Data(4);
R5 = Data(5); 
R6 = Data(6);
R7 = Data(7);
Va = Data(8);
C = Data(9); %dont forget to add the u later
Kb = Data(10);
Kd = Data(11);

u = "u";

%Sim1-------------------------------------------------------------------------------------------------------
Sim1 = fopen('sim_1.cir','w');

fprintf(Sim1, ".OP \n")

fprintf(Sim1, "Vc 1 0 %f \n", Va)
fprintf(Sim1, "C 6 8 %f%s \n", C, u)

fprintf(Sim1, "R1 1 2 %f \n", R1)
fprintf(Sim1, "R2 3 2 %f \n", R2)
fprintf(Sim1, "R3 2 5 %f \n", R3)
fprintf(Sim1, "R4 5 0 %f \n", R4)
fprintf(Sim1, "R5 6 5 %f \n", R5)
fprintf(Sim1, "R6 4 7 %f \n", R6)
fprintf(Sim1, "R7 7 8 %f \n", R7)
fprintf(Sim1, "Gcs 6 3 2 5 %f \n", Kb)
fprintf(Sim1, "Vprobe 0 4 0 \n")
fprintf(Sim1, "Hvs 5 8 Vprobe %f \n", Kd)

fprintf(Sim1, ".END \n")

fclose(Sim1);


%Sim2-------------------------------------------------------------------------------------------------------
Sim2 = fopen('sim_2.cir','w');

fprintf(Sim2, ".OP \n")

fprintf(Sim2, "Vc 1 0 0 \n")
fprintf(Sim2, "V 6 8 %f \n", (V(6)-V(8)))

fprintf(Sim2, "R1 1 2 %f \n", R1)
fprintf(Sim2, "R2 3 2 %f \n", R2)
fprintf(Sim2, "R3 2 5 %f \n", R3)
fprintf(Sim2, "R4 5 0 %f \n", R4)
fprintf(Sim2, "R5 6 5 %f \n", R5)
fprintf(Sim2, "R6 4 7 %f \n", R6)
fprintf(Sim2, "R7 7 8 %f \n", R7)
fprintf(Sim2, "Gcs 6 3 2 5 %f \n", Kb)
fprintf(Sim2, "Vprobe 0 4 0 \n")
fprintf(Sim2, "Hvs 5 8 Vprobe %f \n", Kd)

fprintf(Sim2, ".END \n")

fclose(Sim2);

%Sim3-------------------------------------------------------------------------------------------------------
Sim3 = fopen('sim_3.cir','w');

fprintf(Sim3, ".OP \n")

fprintf(Sim3, "Vc 1 0 0 \n")
fprintf(Sim3, "C 6 8 %f%s \n", C, u)

fprintf(Sim3, "R1 1 2 %f \n", R1)
fprintf(Sim3, "R2 3 2 %f \n", R2)
fprintf(Sim3, "R3 2 5 %f \n", R3)
fprintf(Sim3, "R4 5 0 %f \n", R4)
fprintf(Sim3, "R5 6 5 %f \n", R5)
fprintf(Sim3, "R6 4 7 %f \n", R6)
fprintf(Sim3, "R7 7 8 %f \n", R7)
fprintf(Sim3, "Gcs 6 3 2 5 %f \n", Kb)
fprintf(Sim3, "Vprobe 0 4 0 \n")
fprintf(Sim3, "Hvs 5 8 Vprobe %f \n", Kd)
fprintf(Sim3, ".IC v(6)=%f v(8)=%f \n", V(6), V(8))

fprintf(Sim3, ".END \n")

fclose(Sim3);

%Sim4-------------------------------------------------------------------------------------------------------
Sim4 = fopen('sim_4.cir','w');

fprintf(Sim4, ".OP \n")

fprintf(Sim4, "Vc 1 0 dc sin(0 1 1k) ac 1 \n")
fprintf(Sim4, "C 6 8 %f%s \n", C, u)

fprintf(Sim4, "R1 1 2 %f \n", R1)
fprintf(Sim4, "R2 3 2 %f \n", R2)
fprintf(Sim4, "R3 2 5 %f \n", R3)
fprintf(Sim4, "R4 5 0 %f \n", R4)
fprintf(Sim4, "R5 6 5 %f \n", R5)
fprintf(Sim4, "R6 4 7 %f \n", R6)
fprintf(Sim4, "R7 7 8 %f \n", R7)
fprintf(Sim4, "Gcs 6 3 2 5 %f \n", Kb)
fprintf(Sim4, "Vprobe 0 4 0 \n")
fprintf(Sim4, "Hvs 5 8 Vprobe %f \n", Kd)
fprintf(Sim4, ".IC v(6)=%f v(8)=%f \n", V(6), V(8))

fprintf(Sim4, ".END \n")

fclose(Sim4);

end