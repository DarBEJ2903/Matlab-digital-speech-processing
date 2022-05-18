clc
clear
Fs = 44100;
nBits = 16;
nChannels = 1;
recObj = audiorecorder(Fs,nBits,nChannels);
recordblocking(recObj,15);
entrada = getaudiodata(recObj);
audiowrite('barridof.wav',entrada,Fs);
[y,F] = audioread('WhatsApp Audio 2021-12-11 at 10.46.40 PM.mpeg');%Cargo el audio de mi voz
tiempo = 0:1./F:size(y,1)./F;
t = 0:1./Fs:size(entrada,1)./Fs;
subplot(2,1,1);
plot(t(2:end),entrada);
title('Señal recibida');
xlabel('tiempo');
ylabel('Amplitud');
subplot(2,1,2);
plot(tiempo(2:end),y(:,1));
title('Señal transmitida');
xlabel('tiempo');
ylabel('Amplitud');
%sound(entrada,Fs,nBits);
