function Merit = freqA( Rs, Rc,Re, Rb, Rload, Ci, Cb, Cout, Cost, gm1, Ro1, Rpi1, AV2,AV_DB)
  
f = logspace(1, 8);


tf = [];
for j=1:1:size(f, 2)
tf = horzcat(tf, is_t(f(1, j), Rs, Ci)*gs_t(f(1, j), Rc, gm1, Ro1, Rpi1, Re, Rb, Cb)*AV2*out_t(f(1, j),Rload, Cout));
endfor
tf_mag = [];
tf_ph = [];

for j=1:1:size(tf, 2)
tf_mag = horzcat(tf_mag, 20*log10(abs(tf(1, j))));
tf_ph = horzcat(tf_ph, arg(tf(1, j))*180/pi);
endfor

t_max = tf_mag(1, 1);
for j=1:1:size(tf_mag, 2)
if tf_mag(1, j) > t_max
t_max = tf_mag(1, j);
endif
endfor

cutoff = t_max - 3;

t = [];
for j=1:1:size(tf_mag, 2)
t = horzcat(t, cutoff);
endfor

cf = [];
for j=1:1:size(tf_mag, 2)
if abs(tf_mag(1, j) - cutoff) < 0.6
cf = horzcat(cf, f(1, j));
endif
endfor

gain=abs(t_max);

bandwidth = cf(2) - cf(1)
lower_cutoff = cf(1)
Merit = bandwidth*gain/(Cost*lower_cutoff)


Ending = '\\ \hline';
File1 = fopen('OutputResults.tex','w');

fprintf(File1, '$Frequency Bandwidth (Hz)$ & %e %s\n', bandwidth, Ending)
fprintf(File1, '$Lower Cutoff Frequency(Hz)$ & %e %s\n', lower_cutoff, Ending)
fprintf(File1, '$V_{gain} (dB)$ & %f %s\n', gain, Ending)
fprintf(File1, '$Cost (MU)$ & %f %s\n', Cost, Ending)
fprintf(File1, '$Merit$ & %f %s\n', Merit, Ending)
fclose(File1);


hf = figure();
semilogx(f, tf_mag);
hold on;
semilogx(f, t);
grid on;
xlabel ("frequency (Hz)");
ylabel ("Magnitude (dB)");
title ("Magnitude plot");
legend("vo/vi(f)", "cutoff","location", "northwestoutside");
print (hf, "Mag_oc", "-depsc");

hg = figure();
semilogx(f, tf_ph);
grid on;
xlabel ("frequency (Hz)");
ylabel ("Phase (degrees)");
title ("Phase Plot");
legend("vo/vi(f)", "location", "northwestoutside");
print (hg, "Phase_oc", "-depsc");




endfunction


%Input stage gain
function y = is_t(f, Rs, C1)
y = 1/(1+2*pi*f*i*C1*Rs);
endfunction

%Gain stage gain (w/ frequency dependency)
function y = gs_t(f, Rc, gm1, Ro1, Rpi1, Re, Rb, Cb)
Ge = 1/Re;
Zeq = 1/(Ge + 2*pi*f*i*Cb);

%y= (Rc*(-gm1*Ro1*Rpi1 + Zeq))/(gm1*Ro1*Rpi1*Zeq + Rc*Rpi1 + Rc*Zeq + Ro1*Rpi1 + Ro1*Zeq + Rpi1*Zeq);
y = -Rc*(-gm1*Ro1*Rpi1+Zeq)/(Zeq*(-gm1*Ro1*Rpi1+Zeq)+(Rc+Ro1+Zeq)*(-Rpi1-Zeq));
endfunction

%Output resistor + capacitor gain
function y = out_t(f, Rload, Cout)
  
y = 2*pi*f*i*Cout*Rload/(1+2*pi*f*i*Cout*Rload);
endfunction