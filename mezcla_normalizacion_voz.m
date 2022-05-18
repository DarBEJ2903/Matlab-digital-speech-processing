clc
clear
Fs = 8000;
nBits = 16;
nChannels = 1;
ID = -1;
recObj = audiorecorder(Fs,nBits,nChannels);
disp('Empezar a grabar');
recordblocking(recObj,5);
disp('Tèrmino la grabaciòn');
entrada2 = getaudiodata(recObj);
sound(entrada2,Fs);
figure(1);
plot(entrada);
figure(2);
plot(entrada2);

andres = entrada(8203:13502);
daniel = entrada(15942:22097);
ramirez =  entrada(23802:29551);
bejarano =  entrada(30645:35973);

juan = entrada2(5345:8940);
juan(3596:5300) = 0;
mezcla = andres + juan;
figure(3)
plot(mezcla);
sound(mezcla,Fs);
audiowrite('grabacion_1.wav',mezcla,Fs);

nombre = [ramirez;bejarano;andres;daniel];
normalizado = entrada./max(entrada);


