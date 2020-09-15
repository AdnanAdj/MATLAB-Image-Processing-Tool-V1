function varargout = Adnan_DIP(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Adnan_DIP_OpeningFcn, ...
                   'gui_OutputFcn',  @Adnan_DIP_OutputFcn, ...
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

%______________________________________________________________________

% --- Executes just before Adnan_DIP is made visible.
function Adnan_DIP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Adnan_DIP (see VARARGIN)

% Choose default command line output for Adnan_DIP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Adnan_DIP wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%______________________________________________________________________
function setGlobalx(val)
global x
x = val;

function r = getGlobalx
global x
r = x;

 
% --- Outputs from this function are returned to the command line.
function varargout = Adnan_DIP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%______________________________________________________________________

% --- Executes on button press in btnBrowse.
function btnBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[a, b]=uigetfile({'*.*','All Files'});
img=strcat(b, a);
g=imread(img);
g=rgb2gray(g);
axes(handles.axes1)
imshow(g);
setGlobalx(img);

%______________________________________________________________________

% --- Executes on button press in BtnNegative.
function BtnNegative_Callback(hObject, eventdata, handles)
% hObject    handle to BtnNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
g=rgb2gray(img);
[m,n]=size(g);
for j=1:m;
    for k=1:n;
 f(j,k)=255-g(j,k);
  
    end
end

 axes(handles.axes2)
 imshow(f);
 
%______________________________________________________________________

% --- Executes on button press in btnLogrithmic.
function btnLogrithmic_Callback(hObject, eventdata, handles)
% hObject    handle to btnLogrithmic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
g=rgb2gray(img);
p= im2double(g);
prompt = {'Enter value of c:'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[c] = str2double(answer);  
[m,n] = size(g);
for j=1:m
    for k=1:n
      ei(j,k)=c*log(1+p(j,k));
  
    end
end
 axes(handles.axes2)
 imshow(ei);
 
%______________________________________________________________________
 

% --- Executes on button press in BtnPowerLaw.
function BtnPowerLaw_Callback(hObject, eventdata, handles)
% hObject    handle to BtnPowerLaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
g=rgb2gray(img);
p= im2double(g);
prompt = {'Enter value of c:','enter value for gamma:'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[c] = str2double(answer{1}); 
[gamma] = str2double(answer{2}); 
[m,n] = size(g);

for j=1:m
    for k=1:n
 ei(j,k)=c*p(j,k)^gamma;
  
    end
end
 axes(handles.axes2)
 imshow(ei);
 
%______________________________________________________________________ 
 
 
% --- Executes on button press in BtnBitplane.
function BtnBitplane_Callback(hObject, eventdata, handles)
% hObject    handle to BtnBitplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

img=getGlobalx;
img=imread(img);
g=rgb2gray(img);

prompt = {'Enter the Bit plane you want to extract'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[b] = str2double(answer{1}); 

if     b==1
    multiplier=1;
elseif b==2
    multiplier=2;
elseif b==3
    multiplier=4;
elseif b==4
    multiplier=8;
elseif b==5
    multiplier=26;
elseif b==6
    multiplier=32;
elseif b==7
    multiplier=64;
elseif b==8
    multiplier=128;

end
bitrec=bitget(g,b)*multiplier;

 axes(handles.axes2)
 imshow(logical(bitrec));


%______________________________________________________________________

% --- Executes on button press in BtnLaplacian.
function BtnLaplacian_Callback(hObject, eventdata, handles)
% hObject    handle to BtnLaplacian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fin=0;
img = getGlobalx;
img = imread(img);
img = im2double(img);
f=rgb2gray(img);
f = double(f);
[m,n]=size(f);
for i=2:m-1;
   for j=2:n-1;
      fin(i,j)= f(i-1,j)+f(i,j-1)+f(i,j+1)+f(i+1,j)-4*f(i,j);
      
            if  fin(i,j)>0
                fin(i,j)=0;
            else
                fin(i,j)=255;
            end
   end
end

axes(handles.axes2)
 imshow(fin);


%______________________________________________________________________
 
% --- Executes on button press in BtnLapSharp.
function BtnLapSharp_Callback(hObject, eventdata, handles)
% hObject    handle to BtnLapSharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

g=0;
fin=0;
img = getGlobalx;
img = imread(img);
img = im2double(img);
f=rgb2gray(img);
f = double(f);
[m,n]=size(f);

for i=2:m-1;
   for j=2:n-1;
      fin(i,j)=5*f(i,j)-f(i-1,j)-f(i,j-1)-f(i,j+1)-f(i+1,j);
      
   end
end
axes(handles.axes2)
 imshow(fin);

%______________________________________________________________________


% --- Executes on button press in btnSimpleAveraging.
function btnSimpleAveraging_Callback(hObject, eventdata, handles)
% hObject    handle to btnSimpleAveraging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
[m,n]=size(img);
f=[1/9,1/9,1/9;1/9,1/9,1/9;1/9,1/9,1/9]
for i=2:m-1
    for j=2:n-1
        for k=1:3
            for l=1:3
                fin(k,l)=img(i-2+k,j-2+l);
            end
        end
        sum=0;
        for k=1:3
            for l=1:3
                sum=sum+fin(k,l)*f(k,l);
            end
        end
        fimg(i-1,j-1)=sum;
    end
end
axes(handles.axes2)
 imshow(fimg);

%______________________________________________________________________
 
% --- Executes on button press in btnWeightedAveraging.
function btnWeightedAveraging_Callback(hObject, eventdata, handles)
% hObject    handle to btnWeightedAveraging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
[m,n]=size(img);
f=[1/16,2/16,1/16;2/16,4/16,2/16;1/16,2/16,1/16];
for i=2:m-1
    for j=2:n-11
        for k=1:3
            for l=1:3
                g(k,l)=img(i-2+k,j-2+l);
            end
        end
        sum=0;
        for k=1:3
            for l=1:3
                sum=sum+g(k,l)*f(k,l);
            end
        end
        fimg(i-1,j-1)=sum;
    end
end
axes(handles.axes2)
 imshow(fimg);

%______________________________________________________________________



% --- Executes on button press in BtnLapOfGaussian.
function BtnLapOfGaussian_Callback(hObject, eventdata, handles)
% hObject    handle to BtnLapOfGaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'log');

axes(handles.axes2)
 imshow(img);

%______________________________________________________________________ 

% --- Executes on button press in BtnExtEdgeRobertsNormal.
function BtnExtEdgeRobertsNormal_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgeRobertsNormal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'roberts');
axes(handles.axes2)
 imshow(img);

%______________________________________________________________________
 
% --- Executes on button press in BtnExtEdgeRobertsVertical.
function BtnExtEdgeRobertsVertical_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgeRobertsVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'roberts','vertical');
axes(handles.axes2)
 imshow(img);

%______________________________________________________________________
 
% --- Executes on button press in BtnExtEdgeRobertsHorizontal.
function BtnExtEdgeRobertsHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgeRobertsHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'roberts','horizontal');
axes(handles.axes2)
 imshow(img);

