function V = nodeSolver_t2_2(Data, V)

format long
pkg load symbolic


##data  = [R1,R2,R3,R4,R5,R6,R7,Va,Id,Kb,Kc]

for i= 1:7
  Data(i) = 1/Data(i);
endfor

G1 = Data(1);
G2 = Data(2);
G3 = Data(3);
G4 = Data(4);
G5 = Data(5);
G6 = Data(6);
G7 = Data(7);
Va = Data(8);
Id = 0;
Kb = Data(10);
Kd = Data(11);
Vx = V(6)-V(8);
I = 1;
O = 0;


##syms G1
##syms G2
##syms G3
##syms G4
##syms G5
##syms G6
##syms G7
##syms Va
##syms Id
##syms Kb
##syms Kc
##I = vpa (1.0)
##O = vpa (0.0)




A = [G1 (-G1-G2-G3) G2  O         G3 O O      O ;... %nó 2
     O  -Kb+G2      -G2 O         Kb O O      O ;... %nó 3
     O  G1          O   -G1-G4-G6 G4 O G6     O ;... %nó 4/ground
     O  O           O   G6        O  O -G6-G7 G7;... %nó 7
     -I O           O   I         O  O O      O ;... %V_5
     O  O           O   O         O  I O      -I;... %V_x
     O  O           O   Kd*G6     -I O -Kd*G6 I ;... %V_d
     O  O           O   I         O  O O      O ];   %Grnd=0

B = [O; O; O; O; O; Vx; O; O];

V = A\B;
end