%function V = nodeSolver(Data)

format long
pkg load symbolic


%data  = [R1,R2,R3,R4,R5,R6,R7,Va,Id,Kb,Kc]

% converter os valores de R em valores de G, por conveniencia nas op. matriciais
%{
for i= 1:7
  Data(i) = 1/Data(i);
endfor
%}

G1 = 1/1.02806435778 %Data(1)
G2 = 1/2.0319770372 %Data(2)
G3 = 1/3.0063814709 %Data(3)
G4 = 1/4.18397333097 %Data(4)
G5 = 1/3.11993742552 %Data(5)
G6 = 1/2.08858744661 %Data(6)
G7 = 1/1.0004498667 %Data(7)
Va = 5.00894173155 %Data(8)
Id = 1.03365328826 %Data(9)
Kb = 7.06316528745 %Data(10)
Kd = 8.11924814489 %Data(11)
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
##syms Kd
##I = vpa (1.0)
##O = vpa (0.0)



% matriz com as eq. da lei dos nós 
%    V1    V2         V3      V4/GR  V5          V6      V7       V8
A = [-G1 , G1+G2+G3 , -G2   , O    , -G3       , O     , O      , O   ;... %nó 2
     O   , Kb-G2    , G2+Kb , O    , O         , -Kb   , O      , O   ;... %nó 3
     O   , O        , -Kb   , O    , -G5       , G5+Kb , O      , O   ;... %nó 6
     O   , O        , O     , -G6  , O         , O     , G6+G7  , -G7 ;... %nó 7
     O   , O        , O     , I    , O         , O     , O      , O   ;... %ground 
     I   , O        , O     , -I   , O         , O     , O      , O   ;... %f. tensão linear
     O   , O        , O     , O    , I         , O     , O      , -I  ;... %f. tensão dependente
     O   , -G3      , O     , -G4  , G3+G4+G5  , -G5   , -G7    , G7  ]    %super-nó
     
B = [O; O; O; O; O; Va; Kd*Id; O]

V = A\B
%end