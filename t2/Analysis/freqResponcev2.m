function freqResponcev2 (Data, fstart, fstop)
  
format long
f = logspace(fstart, fstop);
w = 2*pi*f;

for i=1:length(w)

  V(:,i) = nodeSolverPhasor(Data, w(i));

endfor

for i = 1:length(V(1,:))
  for j = 1:length(V(:,1))
    Vm(j,i) = abs(V(j,i));
    Vph(j,i) = arg(V(j,i));
    
  endfor
endfor
 
%make the plots

hm = figure ();
semilogx (f, Vm(6,:), "r");
hold on;
semilogx (f, Vm(8,:), "b");
grid on
legend('V6','Vc','Location','northeast')
xlabel ("f[Hz]");
ylabel ("V[dB]");
title ('Manitude plot')
print (hm, "Magnitude", "-depsc");



hph = figure ();
semilogx (f, Vph(6,:), "r");
hold on;
semilogx (f, Vph(8,:), "b");
grid on
legend('ph(V6)','ph(Vc)','Location','northeast')
xlabel ("f[Hz]");
ylabel ("Phase[degrees]");
title ('Phase plot')
print (hph, "Phase", "-depsc");

endfunction

