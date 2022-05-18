function varargout = lab3_FFT(varargin)
% LAB3_FFT MATLAB code for lab3_FFT.fig
%      LAB3_FFT, by itself, creates a new LAB3_FFT or raises the existing
%      singleton*.
%
%      H = LAB3_FFT returns the handle to a new LAB3_FFT or the handle to
%      the existing singleton*.
%
%      LAB3_FFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB3_FFT.M with the given input arguments.
%
%      LAB3_FFT('Property','Value',...) creates a new LAB3_FFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab3_FFT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab3_FFT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab3_FFT

% Last Modified by GUIDE v2.5 30-Jan-2022 17:23:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab3_FFT_OpeningFcn, ...
                   'gui_OutputFcn',  @lab3_FFT_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before lab3_FFT is made visible.
function lab3_FFT_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

global l
l = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab3_FFT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab3_FFT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

global senal sfiltrada
senal = [];
sfiltrada = [];
varargout{1} = handles.output;

% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
%% Graba la señal de audio en un tiempo de 5 segundos
global senal Fs t

Fs = 8000;
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
plot_senal(hObject, eventdata, handles,senal,Fs);


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
global senal Fs
sound(senal,Fs);
% --------------------------------------------------------------------
function ARCHIVO_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function REC_Callback(hObject, eventdata, handles)
%% Graba el audio desde la pestaña de Archivo
grabar_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function sonar_Callback(hObject, eventdata, handles)

global senal Fs t
sound(senal,Fs)
% --------------------------------------------------------------------
function Tools_Callback(hObject, eventdata, ~)
% --------------------------------------------------------------------
function f_butter(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs)
global Fs number1  num den senal sfiltrada

if number1 == 0b00
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = buttord(Wp,Ws,Rp,Rs);    
 [num,den] = butter(n,wn,'stop');
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b11
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = buttord(Wp,Ws,Rp,Rs);
 [num,den] = butter(n,wn);
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b01
    
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = buttord(Wp,Ws,Rp,Rs);
    [num,den] = butter(n,wn,'high');
    sfiltrada = filter(num,den,senal);
elseif number1 == 0b10
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = buttord(Wp,Ws,Rp,Rs);
    [num,den] = butter(n,wn);
    sfiltrada = filter(num,den,senal);
end

function f_chevi_1(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs)
global Fs number1  num den senal sfiltrada

if number1 == 0b00
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = cheb1ord(Wp,Ws,Rp,Rs);    
 [num,den] = cheby1(n,Rp,wn,'stop');
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b11
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = cheb1ord(Wp,Ws,Rp,Rs);
 [num,den] = cheby1(n,Rp,wn);
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b01
    
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = cheb1ord(Wp,Ws,Rp,Rs);
    [num,den] = cheby1(n,Rp,wn,'high');
    sfiltrada = filter(num,den,senal);
elseif number1 == 0b10
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = cheb1ord(Wp,Ws,Rp,Rs);
    [num,den] = cheby1(n,Rp,wn);
    sfiltrada = filter(num,den,senal);
end

function f_chevi_2(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs)
global Fs number1  num den senal sfiltrada

if number1 == 0b00
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = cheb2ord(Wp,Ws,Rp,Rs);    
 [num,den] = cheby2(n,Rs,wn,'stop');
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b11
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = cheb2ord(Wp,Ws,Rp,Rs);
 [num,den] = cheby2(n,Rs,wn);
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b01
    
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = cheb2ord(Wp,Ws,Rp,Rs);
    [num,den] = cheby2(n,Rs,wn,'high');
    sfiltrada = filter(num,den,senal);
elseif number1 == 0b10
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = cheb2ord(Wp,Ws,Rp,Rs);
    [num,den] = cheby2(n,Rs,wn);
    sfiltrada = filter(num,den,senal);
end

function f_eliptico(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs)
global Fs number1  num den senal sfiltrada

if number1 == 0b00
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = ellipord(Wp,Ws,Rp,Rs);    
 [num,den] = ellip(n,Rp,Rs,wn,'stop');
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b11
    
 Wp = [2*fp1,2*fp2]./Fs;
 Ws = [2*fs1,2*fs2]./Fs;
 [n,wn] = ellipord(Wp,Ws,Rp,Rs);
 [num,den] = ellip(n,Rp,Rs,wn);
 sfiltrada = filter(num,den,senal);

elseif number1 == 0b01
    
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = ellipord(Wp,Ws,Rp,Rs);
    [num,den] = ellip(n,Rp,Rs,wn,'high');
    sfiltrada = filter(num,den,senal);
elseif number1 == 0b10
    Wp = 2*fp1/Fs;
    Ws = 2*fs1/Fs;
    [n,wn] = ellipord(Wp,Ws,Rp,Rs);
    [num,den] = ellip(n,Rp,Rs,wn);
    sfiltrada = filter(num,den,senal);
end
% --------------------------------------------------------------------

% --------------------------------------------------------------------
function load_sound_Callback(hObject, eventdata, handles)

