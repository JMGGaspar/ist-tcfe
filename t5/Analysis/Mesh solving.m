pkg load symbolic

syms Ze
syms Vb
syms Vce
syms Rpi
syms Ro 
syms Gm
syms Rc
syms Rpi2
syms Ro2
syms gm2
syms Re2
syms Vc1

I = vpa (1.0)
O = vpa (0.0)

A= [Ze+Rpi    O,   Ze      ;...
    Ze    ,  -Ro,  Ro+Ze+Rc;...
    Rpi*Gm,  -I,   O       ];

B= [Vb;O;O];

C = A\B

Vout= -C(3)*Rc



A2= [Re2+Rpi2    O,   Re2 ,O ;...
     Re2    ,  -Ro2,  Ro2 ,O  ;...
     Rpi2*gm2,  -I,   O   ,O  ;...
     Re2     , O  ,  Re2, -I];

B2= [Vc1;O;O;O];

C2 = A2\B2

Vout2= (C2(4))