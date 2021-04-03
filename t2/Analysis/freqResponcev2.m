function freqResponcev2 (Data, fstart, fstop)
  
format long
f = logspace(fstart, fstop, 100);

%data  = [R1,R2,R3,R4,R5,R6,R7,Va,C,Kb,Kc]
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
Va = 1;
C  = Data(9);
Kb = Data(10);
Kd = Data(11);
I = 1;
O = 0;



for i=1:length(f)

w = 2*pi*f;
Zc = 1/(j*w(i)*C);
Yc = 1/Zc;

A = [G1 (-G1-G2-G3) G2  O      G3       O      O     O;...
     O   Kb+G2     -G2  O     -Kb       O      O     O;...
     O   Kb         O   O     -Kb-G5    G5+Yc  O     -Yc;...
     O   O          O  -G6     O        O      G6+G7 -G7;...
     O   G3         O   G4    -G3-G4-G5 G5+Yc  G7    -G7-Yc;...
     I   O          O   -I     O        O      O      O;...
     O   O          O   Kd*G6 -I        O      -Kd*G6 I;...
     O   O          O   I      O        O      O      O];

B = [O; O; O; O; O; Va; O; O];


V = A\B;  
  
V6(i) = V(6); 
Vc(i) = V(6)-V(8); 
Vs(i) = V(1);   
  
endfor

for i = 1:length(V6)
  V6m(i) = abs(V6(i));
  V6ph(i) = arg(V6(i));
  Vcm(i) = abs(Vc(i));
  Vcph(i) = arg(Vc(i));
  Vsm(i) = abs(Vs(i));
  Vsph(i) = arg(Vs(i));
  
  %convert to db
  V6m(i)= 20*log10(V6m(i));
  Vcm(i)= 20*log10(Vcm(i));
  Vsm(i) = 20*log10(Vsm(i));
  
  %convert to degrees
  V6ph(i) = V6ph(i)*180/pi;
  Vcph(i) = Vcph(i)*180/pi;
  Vsph(i) = Vsph(i)*180/pi;
endfor

 
%make the plots

hm = figure ();
semilogx (f, V6m, "r");
hold on;
semilogx (f, Vsm, "b");
hold on;
semilogx (f, Vcm, "g");
grid on
legend('V6','Vs', 'Vc','Location','southwest')
xlabel ("f[Hz]");
ylabel ("V[dB]");
title ('Manitude plot')
print (hm, "Magnitude", "-depsc");



hph = figure ();
semilogx (f, V6ph, "r");
hold on;
semilogx (f, Vsph, "b");
hold on;
semilogx (f, Vcph, "g");
hold on;
x = xlim; % current x-axis limits
plot([x(1) x(2)],[-90 -90])
hold on;
y = ylim; % current y-axis limits
plot([1000 1000],[y(1) y(2)])
grid on
legend('ph(V6)','ph(Vs)','ph(Vc)', '-90º', '1kHz','Location','southwest')
xlabel ("f[Hz]");
ylabel ("Phase[degrees]");
title ('Phase plot')
print (hph, "Phase", "-depsc");

endfunction

