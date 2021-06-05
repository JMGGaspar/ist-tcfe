function [Magnitude,Fase] = HighPassFilter(C1,R1,f)
%Function that calculates the magnitude and the phase of a high-pass filter
%using the frequency and the values of the resistor and capacitor

Omega = 2*pi*f;

l=length(Omega); 
Magnitude=zeros(1,l);
Fase = zeros(1,l);

%loop that computes the values of the magnitude and phase for each
%frequency
for n = 1:l
    V=R1/(R1+1/(i*Omega(n)*C1)); %V=Vout/Vin
    Magnitude(n)=20*log10(abs(V)); %magnitude in decibels
    Fase(n)=(180/pi)*arg(V); %angle in degrees
end

%ploting of the phase graphic
hg=figure();
semilogx(f,Fase);
grid on;
title('Initial High-Pass Filter');
xlabel('f (Hz)');
ylabel('Phase (º)');
legend("Vout","location", "northwest");
print (hg, "Phase_HP", "-depsc");

%ploting of the magnitude graphic
hf=figure();
semilogx(f,Magnitude);
grid on;
hold on;
title('Initial High-Pass Filter');
xlabel('f (Hz)');
ylabel('Magnitude (dB)');
legend("Vout","location", "northwest");
print (hf, "Mag_HP", "-depsc");
