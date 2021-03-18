function I = meshSolver(Data)
  
format long


%data  = [R1,R2,R3,R4,R5,R6,R7,Va,Id,Kb,Kc]
R1 = Data(1);
R2 = Data(2);
R3 = Data(3);
R4 = Data(4);
R5 = Data(5); 
R6 = Data(6);
R7 = Data(7);
Va = Data(8);
Id = Data(9);
Kb = Data(10); 
Kc = Data(11);
I = 1;
O = 0;

%these are Os intead of zeros on purpose (the same for Is instead of ones)
A = [R1+R3+R4 R3 R4 O; Kb Kb-I O O; R4 O R4+R6+R7-Kc O ; O O O I]
B = [Va; O; O; Id]

I = A\B
end