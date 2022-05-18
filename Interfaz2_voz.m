function varargout = Interfaz2_voz(varargin)


% INTERFAZ2_VOZ MATLAB code for Interfaz2_voz.fig
%      INTERFAZ2_VOZ, by itself, creates a new INTERFAZ2_VOZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ2_VOZ returns the handle to a new INTERFAZ2_VOZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ2_VOZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ2_VOZ.M with the given input arguments.
%
%      INTERFAZ2_VOZ('Property','Value',...) creates a new INTERFAZ2_VOZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interfaz2_voz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interfaz2_voz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interfaz2_voz

% Last Modified by GUIDE v2.5 01-Dec-2021 02:12:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interfaz2_voz_OpeningFcn, ...
                   'gui_OutputFcn',  @Interfaz2_voz_OutputFcn, ...
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


% --- Executes just before Interfaz2_voz is made visible.
function Interfaz2_voz_OpeningFcn(hObject, eventdata, handles, varargin)

[a,map] = imread('grbar.jpg');
[r,c,d] = size(a);
x = ceil(r/30);
y = ceil(c/30);
g = a(1:x:end,1:y:end,:);
g(g==255) = 5.5*255;
set(handles.pushbutton1,'CData',g);
set(handles.grabar2,'CData',g);


[a,map] = imread('play.jpg');
[r,c,d] = size(a);
x = ceil(r/30);
y = ceil(c/30);
g = a(1:x:end,1:y:end,:);
g(g==255) = 5.5*255;
set(handles.play,'CData',g);
set(handles.play3,'CData',g);
set(handles.play4,'CData',g);


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global  senal xi yi  salida
salida = [];
senal = [];
xi = 0;
yi = 0;


% UIWAIT makes Interfaz2_voz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interfaz2_voz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%global salida senal xi yi
%salida = [];
%senal = [];
%xi = 0;
%yi = 0;


function pushbutton1_Callback(hObject, eventdata, handles)
global senal Fs;
x = inputdlg({'frecuencia de muestreo','tiempo de grabacion'});
x1 = x(1);
x2 = x(2);
Fs=str2double(cell2mat(x1));
t_grabacion = str2double(cell2mat(x2));
nBits = 16;
nChannels = 1;
Id = -1;
recObj = audiorecorder(Fs,nBits,nChannels);
recordblocking(recObj,t_grabacion);
senal = getaudiodata(recObj);
senal = senal./max(senal);
t = (0:(length(senal)-1))/Fs;
plot(handles.fig1,t,senal);





% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
global senal Fs;
sound(senal,Fs);


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
grid on;


% --------------------------------------------------------------------
function archivo_Callback(hObject, eventdata, handles)
% hObject    handle to archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function grabar_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function guardar_Callback(hObject, eventdata, handles)
global salida Fs  Fs2 p;
filter = {'*.wav'};
[file, path] = uiputfile(filter);
filname = [path,file];
if p == 0
    audiowrite(filname,salida,Fs);
else
    audiowrite(filname,salida,Fs2);
end
    


% hObject    handle to guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function herramientas_Callback(hObject, eventdata, handles)
% hObject    handle to herramientas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
global senal Fs t salida;
[xi,yi] = ginput(2);
x1 = round(xi(1).*Fs);
x2 = round(xi(2).*Fs);
salida = senal(x1:x2);
t = (0:length(salida)-1)./Fs;
plot(handles.fig2,t,salida);



% --------------------------------------------------------------------


% --- Executes on button press in play3.
function play3_Callback(hObject, ~, handles)
global grab_2 Fs2
sound(grab_2,Fs2);


% --- Executes on button press in grabar2.
function grabar2_Callback(hObject, eventdata, handles)
global grab_2 Fs2
x = inputdlg({'frecuencia de muestreo','tiempo de grabacion'});
x1 = x(1);
x2 = x(2);
Fs2=str2double(cell2mat(x1));
t_grabacion = str2double(cell2mat(x2));
nBits = 16;
nChannels = 1;
Id = -1;
recObj = audiorecorder(Fs2,nBits,nChannels);
recordblocking(recObj,t_grabacion);
grab_2 = getaudiodata(recObj);
grab_2 = grab_2./max(grab_2);
t = (0:(length(grab_2)-1))/Fs2;
plot(handles.axes3,t,grab_2);


% --- Executes on button press in play3.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to play3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in play4.
function play4_Callback(hObject, eventdata, ~)
global Fs salida p Fs2
if p == 1
    sound(salida,Fs2);
else
    sound(salida,Fs);
end


% --------------------------------------------------------------------
function grab_aud1_Callback(hObject, ~, handles)
global senal Fs
x = inputdlg({'frecuencia de muestreo','tiempo de grabacion'});
x1 = x(1);
x2 = x(2);
Fs=str2double(cell2mat(x1));
t_grabacion = str2double(cell2mat(x2));
nBits = 16;
nChannels = 1;
Id = -1;
recObj = audiorecorder(Fs,nBits,nChannels);
recordblocking(recObj,t_grabacion);
senal = getaudiodata(recObj);
senal = senal./max(senal);
t = (0:(length(senal)-1))/Fs;
plot(handles.fig1,t,senal);



% --------------------------------------------------------------------
function grab_aud2_Callback(hObject, eventdata, handles)
% hObject    handle to grab_aud2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grab_2 Fs2
x = inputdlg({'frecuencia de muestreo','tiempo de grabacion'});
x1 = x(1);
x2 = x(2);
Fs2=str2double(cell2mat(x1));
t_grabacion = str2double(cell2mat(x2));
nBits = 16;
nChannels = 1;
Id = -1;
recObj = audiorecorder(Fs2,nBits,nChannels);
recordblocking(recObj,t_grabacion);
grab_2 = getaudiodata(recObj);
grab_2 = grab_2./max(grab_2);
t = (0:(length(grab_2)-1))/Fs2;
plot(handles.axes3,t,grab_2);


