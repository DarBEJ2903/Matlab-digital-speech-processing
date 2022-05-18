clc
clear
Fs2 =500;
[y,Fs2] = audioread('nombreU.wav'); %Cargo el audio de mi voz

%Fs2 = 2000;
%sound(y,Fs2)

L=length(y);
NFFT=2^nextpow2(L);
Y=fft(y,NFFT)/L;
f=(44100/2)*linspace(0,1,NFFT/2+1);

figure(1)
subplot(3,1,1)
plot(y,'linewidth',2);
title('Original')
subplot(3,1,2)
plot(f,2*abs(Y(1:NFFT/2+1)),'linewidth',2);
title('Original en frecuenia 1kHz')
subplot(3,1,3)
stem(y,'linewidth',2);
title('Señal en tiempo discreto')


