function [Req, tau] = Solver_t2_2(Data, V)
format long

%Get the results from solvers
I_2 = meshSolver_t2_2(Data,V);
V_2 = nodeSolver_t2_2(Data,V);

%define the names for the variables
Vi = ['V1'; 'V2'; 'V3'; 'V4'; 'V5'; 'V6'; 'V7'; 'V8'];
Ii = ['Ia'; 'Ib'; 'Ic'; 'Id'];
Ij = ['C'; 'Ib' ; 'R1'; 'R2'; 'R3'; 'R4'; 'R5'; 'R6'; 'R7'];
Ri = ['$R_eq$'; '$\tau$']
Ending = '\\ \hline';

%Get the currents on each branch
%the order is the same as Ij
IBranch(1) = I_2(4);
IBranch(2) = I_2(2);
IBranch(3) = I_2(1);
IBranch(4) = I_2(2);
IBranch(5) = I_2(1)+I_2(2);
IBranch(6) = I_2(1)+I_2(3);
IBranch(7) = I_2(4)-I_2(2);
IBranch(8) = I_2(3);
IBranch(9) = I_2(3);



%voltage
FileV = fopen('Voltages_2.tex','w');
for i = 1:8
  Volt = '%s%s & %.10f %s \n';
  fprintf(FileV, Volt, Vi(i,1), Vi(i,2), V_2(i), Ending);
endfor
%output on volts
fclose(FileV);


%current
FileA = fopen('Currents_2.tex','w');
for i = 1:4
  Ampere = '%s%s & %.10f %s \n';
  fprintf(FileA, Ampere, Ii(i,1), Ii(i,2), I_2(i), Ending);
endfor
%output on Ampere
fclose(FileA);

%current by branch
FileC = fopen('BranchCurrents_2.tex','w');

for i = 1:9
  Ampere = '%s%s & %.10f %s \n';
  fprintf(FileC, Ampere, Ij(i,1), Ij(i,2), IBranch(i), Ending);
endfor
%output on mAmpere
fclose(FileC);


%calculate Req
Req = abs((V_2(6)-V_2(8))/I_2(4));

%calculate time constant

tau = Req*Data(9)*power(10,-6); %Reminder: data  = [R1,R2,R3,R4,R5,R6,R7,Va,C,Kb,Kc]

%Write a tex with theses values
FileR = fopen('Req-tau.tex','w');
Res = '%s & %.10f %s \n';

fprintf(FileR, Res, Ri(1,:), Req, Ending);
fprintf(FileR, Res, Ri(2,:), tau, Ending);

fclose(FileR);





end
