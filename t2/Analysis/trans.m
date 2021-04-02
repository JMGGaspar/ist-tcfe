function trans (Data, V, tau, start, stop)
 
deltaT = (stop-start)/1000
 

%nat response

%v(inf) = 0
%v(6)
% V(t)= V(inf) + [V(0)-V(inf)]*exp(-t/tau)
  
  
t = start:deltaT:stop;
V6 =V(6)*exp(-t/tau);
V8 =V(8)*exp(-t/tau); 
Vx = V6 - V8;
 
hf = figure ();
plot (t*1000, Vx, "r");
hold on;
plot (t*1000, V6, "g");
hold on;
plot (t*1000, V8, "b");
grid on
legend('Vx','V6','V8','Location','northeast')
xlabel ("t[ms]");
ylabel ("V[V]");
print (hf, "Natural", "-depsc");
  
endfunction