% --------------------------------------------------------------------
function import_Callback(hObject, eventdata, handles)
% hObject    handle to import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function imp_aud_Callback(hObject, eventdata, handles)

global senal Fs
[file,path] = uigetfile('*.wav');
filname = [path,file];
[senal,Fs] = audioread(filname);
t = (0:(length(senal)-1))/Fs;
senal = senal./max(senal);
plot(handles.fig1,t,senal);

% --------------------------------------------------------------------
function imp_aud2_Callback(hObject, eventdata, handles)

global grab_2 Fs2
[file,path] = uigetfile('*.wav');
filname = [path,file];
[grab_2,Fs2] = audioread(filname);
t = (0:(length(grab_2)-1))/Fs2;
grab_2 = grab_2./max(grab_2);
plot(handles.axes3,t,grab_2);


% --------------------------------------------------------------------
function selec_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function sel_graf1_Callback(hObject, eventdata, handles)

axes(handles.axes3);
axis off;

axes(handles.fig1);
axis on;
global Fs senal salida xi yi p

p = 0;
[xi,yi] = ginput(2);
x1 = round(xi(1).*Fs);
x2 = round(xi(2).*Fs);
corte = senal(x1:x2);
sound(corte,Fs);
ans=questdlg('¿Desea continuar?','VENTANA DE VERIFICACIÒN','Si','No','No'); 
if strcmp(ans,'No') 
    clear
    clc
 return; 
elseif strcmp(ans,'Si')
        ans2 = questdlg('¿Que desea hacer?','ventana de acciòn', 'PEGAR' ,'MEZCLAR','INSERTAR','INSERTAR'); 
        if strcmp(ans2,'PEGAR')
            [xi,yi] = ginput(1);
            x3 = round(xi(1).*Fs);
            salida(x3:x3+length(corte)-1) = corte;
            t1 = (0:length(salida)-1)/Fs;
            plot(handles.fig2,t1,salida);
        elseif strcmp(ans2,'MEZCLAR')
            [xi,yi] = ginput(1);
            x3 = round(xi(1).*Fs); 
            tam1 = length(corte);
            if length(salida) == 0
                salida(x3:x3+length(corte)-1) = corte;
                t1 = (0:length(salida)-1)/Fs;
                plot(handles.fig2,t1,salida);
            else
                salida(x3:x3+length(corte)-1) = corte + senal(x3:x3+length(corte)-1);
                t1 = (0:length(salida)-1)/Fs;
                plot(handles.fig2,t1,salida);
            end
        elseif strcmp(ans2,'INSERTAR')
            [xi,yi] = ginput(1);
            x3 = round(xi(1).*Fs); 
            tam1 = length(corte);
            if length(salida)==0
               salida(x3:x3+length(corte)-1) = corte;
                t1 = (0:length(salida)-1)/Fs;
                plot(handles.fig2,t1,salida);
                
            else
                a = salida(1:x3);
                b = corte';
                c = salida(x3:end);
                salida = [a,b,c];
                t1 = (0:length(salida)-1)/Fs;
                plot(handles.fig2,t1,salida);
            end
                
           
        end
    
end


% --------------------------------------------------------------------
function sel_graf2_Callback(~, ~, handles)

axes(handles.fig1);
axis off;
axes(handles.axes3);
axis on;
global Fs2 grab_2 xi yi p salida
p = 1;
[xi,yi] = ginput(2);
x1 = round(xi(1).*Fs2);
x2 = round(xi(2).*Fs2);
corte = grab_2(x1:x2);
sound(corte,Fs2);
ans=questdlg('¿Desea continuar?','VENTANA DE VERIFICACIÒN','Si','No','No'); 
if strcmp(ans,'No') 
    clear
    clc
 return; 
elseif strcmp(ans,'Si')
        ans2 = questdlg('¿Que desea hacer?','ventana de acciòn', 'PEGAR' ,'MEZCLAR','INSERTAR','INSERTAR'); 
        if strcmp(ans2,'PEGAR')
            [xi,yi] = ginput(1);
            x3 = round(xi(1).*Fs2);
            salida(x3:x3+length(corte)-1) = corte;
            t1 = (0:length(salida)-1)/Fs2;
            plot(handles.fig2,t1,salida);
        elseif strcmp(ans2,'MEZCLAR')
            [xi,yi] = ginput(1);
            x3 = round(xi(1).*Fs2); 
            tam1 = length(corte);
            if length(salida) == 0
                salida(x3:x3+length(corte)-1) = corte;
                t1 = (0:length(salida)-1)/Fs2;
                plot(handles.fig2,t1,salida);
            else
                salida(x3:x3+length(corte)-1) = corte + grab_2(x3:x3+length(corte)-1);
                t1 = (0:length(salida)-1)/Fs2;
                plot(handles.fig2,t1,salida);
            end
        elseif strcmp(ans2,'INSERTAR')
            [xi,yi] = ginput(1);
            x3 = round(xi(1).*Fs2); 
            tam1 = length(corte);
            if length(salida)==0
               salida(x3:x3+length(corte)-1) = corte;
                t1 = (0:length(salida)-1)/Fs2;
                plot(handles.fig2,t1,salida);
                
            else
                a = salida(1:x3);
                b = corte';
                c = salida(x3:end);
                salida = [a,b,c];
                t1 = (0:length(salida)-1)/Fs2;
                plot(handles.fig2,t1,salida);
            end
                
           
        end
    
end
