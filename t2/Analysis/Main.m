format long

%Open the data
fileID = fopen('Data.txt','r');
Data = fscanf(fileID,'%f');
fclose(fileID);

%convert to ohm
Data(11) = Data(11)*1e3;
for i= 1:7
  Data(i) = 1000*Data(i);
endfor
%convert to S
Data(10)= Data(10)*1e-3;

%OP analisis (return voltages)
V = Solver(Data);

%create the circuits for the ngspice
WriteSim(Data,V);

%Calculate the R_eq and the time constant
%função para isso

%tran analysis (both nat and forced)
%função para isso

%freq analysis
%função para isso

%gg