%______________________________________________________________________
 
% --- Executes on button press in BtnExtEdgePrewittHorizontal.
function BtnExtEdgePrewittHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgePrewittHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'prewitt','horizontal');
axes(handles.axes2)
 imshow(img);

%______________________________________________________________________
 
% --- Executes on button press in BtnExtEdgePrewittVertical.
function BtnExtEdgePrewittVertical_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgePrewittVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'prewitt','vertical');
axes(handles.axes2)
 imshow(img);

%______________________________________________________________________

% --- Executes on button press in BtnExtEdgeSobelNormal.
function BtnExtEdgeSobelNormal_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgeSobelNormal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'Sobel');
axes(handles.axes2)
 imshow(img);

%______________________________________________________________________

% --- Executes on button press in BtnExtEdgeSobelVertical.
function BtnExtEdgeSobelVertical_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgeSobelVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'Sobel','vertical');
axes(handles.axes2)
 imshow(img);
 
%______________________________________________________________________

% --- Executes on button press in BtnExtEdgeSobelHorizontal.
function BtnExtEdgeSobelHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgeSobelHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'Sobel','horizontal');
axes(handles.axes2)
 imshow(img);
 
%______________________________________________________________________
 
% --- Executes on button press in BtnExtEdgePrewittNormal.
function BtnExtEdgePrewittNormal_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtEdgePrewittNormal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
img=edge(img,'prewitt');
axes(handles.axes2)
 imshow(img);
 
%______________________________________________________________________

