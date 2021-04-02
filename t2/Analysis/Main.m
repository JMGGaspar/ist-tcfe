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
Solver_t2_2(Data,V)

%tran analysis (both nat and forced)
start = 0    %t=0s
stop = 20e-3 %t=20ms
tau = 0.01
trans (Data, V, tau, start, stop)

%freq analysis
%função para isso

%gg