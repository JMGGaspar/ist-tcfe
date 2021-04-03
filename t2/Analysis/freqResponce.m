function freqResponce (Data, fstart, fstop)
  
format long
pkg load symbolic

%data  = [R1,R2,R3,R4,R5,R6,R7,Va,C,Kb,Kc]

for j= 1:7
  Data(j) = 1/Data(j);
endfor

syms w

G1 = Data(1);
G2 = Data(2);
G3 = Data(3);
G4 = Data(4);
G5 = Data(5);
G6 = Data(6);
G7 = Data(7);
Va = 1;
C  = Data(9);
Kb = Data(10);
Kd = Data(11);
I = 1;
O = 0;

Zc = 1/(j*w*C);
Yc = 1/Zc;
 
A = [[G1 (-G1-G2-G3) G2  O      G3       O      O     O      ];...
     [O   Kb+G2     -G2  O     -Kb       O      O     O      ];...
     [O   Kb         O   O     -Kb-G5    G5+Yc  O     -Yc    ];...
     [O   O          O  -G6     O        O      G6+G7 -G7    ];...
     [O   G3         O   G4    -G3-G4-G5 G5+Yc  G7    -G7-Yc ];...
     [I   O          O   -I     O        O      O      O     ];...
     [O   O          O   Kd*G6 -I        O      -Kd*G6 I     ];...
     [O   O          O   I      O        O      O      O     ]];

B = [O; O; O; O; O; Va; O; O];

V = A\B;

Vx = (V(6)- V(8));
Vxm = abs(Vx);
Vxph = arg(Vx);

for j = 1:length(V)
  Vm(j) = abs(V(j));
  Vph(j) = arg(V(j));
endfor
   
   
%magnitude of V6
function [y] = V6M (v6_m, f)
   w = 2*pi*f;
   y = 20*log(eval(v6_m));
endfunction
   
%mangitude of Vx
function [y] = VXM (vx_m, f)
   w = 2*pi*f;
   y = 20*log(eval(vx_m));
endfunction
  
%phase of V6 
function [y] = V6Ph (v6_ph, f)
   w = 2*pi*f;
   y = eval(v6_ph)*180/pi;
endfunction  
%phase of vx

function [y] = VXPh (vx_ph, f)
   w = 2*pi*f;
   y = eval(vx_ph)*180/pi;
endfunction  
 
%make the plots
f = logspace(fstart, fstop);

hm = figure ();
semilogx (f, V6M(Vm(6), f), "r");
hold on;
semilogx (f, VXM(Vxm, f), "b");
grid on
legend('V6','Vc','Location','northeast')
xlabel ("f[Hz]");
ylabel ("V[dB]");
title ('Manitude plot')
print (hm, "Magnitude", "-depsc");



hph = figure ();
semilogx (f, V6Ph(Vph(6), f), "r");
hold on;
semilogx (f, VXPh(Vxph, f), "b");
grid on
legend('ph(V6)','ph(Vc)','Location','northeast')
xlabel ("f[Hz]");
ylabel ("Phase[degrees]");
title ('Phase plot')
print (hph, "Phase", "-depsc");

endfunction