% --- Executes on button press in BtnMotionBlur.
function BtnMotionBlur_Callback(hObject, eventdata, handles)
% hObject    handle to BtnMotionBlur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
prompt = {'Enter the Length of Blur :','enter Angle Of Blur :'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[LEN] = str2double(answer{1}); 
[THETA] = str2double(answer{2}); 
PSF = fspecial('motion',LEN,THETA);
img = imfilter(img,PSF,'circular','conv');
axes(handles.axes2)
 imshow(img);

%______________________________________________________________________

% --- Executes on button press in BtnGaussianBlur.
function BtnGaussianBlur_Callback(hObject, eventdata, handles)
% hObject    handle to BtnGaussianBlur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

prompt = {'Enter value of Sigma:'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[c] = str2double(answer);  

Gblur = imgaussfilt(img, c);

axes(handles.axes2)
 imshow(Gblur);
%______________________________________________________________________

% --- Executes on button press in btnSaveResult.
function btnSaveResult_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
F = getframe(handles.axes2);
img = frame2im(F);
 
[FileName, PathName] = uiputfile('*.jpg', 'Save As');  
Name = fullfile(PathName,FileName);  
imwrite(img, Name, 'jpg');

%______________________________________________________________________

% --- Executes on button press in BtnClosing.
function BtnClosing_Callback(hObject, eventdata, handles)
% hObject    handle to BtnClosing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

prompt = {'Enter value of c:'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[c] = str2double(answer);  

%structuring element
s = strel('square',c);
dimg=imdilate(img,s);

oimg=imerode(dimg,s);
axes(handles.axes2)
 imshow(oimg);

%______________________________________________________________________
 
% --- Executes on button press in BtnOpening.
function BtnOpening_Callback(hObject, eventdata, handles)
% hObject    handle to BtnOpening (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

prompt = {'Enter value of c:'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[c] = str2double(answer);  

%structuring element
s = strel('square',c);
dimg=imerode(img,s);

oimg=imdilate(dimg,s);
axes(handles.axes2)
 imshow(oimg);

 %______________________________________________________________________
 
% --- Executes on button press in BtnDilation.
function BtnDilation_Callback(hObject, eventdata, handles)
% hObject    handle to BtnDilation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

prompt = {'Enter the Size of structuring Element:'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[c] = str2double(answer);  

%structuring element
s = strel('square',c);
fimg=imerode(img,s);
axes(handles.axes2)
 imshow(fimg);

 %______________________________________________________________________
 
% --- Executes on button press in BtnErosion.
function BtnErosion_Callback(hObject, eventdata, handles)
% hObject    handle to BtnErosion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

prompt = {'Enter value of c:'};
dlg_title = 'Input';
num_lines = 1;

answer = inputdlg(prompt,dlg_title,num_lines);
[c] = str2double(answer);  

%structuring element
s = strel('square',c);
result=imdilate(img,s);
axes(handles.axes2)
 imshow(result);

 %______________________________________________________________________

% --- Executes on button press in BtnRegionFilling.
function BtnRegionFilling_Callback(hObject, eventdata, handles)
% hObject    handle to BtnRegionFilling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
BW = imbinarize(img);
 result = imfill(BW,'holes');
axes(handles.axes2)
 imshow(result);


%______________________________________________________________________

% --- Executes on button press in BtnBoundry.
function BtnBoundry_Callback(hObject, eventdata, handles)
% hObject    handle to BtnBoundry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
%structuring element
s = strel('square',3);
result=imerode(img,s);
bound=img-result;
axes(handles.axes2)
 imshow(bound);

%______________________________________________________________________


% --- Executes on button press in btnEqualHistogram.
function btnEqualHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to btnEqualHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes2);
img = frame2im(F);
img = rgb2gray(img);
fimg=histeq(img);
axes(handles.axes2)
 imshow(fimg);
%______________________________________________________________________

% --- Executes on button press in BtnThreshold.
function BtnThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to BtnThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
level=graythresh(img);
fimg = im2bw(img,level);
axes(handles.axes2)
 imshow(fimg);

%______________________________________________________________________


% --- Executes on button press in BtnCustomThresh.
function BtnCustomThresh_Callback(hObject, eventdata, handles)
% hObject    handle to BtnCustomThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in BtnComplement.
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

prompt = {'Enter value of c:'};
dlg_title = 'Input';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines);
[T] = str2double(answer);  

fimg = im2bw(img,T/255);
axes(handles.axes2)
 imshow(fimg);

%______________________________________________________________________
function BtnComplement_Callback(hObject, eventdata, handles)
% hObject    handle to BtnComplement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes2);
img = frame2im(F);
img = rgb2gray(img);
cimg=~img;
axes(handles.axes2)
 imshow(cimg);

%______________________________________________________________________


% --- Executes on button press in BtnCopy.
function BtnCopy_Callback(hObject, eventdata, handles)
% hObject    handle to BtnCopy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);
axes(handles.axes2)
 imshow(img);
 
%______________________________________________________________________


% --- Executes on button press in BtnSobel.
function BtnSobel_Callback(hObject, eventdata, handles)
% hObject    handle to BtnSobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
A=imread(img);
B=rgb2gray(A);

C=double(B);


for i=1:size(C,1)-2
    for j=1:size(C,2)-2
      
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
     
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
      
      
         B(i,j)=abs(Gx)+abs(Gy);
         
      
    end
end
axes(handles.axes2)
imshow(B); 
 

%______________________________________________________________________


% --- Executes on button press in BtnLinesCombined.
function BtnLinesVertical_Callback(hObject, eventdata, handles)
% hObject    handle to BtnLinesCombined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 
 
img=getGlobalx;
A=imread(img);
B=rgb2gray(A);

C=double(B);
 

for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        
        Gy=(2*C(i,j+1)+2*C(i+1,j+1)+2*C(i+2,j+1))-C(i,j)-C(i+1,j)-C(i+2,j)-C(i,j+2)-C(i+1,j+2)-C(i+2,j+2);
     
        B(i,j)=abs(Gy);
   
    end
end
axes(handles.axes2)
imshow(B);
%______________________________________________________________________

% --- Executes on button press in BtnLinesCombined.
function BtnLinesCombined_Callback(hObject, eventdata, handles)
% hObject    handle to BtnLinesCombined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
A=imread(img);
B=rgb2gray(A);

C=double(B);

for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        
  
        
        Gx=(2*C(i+1,j)+2*C(i+1,j+1)+2*C(i+1,j+2))-C(i,j)-C(i,j+1)-C(i,j+2)-C(i+2,j)-C(i+2,j+1)-C(i+2,j+2);
        Gy=(2*C(i,j+1)+2*C(i+1,j+1)+2*C(i+2,j+1))-C(i,j)-C(i+1,j)-C(i+2,j)-C(i,j+2)-C(i+1,j+2)-C(i+2,j+2);
 
        B(i,j)=abs(Gx)+abs(Gy);
       
   
      
    end
end
axes(handles.axes2)
imshow(B); 
 
%______________________________________________________________________


% --- Executes on button press in BtnPlus45Degree.
function BtnPlus45Degree_Callback(hObject, eventdata, handles)
% hObject    handle to BtnPlus45Degree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

fil=[-1,-1,2;-1,2,-1;2,-1,-1];

img=imfilter(img,fil);

axes(handles.axes2)
 imshow(img);

%______________________________________________________________________

% --- Executes on button press in BtnMinus45Degree.
function BtnMinus45Degree_Callback(hObject, eventdata, handles)
% hObject    handle to BtnMinus45Degree (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

fil=[2,-1,-1;-1,2,-1;-1,-1,2];

img=imfilter(img,fil);

axes(handles.axes2)
 imshow(img);

%______________________________________________________________________


% --- Executes on button press in BtnLinesHorizontal.
function BtnLinesHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to BtnLinesHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

fil=[-1,-1,-1;2,2,2;-1,-1,-1];

img=imfilter(img,fil);

axes(handles.axes2)
 imshow(img);

 %______________________________________________________________________

% --- Executes on button press in BtnExtractPoint.
function BtnExtractPoint_Callback(hObject, eventdata, handles)
% hObject    handle to BtnExtractPoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

fil=[-1,-1,-1;-1,8,-1;-1,-1,-1];

img=imfilter(img,fil);

axes(handles.axes2)
 imshow(img);

 %______________________________________________________________________

% --- Executes on button press in BtnPointDetectionWithThresh.
function BtnPointDetectionWithThresh_Callback(hObject, eventdata, handles)
% hObject    handle to BtnPointDetectionWithThresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getGlobalx;
img=imread(img);
img=rgb2gray(img);

fil=[-1,-1,-1;-1,8,-1;-1,-1,-1];

img=imfilter(img,fil);


 
level=graythresh(img);
fimg = im2bw(img,level);
axes(handles.axes2)
 imshow(fimg);

 %______________________________________________________________________

% --- Executes on button press in BtnShowHistogram.
function BtnShowHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to BtnShowHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes2);
img = frame2im(F);
img = rgb2gray(img);

axes(handles.axes3)
 imhist(img);

 %______________________________________________________________________

% --- Executes on button press in BtnHistInput.
function BtnHistInput_Callback(hObject, eventdata, handles)
% hObject    handle to BtnHistInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes1);
img = frame2im(F);
img = rgb2gray(img);

axes(handles.axes3)
 imhist(img);

%______________________________________________________________________
%Thanx for Reviewing the Code
%______________________________________________________________________
