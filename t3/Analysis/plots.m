function plots(n,f,A,Periods, Von)

format long
  
T = 1/f;
w= 2*pi*f;

t = T:(T/100):((Periods+1)*T);

Vin = A*sin(w*t);
Vac = Vin/n;


for i = 1:length(Vac)
  if Vac(i) <= Von
    Vret(i) = (-Vac(i)-Von);
endif

  if Vac(i) >= Von
    Vret(i) = (Vac(i)-Von);
endif   
endfor





hn = figure ();
plot (t*1000, Vret, "r");
hold on;
plot (t*1000, Vac, "g");
grid on
legend('Vin','Vac','Location','northeast')
xlabel ("t[ms]");
ylabel ("V[V]");
title ('Initial input')
print (hn, "Initial", "-depsc");
  
endfunction
