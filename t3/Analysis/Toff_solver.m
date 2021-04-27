function Toff_Sin = Toff_solver(f, A, C, R, Von)

format long

w = pi*2*f;
T = 1/f;

func = @(t)  ((A*cos(w*t)-Von)/(R) - (C*A*w*sin(w*t)));
%Toff_Ideal = 1/w * atan(1/(w*R*C));

x0=0;
Toff_Cos = fsolve(func,x0);

Toff_Sin = Toff_Cos + T/4
end