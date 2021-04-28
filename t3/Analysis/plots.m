function plots(n, f, Ain, Periods, Von, R1, C1, R2, Rd, nD)

format long
  
T = 1/f;
w= 2*pi*f;
incr = 100


R = R1*1e3
C = C1*1e-6
R2 = R2*1e3

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


tOFF = T + Toff_solver(f, A, C, R, Von)

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

%start trolhice
Venv(length(Venv))=Venv(length(Venv)-1)
%End trolhice
%This  trolhice was to no fuck up the average, since the last value is 0

%Define the voltage out
Von_t = nD*Von;
Rd_t = Rd*nD

Vout = Von_t + Venv*(Rd_t/(Rd_t+R2));

vRipple = max(Vout)-min(Vout)
Vmean = mean(Vout)
avrError =  abs(Vmean-12)

%-----------------------------------------------------

hn = figure ();
plot (t*1000, Vout, "r");
hold on;
plot (t*1000, Vac, "g");
hold on;
plot (t*1000, Venv, "b");
grid on
legend('Vout', 'Vac', 'Venv','Location','southwest')
xlabel ("t[ms]");
ylabel ("V[V]");
title ('AC/DC converter')
print (hn, "ACDC_converter", "-depsc");
  
  
h2 = figure ();
plot (t*1000, Vout - 12, "b");
hold on;
plot (t*1000, avrError, "g");
hold on;
ylim([avrError-vRipple, avrError+vRipple])
grid on
legend('Vout-12', 'AverageValue-12','Location','southwest')
xlabel ("t[ms]");
ylabel ("V[V]");
title ('Ripple Close up')
print (h2, "Ripple", "-depsc");
endfunction
