function [Gain, cFreq] = circuitAnalysis(V1_m, V1_ph, V2_m, V2_ph, V3_m, V3_ph, Vin_m, f)
  
Magnitude = V1_m+V2_m+V3_m;
Phase = V1_ph+V2_ph+V3_ph;

Vout_m = Magnitude + 20*log10(Vin_m);
Vout_ph = Phase;

Gain = max(Magnitude)
Vcutoff = max(Vout_m) - 3

fi = [];
for i=1:length(Vout_m)
  if abs(Vout_m(i) - Vcutoff) < 0.00325
  fi = horzcat(fi, f(i))
endif
endfor


cFreq = (fi(1)*fi(length(fi)))^0.5


%magnitude plot
hf=figure();
semilogx(f,Vout_m);
hold on;
y = ylim; % current y-axis limits
x = xlim;
semilogx([cFreq cFreq],[y(1) y(2)])
hold on;
semilogx([x(1) x(2)],[Vcutoff Vcutoff])
grid on;
title('Output voltage');
xlabel('f (Hz)');
ylabel('Output voltage (dB)');
legend("Vout", "Central Freq.","Vcutoff","location", "southwest");
print (hf, "Vou_mt", "-depsc");

hj=figure();
semilogx(f,Magnitude);
hold on;
y = ylim; % current y-axis limits
x = xlim;
semilogx([cFreq cFreq],[y(1) y(2)])
hold on;
semilogx([x(1) x(2)],[(max(Magnitude)-3) (max(Magnitude)-3)])
grid on;
title('Output Gain');
xlabel('f (Hz)');
ylabel('Gain (dB)');
legend("Vout", "Central Freq.","Vcutoff","location", "southwest");
print (hj, "Mag_out", "-depsc");

%phase plot
hg=figure();
semilogx(f,Vout_ph);
grid on;
title('Output Phase');
xlabel('f (Hz)');
ylabel('Phase (º)');
legend("Vout","location", "southwest");
print (hg, "Phase_out", "-depsc");




endfunction
