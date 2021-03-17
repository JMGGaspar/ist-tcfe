format long

R1 = 1.02806435778 
R2 = 2.0319770372 
R3 = 3.0063814709 
R4 = 4.18397333097 
R5 = 3.11993742552 
R6 = 2.08858744661 
R7 = 1.0004498667 
Va = 5.00894173155 
Id = 1.03365328826 
Kb = 7.06316528745 
Kc = 8.11924814489 

x = [R1,R2,R3,R4,R5,R6,R7,Va,Id,Kb,Kc]


fileID = fopen('Data96375.txt','w');
Data = fscanf(fileID,'%f');
fprintf(fileID,'%f\n',x)
fclose(fileID);