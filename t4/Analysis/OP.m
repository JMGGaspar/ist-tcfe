function OP(Vcc, Rb1, Rb2, Re, Rc, VbeON, BFN, Rout, VebON, BFP)

%Gain
Rb=1/(1/Rb1+1/Rb2);
Vbase = (Rb2/(Rb1+Rb2))*Vcc
Vemit = (Vbase-VbeON)
Iemit = Vemit/Re
Ibase = Iemit/(BFN+1)
Icoll = Ibase*BFN
Vcoll = Vcc - Icoll*Rc

%{
Ibase =(Vbase-VbeON)/(Rb+(1+BFN)*Re)
Icoll = Ibase*BFN
Iemit = Ibase*(1+BFN)

Vemit = Iemit*Re
Vcoll = Vcc - Icoll*Rc
%}
4

%output 
Iemit2= (Vcc- VebON- Vcoll)/Rout
Vemit2=Vcoll+VebON
   
endfunction
