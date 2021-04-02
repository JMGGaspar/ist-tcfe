function V = Solver(Data)
format long

%Open the data
fileID = fopen('Data.txt','r');
Data = fscanf(fileID,'%f')
fclose(fileID);

%Get the results from solvers
I = meshSolver(Data);
V = nodeSolver(Data);

%define the names for the variables
Vi = ['V1'; 'V2'; 'V3'; 'V4'; 'V5'; 'V6'; 'V7'; 'V8'];
Ii = ['Ia'; 'Ib'; 'Ic'; 'Id'];
Ij = ['Ib'; 'Id'; 'R1'; 'R2'; 'R3'; 'R4'; 'R5'; 'R6'; 'R7'];
Ending = '\\ \hline';

%Get the currents on each branch
%the order is tha same as Ij
IBranch(1) = I(2);
IBranch(2) = I(4);
IBranch(3) = I(1);
IBranch(4) = I(2);
IBranch(5) = I(1)+I(2);
IBranch(6) = I(1)+I(3);
IBranch(7) = I(4)-I(2);
IBranch(8) = I(3);
IBranch(9) = I(3);

%voltage
FileV = fopen('Voltages.tex','w');
for i = 1:8
  Volt = '%s%s & %f %s \n';
  fprintf(FileV, Volt, Vi(i,1), Vi(i,2), V(i), Ending)
endfor
%output on volts
fclose(FileV);


%curent
FileA = fopen('Currents.tex','w');
for i = 1:4
  Ampere = '%s%s & %f %s \n';
  fprintf(FileA, Ampere, Ii(i,1), Ii(i,2), I(i), Ending)
endfor
%output on Ampere
fclose(FileA);

%curent by branch
FileC = fopen('BranchCurrents.tex','w');

for i = 1:9
  Ampere = '%s%s & %f %s \n';
  fprintf(FileC, Ampere, Ij(i,1), Ij(i,2), IBranch(i), Ending)
endfor
%output on mAmpere
fclose(FileA);

end