global senal Fs
[file,path] = uigetfile('*.wav');
filname = [path,file];
[senal,Fs] = audioread(filname);
t = (0:(length(senal)-1))/Fs;
senal = senal./max(senal);
plot(handles.axes1,t,senal);
% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in Ifft.
function play2_Callback(hObject, eventdata, handles)
global Fs sfiltrada
sound(sfiltrada,Fs);
% --------------------------------------------------------------------
function plotear_Callback(hObject, eventdata, handles)
% --------------------------------------------------------------------
function freq_Callback(hObject, eventdata, handles)
%% Dibuja la señal en el dominio de la frecuencia.
global senal Fs
plot_senal(hObject, eventdata, handles,senal,Fs)
plot_senalfiltrada(hObject, eventdata, handles)
% --------------------------------------------------------------------
function tiempo_Callback(hObject, eventdata, handles)
%% Dibuja la señal en el dominio del tiempo
global senal t sfiltrada

plot(handles.axes2,t,sfiltrada);
title('Señal en dominio del tiempo')
xlabel('t (s)')
ylabel('A (v)')


plot(handles.axes1,t,senal);
title('Señal en dominio del tiempo')
xlabel('t (s)')
ylabel('A (v)')

% --- Executes on button press in filter.
function filter_Callback(hObject, eventdata, handles)
%% Filtra la señal de acuerdo a especificaciones
global number1 number2 fr H senal Fs num den l
l = 1;

if(number1==0b00 || number1==0b11) 
      [xi,yi] = ginput(4);
      fs1 = round(xi(1));
      fp1 = round(xi(2));
      fp2 = round(xi(3));
      fs2 = round(xi(4));
      
elseif(number1 == 0b01 || number1==0b10)
    
      [xi,yi] = ginput(2);
      if(number1 == 0b01)
        fs1 = round(xi(1));
        fp1 = round(xi(2));
        fp2 = [];
        fs2 = [];
      else
        fp1 = round(xi(1));
        fs1 = round(xi(2));
        fp2 = [];
        fs2 = [];
      end
else
end       
    R = inputdlg({'Atenuaciòn en banda de paso RP','Atenuaciòn en banda atenuada Rs'});
    R1 = R(1);
    R2 = R(2);
    Rp=str2double(cell2mat(R1));
    Rs = str2double(cell2mat(R2));
% filtro butterworth
if (number2==0b00)
    f_butter(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs);
% filtro chebyshev I
elseif (number2 == 0b01)
    f_chevi_1(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs);    
% filtro chebyshev II
elseif (number2 == 0b10)
     f_chevi_2(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs);
% filtro eliptico
elseif (number2 == 0b11)
    f_eliptico(hObject, eventdata, handles,fs1,fp1,fp2,fs2,Rp,Rs)
else
end
 plot_senalfiltrada(hObject, eventdata, handles)
 fr = 0:1:3800;
 H = freqz(num,den,fr,Fs);
 plot_senal(hObject, eventdata, handles,senal,Fs)
 
% --------------------------------------------------------------------
function t_filter_ButtonDownFcn(hObject, eventdata, handles)
% --- Executes when selected object is changed in t_filter.
function t_filter_SelectionChangedFcn(hObject, eventdata, handles)
%% Se determina que tipo de filtro se va aplicar a la señal

global number1 

if(hObject == handles.rechaza_banda)
    number1 = 0b00;
elseif(hObject == handles.pasa_alto)
    number1 = 0b01;
elseif(hObject == handles.pasa_bajo)
    number1 = 0b10;
elseif(hObject == handles.pasa_banda)
    number1 = 0b11;
else
    number1 = NaN;
end   
% --- Executes when selected object is changed in uibuttongroup3.
function uibuttongroup3_SelectionChangedFcn(hObject, eventdata, handles)

%% Se determina el filtro digital a aplicar (Buter,chevy,eliptic)

global number2 

if(hObject == handles.butterworth)
    number2 = 0b00;
elseif(hObject == handles.chebyshev_I)
    number2 = 0b01;
elseif(hObject == handles.chevyshev_II)
    number2 = 0b10;
elseif(hObject == handles.eliptico)
    number2 = 0b11;
else
    number2 = NaN;
end

function plot_senal(hObject, eventdata, handles,senal,Fs)
global P2 P1 f fr H l

Y = fft(senal);
L = length(senal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
hold on
if  l == 0
    cla(handles.axes1,'reset')
    yyaxis left
    axes(handles.axes1);
     plot(f,P1);
elseif l == 1
    l = 0;
    yyaxis right
    plot(fr,abs(H))
else
end
hold off


function plot_senalfiltrada(hObject, eventdata, handles)

global P2 P1 f Fs sfiltrada


Y = fft(sfiltrada);
L = length(sfiltrada);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

plot(handles.axes2,f,P1);
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
% --------------------------------------------------------------------
function filtrar_boton2_Callback(hObject, eventdata, handles)
filter_Callback(hObject, eventdata, handles);



