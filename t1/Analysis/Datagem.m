format long

R1 = 1.02806435778e3
R2 = 2.0319770372e3
R3 = 3.0063814709e3
R4 = 4.18397333097e3
R5 = 3.11993742552e3
R6 = 2.08858744661e3
R7 = 1.0004498667e3
Va = 5.00894173155
Id = 1.03365328826e-3 
Kb = 7.06316528745e-3  %mS
Kc = 8.11924814489e3    %kOhm

x = [R1,R2,R3,R4,R5,R6,R7,Va,Id,Kb,Kc]


fileID = fopen('Data96375.txt','w');
fprintf(fileID,'%f\n',x)
fclose(fileID);