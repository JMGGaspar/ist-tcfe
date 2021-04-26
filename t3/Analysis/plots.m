function plots(n,f,Ain,Periods, Von, R, C)

format long
  
T = 1/f;
w= 2*pi*f;
incr = 100


R = R*1e-3
C = C*1e-6

t = T:(T/incr):((Periods+1)*T);

Vin = Ain*sin(w*t);
Vac = Vin/n;
A=Ain/n


for i = 1:length(Vac)
  if Vac(i) <= Von
    Vret(i) = (-Vac(i)-Von);
endif

  if Vac(i) >= Von
    Vret(i) = (Vac(i)-Von);
endif   
endfor


%-----------------------------------------------------
Venv = zeros(1, length(t));

tOFF = T+T/3

vRipple = A*sin(w*tOFF)*exp(-(t-tOFF)/(R*C))-Von;


for i=1:(incr/4)
  if vRipple(i+(incr/2)) > Vret(i)
    Venv(i)= vRipple(i+(incr/2));
  else
    Venv(i) = Vret(i);
endif
endfor
 
for i = 0:(Periods*2-2)
  for i2 = (incr/4):(incr*(3/4))
    inst = i2+(incr*i/2);
    
    if t(i2) < (tOFF)
    Venv(inst) = Vret(i2);
    
    elseif vRipple(i2) > Vret(i2)
    Venv(inst) = vRipple(i2);
    
    else
    Venv(inst) = Vret(i2);    
endif
endfor
endfor

for i=1:(incr/4)
inst = i+(incr*(Periods-0.25));
  if t(inst) < (tOFF+(Periods-0.5)*T)
    Venv(inst) = Vret(inst);
    
  else
    Venv(inst) = vRipple(i+incr/4);
    
    
endif
endfor


%-----------------------------------------------------


hn = figure ();
plot (t*1000, vRipple, "r");
hold on;
plot (t*1000, Vac, "g");
hold on;
plot (t*1000, Venv, "b");
grid on
legend('Vac', 'Venv','Location','southwest')
xlabel ("t[ms]");
ylabel ("V[V]");
title ('Initial input')
print (hn, "Initial", "-depsc");
  
endfunction
