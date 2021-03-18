format long

fileID = fopen('Data96375.txt','r');
Data = fscanf(fileID,'%f')
fclose(fileID);

I = meshSolver(Data);
V = nodeSolver(Data);
Vi = ['V1'; 'V2'; 'V3'; 'V4'; 'V5'; 'V6'; 'V7'; 'V8'];
Ii = ['Ia'; 'Ib'; 'Ic'; 'Id'];
Ending = '\\ \hline';

%convert A to mA
for i=1:4
  I(i)= I(i)*1000;
endfor


%voltage
FileV = fopen('Voltages.tex','w');
for i = 1:8
  Volt = '%s%s & %f %s \n';
  fprintf(FileV, Volt, Vi(i,1), Vi(i,2), V(i), Ending)
endfor
%output on volts
fclose(FileV);


%cureent
FileA = fopen('Currents.tex','w');
for i = 1:4
  Ampere = '%s%s & %f %s \n';
  fprintf(FileA, Ampere, Ii(i,1), Ii(i,2), I(i), Ending)
endfor
%output on mAmpere
fclose(FileA);

