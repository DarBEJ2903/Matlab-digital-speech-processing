function varargout = interfaz1(varargin)
% INTERFAZ1 MATLAB code for interfaz1.fig
%      INTERFAZ1, by itself, creates a new INTERFAZ1 or raises the existing
%      singleton*.
%
%      H = INTERFAZ1 returns the handle to a new INTERFAZ1 or the handle to
%      the existing singleton*.
%
%      INTERFAZ1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ1.M with the given input arguments.
%
%      INTERFAZ1('Property','Value',...) creates a new INTERFAZ1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaz1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaz1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaz1

% Last Modified by GUIDE v2.5 03-Nov-2021 19:41:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaz1_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaz1_OutputFcn, ...
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


% --- Executes just before interfaz1 is made visible.
function interfaz1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaz1 (see VARARGIN)

% Choose default command line output for interfaz1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interfaz1 wait for user response (see UIRESUME)
% uiwait(handles.uno);


% --- Outputs from this function are returned to the command line.
function varargout = interfaz1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in uno.
function uno_Callback(hObject, eventdata, handles)
% hObject    handle to uno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uno


% --- Executes on button press in dos.
function dos_Callback(hObject, eventdata, handles)
% hObject    handle to dos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dos


% --- Executes on button press in tres.
function tres_Callback(hObject, eventdata, handles)
% hObject    handle to tres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tres


% --- Executes on button press in cuatro.
function cuatro_Callback(hObject, eventdata, handles)
% hObject    handle to cuatro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cuatro


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, ~, handles)
while(1)
    
if hObject == handles.uno
    set(handles.SALIDA,'String','UNO');
elseif hObject == handles.dos
    set(handles.SALIDA,'String','DOS');
elseif hObject == handles.tres
    set(handles.SALIDA,'String','TRES');
else
    set(handles.SALIDA,'String','CUATRO');
end 
end
    





