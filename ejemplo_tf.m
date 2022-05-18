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
[fx,a] = fourier(senal,Fs);