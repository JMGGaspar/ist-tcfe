function I = meshSolver(Data,V)
  
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
Id = 0;
Kb = Data(10); 
Kd = Data(11);
I = 1;
O = 0;

%these are Os instead of zeros on purpose (the same for Is instead of ones)
%Ic and Id refer to our mesh convention, not necessarily to the exercise's figure

%    Ia       Ib        Ic          Id
A = [R1+R3+R4 R3        R4          O ;... %mesh A
     Kb*(R3)  Kb*(R3)-I O           O ;... %mesh B
     R4       O         R4+R6+R7-Kd O ;... %mesh C
     O        O         O           I ];   %mesh D
     
B = [Va;      O;        O;          Id];

I = A\B

end