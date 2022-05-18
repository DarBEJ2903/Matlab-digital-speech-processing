function varargout = guide_ecualizador(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_ecualizador_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_ecualizador_OutputFcn, ...
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


% --- Executes just before guide_ecualizador is made visible.
function guide_ecualizador_OpeningFcn(hObject, eventdata, handles, varargin)



[a,map] = imread('stop.jpg');
[r,c,d] = size(a);
x = ceil(r/30);
y = ceil(c/30);
g = a(1:x:end,1:y:end,:);
g(g==255) = 5.5*255;
set(handles.stop,'CData',g);

[a,map] = imread('grbar.jpg');
[r,c,d] = size(a);
x = ceil(r/30);
y = ceil(c/30);
g = a(1:x:end,1:y:end,:);
g(g==255) = 5.5*255;
set(handles.grabar,'CData',g);

[a,map] = imread('play.jpg');
[r,c,d] = size(a);
x = ceil(r/30);
y = ceil(c/30);
g = a(1:x:end,1:y:end,:);
g(g==255) = 5.5*255;
set(handles.star,'CData',g);



find_system('Name','sim_ecualizador'); 
open_system('sim_ecualizador'); 
set(handles.vol1,'Value',1); 
set(handles.left,'Value',1); 
set(handles.right,'Value',1); 
set(handles.freq_cien,'Value',0.5); 
set(handles.freq_250,'Value',0.5); 
set(handles.freq_500,'Value',0.5); 
set(handles.freq_1k,'Value',0.5); 
set(handles.freq_2k,'Value',0.5); 
set(handles.freq_4k,'Value',0.5); 



handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global selec_1 var_personalizado

var_personalizado = [0,0,0,0,0,0];
selec_1 = false;
set_param('sim_ecualizador/volumen','Gain',num2str(1)); 
set_param('sim_ecualizador/G_left','Gain',num2str(1)); 
set_param('sim_ecualizador/G_right','Gain',num2str(1)); 
set_param('sim_ecualizador/pasabajo','dB',num2str(0));
set_param('sim_ecualizador/pasabanda1','dB',num2str(0)); 
set_param('sim_ecualizador/pasabanda2','dB',num2str(0)); 
set_param('sim_ecualizador/pasabanda3','dB',num2str(0));
set_param('sim_ecualizador/pasabanda4','dB',num2str(0)); 
set_param('sim_ecualizador/pasaalto','dB',num2str(0)); 


% UIWAIT makes guide_ecualizador wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guide_ecualizador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in star.
function star_Callback(hObject, eventdata, handles)
%% Funcion para bonton start and pause

global selec_1



selec_1 = not(selec_1);

if(selec_1 == false)
    [a,map] = imread('play.jpg');
    [r,c,d] = size(a);
    x = ceil(r/30);
    y = ceil(c/30);
    g = a(1:x:end,1:y:end,:);
    g(g==255) = 5.5*255;
    set(handles.star,'CData',g);    
    set_param(gcs,'SimulationCommand','Pause')
elseif (selec_1 == true)   
    [a,map] = imread('pausa.jpg');
    [r,c,d] = size(a);  
    x = ceil(r/30);
    y = ceil(c/30);
    g = a(1:x:end,1:y:end,:);
    g(g==255) = 5.5*255;
    set(handles.star,'CData',g);
    set_param(gcs,'SimulationCommand','Start')
     set_param(gcs,'SimulationCommand','Continue')
else

end




% --- Executes on slider movement.
function vol1_Callback(hObject, ~, handles)

volu=get(hObject,'Value'); 
set_param('sim_ecualizador/volumen','Gain',num2str(volu)); 


% --- Executes during object creation, after setting all properties.
function vol1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vol1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
%% Funcion para el boton stop
set_param(gcs,'SimulationCommand','Stop')

function grabar_Callback(hObject, eventdata, handles)
%% Funciòn para grabar sonidos
global Fs senal
Fs= 44100;
x = inputdlg({'tiempo de grabacion'});
x1 = x(1);
t_grabacion = str2double(cell2mat(x1));
nBits = 16;
nChannels = 2;
Id = -1;
recObj = audiorecorder(Fs,nBits,nChannels);
h = msgbox('Grabando','Ecualizador');
recordblocking(recObj,t_grabacion);
delete(h);
senal = getaudiodata(recObj);
senal = senal./max(senal);
guardar_audio(hObject, eventdata, handles,senal)


function guardar_audio(hObject, eventdata, handles,senal)
global Fs

filname = ['C:\Users\Daniel Ramírez\OneDrive\Escritorio\cod_matlab2021\','audio_sim.wav'];
audiowrite(filname,senal,Fs);


% --- Executes on slider movement.
function freq_cien_Callback(hObject, eventdata, handles)
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/pasabajo','dB',num2str(volu)); 

% --- Executes during object creation, after setting all properties.
function freq_cien_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_cien (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function freq_250_Callback(hObject, eventdata, handles)
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/pasabanda1','dB',num2str(volu)); 

% --- Executes during object creation, after setting all properties.
function freq_250_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_250 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function freq_500_Callback(hObject, eventdata, handles)
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/pasabanda2','dB',num2str(volu)); 


% --- Executes during object creation, after setting all properties.
function freq_500_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_500 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function freq_1k_Callback(hObject, eventdata, handles)
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/pasabanda3','dB',num2str(volu)); 


% --- Executes during object creation, after setting all properties.
function freq_1k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_1k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function freq_2k_Callback(hObject, eventdata, handles)
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/pasabanda4','dB',num2str(volu)); 


% --- Executes during object creation, after setting all properties.
function freq_2k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_2k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function freq_4k_Callback(hObject, eventdata, handles)
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/pasaalto','dB',num2str(volu)); 


% --- Executes during object creation, after setting all properties.
function freq_4k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freq_4k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function preset_CreateFcn(hObject, eventdata, handles)



% --- Executes when selected object is changed in preset.
function preset_SelectionChangedFcn(hObject, eventdata, handles)
global pres
if(hObject == handles.rock)
    pres = 0b001;
elseif (hObject == handles.jaz)
    pres = 0b010;
elseif (hObject == handles.reggae)
    pres = 0b0011;
elseif (hObject == handles.pop)
    pres = 0b100;
elseif (hObject == handles.rap)
    pres = 0b101;
elseif (hObject == handles.personalizado)
    pres = 0b110;
else
     pres = NaN;
end


% --- Executes on button press in presets.
function presets_Callback(hObject, eventdata, handles)
global pres var_personalizado
if pres == 0b001
    set(handles.freq_cien,'Value',8); 
    set(handles.freq_250,'Value',8); 
    set(handles.freq_500,'Value',-5);  
    set(handles.freq_1k,'Value',5); 
    set(handles.freq_2k,'Value',0); 
    set(handles.freq_4k,'Value',5);
    
    set_param('sim_ecualizador/pasabajo','dB',num2str(8));
    set_param('sim_ecualizador/pasabanda1','dB',num2str(8)); 
    set_param('sim_ecualizador/pasabanda2','dB',num2str(-5)); 
    set_param('sim_ecualizador/pasabanda3','dB',num2str(5));
    set_param('sim_ecualizador/pasabanda4','dB',num2str(0)); 
    set_param('sim_ecualizador/pasaalto','dB',num2str(5)); 
    
elseif pres == 0b010
    
    set(handles.freq_cien,'Value',7); 
    set(handles.freq_250,'Value',7); 
    set(handles.freq_500,'Value',0);  
    set(handles.freq_1k,'Value',0); 
    set(handles.freq_2k,'Value',7); 
    set(handles.freq_4k,'Value',7);
    
    set_param('sim_ecualizador/pasabajo','dB',num2str(7));
    set_param('sim_ecualizador/pasabanda1','dB',num2str(7)); 
    set_param('sim_ecualizador/pasabanda2','dB',num2str(0)); 
    set_param('sim_ecualizador/pasabanda3','dB',num2str(0));
    set_param('sim_ecualizador/pasabanda4','dB',num2str(7)); 
    set_param('sim_ecualizador/pasaalto','dB',num2str(7)); 
    
elseif pres == 0b011
    
    set(handles.freq_cien,'Value',15); 
    set(handles.freq_250,'Value',15); 
    set(handles.freq_500,'Value',10);  
    set(handles.freq_1k,'Value',0); 
    set(handles.freq_2k,'Value',-10); 
    set(handles.freq_4k,'Value',-10);
    
    set_param('sim_ecualizador/pasabajo','dB',num2str(15));
    set_param('sim_ecualizador/pasabanda1','dB',num2str(15)); 
    set_param('sim_ecualizador/pasabanda2','dB',num2str(10)); 
    set_param('sim_ecualizador/pasabanda3','dB',num2str(0));
    set_param('sim_ecualizador/pasabanda4','dB',num2str(-10)); 
    set_param('sim_ecualizador/pasaalto','dB',num2str(-10)); 
    
elseif pres == 0b100
    
    set(handles.freq_cien,'Value',-10); 
    set(handles.freq_250,'Value',0); 
    set(handles.freq_500,'Value',10);  
    set(handles.freq_1k,'Value',10); 
    set(handles.freq_2k,'Value',4); 
    set(handles.freq_4k,'Value',-10);
    
    set_param('sim_ecualizador/pasabajo','dB',num2str(-10));
    set_param('sim_ecualizador/pasabanda1','dB',num2str(0)); 
    set_param('sim_ecualizador/pasabanda2','dB',num2str(10)); 
    set_param('sim_ecualizador/pasabanda3','dB',num2str(10));
    set_param('sim_ecualizador/pasabanda4','dB',num2str(4)); 
    set_param('sim_ecualizador/pasaalto','dB',num2str(-10)); 
    
elseif pres == 0b101
    
    set(handles.freq_cien,'Value',15); 
    set(handles.freq_250,'Value',12); 
    set(handles.freq_500,'Value',0);  
    set(handles.freq_1k,'Value',10); 
    set(handles.freq_2k,'Value',12); 
    set(handles.freq_4k,'Value',15);
    
    set_param('sim_ecualizador/pasabajo','dB',num2str(15));
    set_param('sim_ecualizador/pasabanda1','dB',num2str(12)); 
    set_param('sim_ecualizador/pasabanda2','dB',num2str(0)); 
    set_param('sim_ecualizador/pasabanda3','dB',num2str(10));
    set_param('sim_ecualizador/pasabanda4','dB',num2str(12)); 
    
elseif pres == 0b110
    
    var_personalizado = struct2array(load('guide_ecualizador.mat','var_personalizado'));
    
    set(handles.freq_cien,'Value',var_personalizado(1)); 
    set(handles.freq_250,'Value',var_personalizado(2)); 
    set(handles.freq_500,'Value',var_personalizado(3));  
    set(handles.freq_1k,'Value',var_personalizado(4)); 
    set(handles.freq_2k,'Value',var_personalizado(5)); 
    set(handles.freq_4k,'Value',var_personalizado(6));
    
    set_param('sim_ecualizador/pasabajo','dB',num2str(var_personalizado(1)));
    set_param('sim_ecualizador/pasabanda1','dB',num2str(var_personalizado(2))); 
    set_param('sim_ecualizador/pasabanda2','dB',num2str(var_personalizado(3))); 
    set_param('sim_ecualizador/pasabanda3','dB',num2str(var_personalizado(4)));
    set_param('sim_ecualizador/pasabanda4','dB',num2str(var_personalizado(5))); 
    set_param('sim_ecualizador/pasaalto','dB',num2str(var_personalizado(6))); 
  
    
    
else
end



% --- Executes on slider movement.
function left_Callback(hObject, eventdata, handles)
%% Paneo left
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/G_left','Gain',num2str(volu)); 


% --- Executes during object creation, after setting all properties.
function left_CreateFcn(hObject, eventdata, handles)
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function right_Callback(hObject, eventdata, handles)
volu=get(hObject,'Value'); 
set_param('sim_ecualizador/G_right','Gain',num2str(volu)); 

% --- Executes during object creation, after setting all properties.
function right_CreateFcn(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function ARCHIVO_Callback(hObject, eventdata, handles)
% hObject    handle to ARCHIVO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function guardar_preset_Callback(hObject, eventdata, handles)
global var_personalizado

var_personalizado(1) =  get(handles.freq_cien,'Value'); 
var_personalizado(2) =  get(handles.freq_250,'Value'); 
var_personalizado(3) =  get(handles.freq_500,'Value'); 
var_personalizado(4) =  get(handles.freq_1k,'Value'); 
var_personalizado(5) =  get(handles.freq_2k,'Value'); 
var_personalizado(6) =  get(handles.freq_4k,'Value'); 
save('guide_ecualizador','var_personalizado');


             




% --------------------------------------------------------------------
function importar_Callback(hObject, eventdata, handles)
global senal Fs

[file,path] = uigetfile('*.wav');
filname = [path,file];
[senal,Fs] = audioread(filname);
senal_1 = [senal,senal];
guardar_audio(hObject, eventdata, handles,senal_1)


function eventhandle= localAddEventListener
eventhandle{1}=add_exec_event_listener('sim_ecualizador/G_left','PostOutputs',@localEventListener)
fprintf('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!listener!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')

function localEventListener(block, eventdata)
hFigure = sample_gui();
handles = guidata(hFigure);

%disp(‘Event has occured’)
global ph;

simTime = block.CurrentTime;
simData = block.OutputPort(1).Data;
xData = get(ph(1),'XData');
yData = get(ph(1),'YData');
n=20000;
if length(xData)<= n
xData=[xData simTime];
yData=[yData simData];
else
xData=[xData(2:end) simTime];
yData=[yData(2:end) simData];
end
