format long

%define the names for the variables
Vi = ['V1'; 'V2'; 'V3'; 'V4'; 'V5'; 'V6'; 'V7'; 'V8'];
Ij = ['C'; 'Ib'; 'R1'; 'R2'; 'R3'; 'R4'; 'R5'; 'R6'; 'R7'];
Ending = '\\ \hline';


%----------------------Simples OP analysis------------

%Open the data from octave
Oc_Volt_1_filename = "../Analysis/Voltages.tex"
Oc_Volt_1_file = fopen(Oc_Volt_1_filename,'r');
Oc_Volt_1 = textscan(Oc_Volt_1_file,'%s %s %f %s %s');
fclose(Oc_Volt_1_file);

Oc_Curr_1_filename = "../Analysis/BranchCurrents.tex"
Oc_Curr_1_file = fopen(Oc_Curr_1_filename,'r');
Oc_Curr_1 = textscan(Oc_Curr_1_file,'%s %s %f %s %s');
fclose(Oc_Curr_1_file);

%Open the data from ngspice
NGS_1_filename = "../Simulation/op_tab.tex"
NGS_1_file = fopen(NGS_1_filename,'r');
NGS_1 = textscan(NGS_1_file,'%s %s %f %s %s');
fclose(NGS_1_file);

%current diffs
for i = 1:9
  ErrorC1(i)=(Oc_Curr_1{3}(i)-NGS_1{3}(i))./Oc_Curr_1{3}(i);
endfor

FileA1 = fopen('Currents_diff.tex','w');
for i = 1:9
  Ampere = '%s%s & %.10f %s \n';
  fprintf(FileA1, Ampere, Ij(i,1), Ij(i,2), ErrorC1(i), Ending)
endfor
%output on Ampere
fclose(FileA1);



%voltage diffs
for i = 1:8
  ErrorV1(i)=(Oc_Volt_1{3}(i)-NGS_1{3}(i+9))./Oc_Volt_1{3}(i);
endfor

FileV1 = fopen('Voltages_diff.tex','w');
for i = 1:8
  Volt = '%s%s & %.10f %s \n';
  fprintf(FileV1, Volt, Vi(i,1), Vi(i,2), ErrorV1(i), Ending)
endfor
%output on volts
fclose(FileV1);


%----------------------Second OP analysis------------

%Open the data from octave
Oc_Volt_2_filename = "../Analysis/Voltages_2.tex"
Oc_Volt_2_file = fopen(Oc_Volt_2_filename,'r');
Oc_Volt_2 = textscan(Oc_Volt_2_file,'%s %s %f %s %s');
fclose(Oc_Volt_2_file);

Oc_Curr_2_filename = "../Analysis/BranchCurrents_2.tex"
Oc_Curr_2_file = fopen(Oc_Curr_2_filename,'r');
Oc_Curr_2 = textscan(Oc_Curr_2_file,'%s %s %f %s %s');
fclose(Oc_Curr_2_file);

%Open the data from ngspice
NGS_2_filename = "../Simulation/op2_tab.tex"
NGS_2_file = fopen(NGS_2_filename,'r');
NGS_2 = textscan(NGS_2_file,'%s %s %f %s %s');
fclose(NGS_2_file);

%current diffs
for i = 1:8
  ErrorC2(i)=(Oc_Curr_2{3}(i+1)-NGS_2{3}(i))./Oc_Curr_2{3}(i+1);
  %the +1 on the currents appens since ngspice doesnt measure C voltage.
  % but octave measures it.
endfor

FileA2 = fopen('Currents_2_diff.tex','w');
for i = 1:8
  Ampere = '%s%s & %.10f %s \n';
  fprintf(FileA2, Ampere, Ij(i,1), Ij(i,2), ErrorC2(i), Ending)
endfor
%output on Ampere
fclose(FileA2);



%voltage diffs
for i = 1:8
  ErrorV2(i)=(Oc_Volt_2{3}(i)-NGS_2{3}(i+8))./Oc_Volt_2{3}(i);
endfor

FileV2= fopen('Voltages_2_diff.tex','w');
for i = 1:8
  Volt = '%s%s & %.10f %s \n';
  fprintf(FileV2, Volt, Vi(i,1), Vi(i,2), ErrorV2(i), Ending)
endfor
%output on volts
fclose(FileV2);

