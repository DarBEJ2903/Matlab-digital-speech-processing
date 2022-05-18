clc
clear all

Fs = 44100;
Ts = 1./Fs;
nBits = 16;
nChannels = 1;
ID = -1;
recObj = audiorecorder(Fs,nBits,nChannels);
disp('Empezar a grabar');
recordblocking(recObj,5);
disp('Tèrmino la grabaciòn');
senal = getaudiodata(recObj);
t = (0:length(senal)-1)/Fs;
L = length(senal);

Y = fft(senal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure(1)
plot(t,senal)
figure(2)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')





