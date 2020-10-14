function varargout = MainView(varargin)
% MAINVIEW MATLAB code for MainView.fig

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainView_OpeningFcn, ...
                   'gui_OutputFcn',  @MainView_OutputFcn, ...
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


% --- Executes just before MainView is made visible.
function MainView_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainView (see VARARGIN)

% Choose default command line output for MainView
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainView wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainView_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('Images\Mainviewicon.PNG'));
javaFrame.setMaximized(true);
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cd Dataset
[fn, pn]=uigetfile('*.jpg;*.bmp;*.tif;*.gif;*.png','Pick an Image File');
cd ..
I= imread([pn,fn]);
imshow(I,'parent',handles.axes1);
title('\fontsize{12} \bf Original Image','FontName','Latha','color','k','parent',handles.axes1);
handles.fname=fn;
I=imresize(I,[250 350]);
handles.imgs = I;
setappdata(0,'imgpn',pn);
setappdata(0,'imgfn',fn);
setappdata(0,'img',I);
imwrite(I,'Process_Image\Original.jpg','jpg');
imwrite(I,'Process_Image\input.tif','tif');
imwrite(I,'Test.jpg','jpg');
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = handles.imgs;
a = getappdata(0,'img');
preprocess(I);
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = imread('Test1.jpg');
k=medfilt2(I);
figure,imshow(k);
handles.i2 = k;
title('\fontsize{12} \bf Median Filtering Image','FontName','Latha','color','k');
guidata(hObject,handles);
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.i2;
fuzzycmeans(img);
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.i2;
CAlgo(img);
guidata(hObject,handles);
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = handles.i2;
acs = pca(img);
acs0 = svm(img);
acs1 = test_CNN(img);
gra(acs,acs0,acs1);
guidata(hObject,handles);
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
