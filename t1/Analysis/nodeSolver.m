function V = nodeSolver(Data)

format long
pkg load symbolic


%data  = [R1,R2,R3,R4,R5,R6,R7,Va,Id,Kb,Kc]

for i= 1:7
  Data(i) = 1/Data(i);
endfor

G1 = Data(1)
G2 = Data(2)
G3 = Data(3)
G4 = Data(4)
G5 = Data(5)
G6 = Data(6)
G7 = Data(7)
Va = Data(8)
Id = Data(9)
Kb = Data(10)
Kc = Data(11)
I = 1;
O = 0;

%{
syms G1
syms G2
syms G3
syms G4
syms G5 
syms G6
syms G7
syms Va
syms Id
syms Kb
syms Kc
I = vpa (1.0)
O = vpa (0.0)
%}



A = [G1 (-G1-G2-G3) G2 O G3 O O O; O Kb+G2 -G2 O -Kb O O O; O Kb O O -Kb-G5 G5 O O; O O O -G6 O O G6+G7 -G7; O G3 O G4 -G3-G4-G5 G5 G7 -G7;...
I O O -I O O O O; O O O Kc*G6 -I O -Kc*G6 I; O O O I O O O O]

B = [O; O; Id; O; Id; Va; O; O]

V = A\B
end