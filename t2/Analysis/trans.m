function trans (Data, V, V_2, Req, tau, start, stop, freq)
format long
 
deltaT = (stop-start)/1000;
 
t = start:deltaT:stop;
w = 2*pi*freq;

%nat response

%v(inf) = 0
%v(6)
% V(t)= V(inf) + [V(0)-V(inf)]*exp(-t/tau)
  
V6n =V_2(6)*exp(-t/tau);
V8n =V_2(8)*exp(-t/tau); 
Vxn = V6n - V8n;
 
hn = figure ();
plot (t*1000, Vxn, "r");
hold on;
plot (t*1000, V6n, "g");
hold on;
plot (t*1000, V8n, "b");
grid on
legend('Vx','V6','V8','Location','northeast')
xlabel ("t[ms]");
ylabel ("V[V]");
title ('Natural Response')
print (hn, "Natural", "-depsc");
 
%forced response
% (Vc/Vs)=1/(sqrt(1+w²*Req²*C²)) aka gain
% Phi= atan(w*Req*C) aka phase

[Vph, Vm, Vc] = nodeSolverPhasor(Data, w);


Vcm = abs(Vc);
Vcph = arg(Vc);


Vs = 1*sin(w*t);
V6f = Vm(6)*sin(w*t+Vph(6));
V8f = Vm(8)*sin(w*t+Vph(8));
Vcf = Vcm*sin(w*t+Vcph);

hf = figure ();
plot (t*1000, Vcf, "r");
hold on;
plot (t*1000, V6f, "g");
hold on;
plot (t*1000, Vs, "b");
grid on
legend('Vc','V6','Vs','Location','northeast')
xlabel ("t[ms]");
ylabel ("V[V]");
title ('Forced Response')
print (hf, "Forced", "-depsc");



%final response

V6 = V6n + V6f;
V8 = V8n + V8f;
Vx = V6 - V8;
O = 0;

%trolhice para contar com os -5ms
tt = (-stop/4):deltaT:start;
Vxt = V(6) - V(8);

h = figure ();

plot (t*1000, Vx, "r");
hold on;
plot (t*1000, V6, "g");
hold on;
plot (t*1000, Vs, "b");
hold on;
%start trolhice
plot (tt*1000, Vxt, "r");
hold on;
plot (tt*1000, V(6), "g");
hold on;
plot (tt*1000, Data(8), "b");
hold on;
plot (tt*1000, O,'k');
%end trolhice
hold on;
plot (t*1000, O, 'k');

grid on
legend('Vx','V6','Vs','Location','northeast')
xlabel ("t[ms]");
ylabel ("V[V]");
title ('Final Response')
print (h, 'FinalResponse', '-depsc');


endfunction
