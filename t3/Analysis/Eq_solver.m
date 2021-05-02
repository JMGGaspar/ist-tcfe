function Vreg = Eq_solver(Vin, R2, nD)
Is = 1e-14;
Vt = 0.025;

func = @(v) v + R2*Is*(exp(v/(nD*Vt))-1)-Vin;

Vreg = fsolve(func,0);
endfunction