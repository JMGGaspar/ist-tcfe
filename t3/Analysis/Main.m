
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
[Req, tau, V_2] = Solver_t2_2(Data,V);

%tran analysis (both nat and forced)
Data(9)= Data(9)*1e-6 %convert to farad

start = 0;    %t=0s
stop = 20e-3; %t=20ms
freq = 1000; %Hz

trans (Data, V, V_2, Req, tau, start, stop, freq);

%freq analysis
fstart = -1
fstop = 6
freqResponcev2 (Data, fstart, fstop, Req)
%gg
