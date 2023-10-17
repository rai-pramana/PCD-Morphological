% Kelas : Pengolahan Citra Digital - C
% Judul : Program Operasi Morphological PCD

% Nama Anggota Kelompok F:
% 1. I Kadek Rai Pramana                (2105551094)
% 2. Ni Putu Adnya Puspita Dewi         (2105551099)
% 3. Gusti Ngurah Satya Bagus Partama   (2105551100)
% 4. Dyah Putri Maheswari               (2105551102)


function varargout = morphological(varargin)
    % MORPHOLOGICAL MATLAB code for morphological.fig
    %      MORPHOLOGICAL, by itself, creates a new MORPHOLOGICAL or raises the existing
    %      singleton*.
    %
    %      H = MORPHOLOGICAL returns the handle to a new MORPHOLOGICAL or the handle to
    %      the existing singleton*.
    %
    %      MORPHOLOGICAL('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in MORPHOLOGICAL.M with the given input arguments.
    %
    %      MORPHOLOGICAL('Property','Value',...) creates a new MORPHOLOGICAL or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before morphological_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to morphological_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help morphological

    % Last Modified by GUIDE v2.5 05-Dec-2022 16:00:38

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @morphological_OpeningFcn, ...
                       'gui_OutputFcn',  @morphological_OutputFcn, ...
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


% --- Executes just before morphological is made visible.
function morphological_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to morphological (see VARARGIN)

    % Choose default command line output for morphological
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

% UIWAIT makes morphological wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = morphological_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in uploadFoto.
function uploadFoto_Callback(hObject, eventdata, handles)
    % hObject    handle to uploadFoto (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % buka file dialog, dan dapatkan filename & pathname
    [filename, pathname] = uigetfile('*.*', 'Select Image');
    if isequal(filename,0) || isequal(pathname,0)
        % jika user menekan cancel
        disp('User Menekan Cancel');
    else
        % jika user menginput gambar
        % clear axes; cla(axesname) -> untuk clear axes tertentu
        cla;
        
        % gabungkan path dan nama file foto
        filename=strcat(pathname,filename);
        
        % buka file foto dengan path dan nama file yang diinput user
        foto=imread(filename);
        
        % konversikan foto menjadi grayscale
        fotoGrayscale = im2gray(foto);
        
        % konversikan foto menjadi biner
        % not berfungsi untuk menegasikan foto biner
        fotoBW = not(imbinarize(fotoGrayscale));

        % tampilkan foto original ke axes1 (kiri)
        axes(handles.axes1);
        imshow(foto);

        % tampilkan foto biner ke axes2 (tengah)
        axes(handles.axes2);
        imshow(fotoBW);
        
        % simpan fotoBW di dalam handles
        handles.fotoBW = fotoBW;

        % Update handles structure
        guidata(hObject, handles);
    end


% --- Executes on button press in simpanFoto.
function simpanFoto_Callback(hObject, eventdata, handles)
    % hObject    handle to simpanFoto (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % dapatkan nama file yang akan di-save
    [filename,user_canceled] = imsave;
    
    % save file
    imwrite(handles.fotoHasil, filename);

    
% --- Executes on button press in dilasi.
function dilasi_Callback(hObject, eventdata, handles)
    % hObject    handle to dilasi (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    %disp(handles.rangeStrel);
    %disp(handles.namaStrel);
    
    % memproduksi SE (Struktur Elemen) berdasarkan inputan user
    handles.SE = strel(handles.namaStrel,handles.rangeStrel);
    
    % dapatkan foto biner dari handles
    fotoDilasi = handles.fotoBW;
    
    % proses dilasi
    pFotoDilate = imdilate(fotoDilasi, handles.SE);
    
    % tampilkan foto hasil ke axes3 (kanan)
    axes(handles.axes3);
    imshow(pFotoDilate);
    
    handles.fotoHasil = pFotoDilate;
    
    % Update handles structure
    guidata(hObject, handles);

    
% --- Executes on button press in erosi.
function erosi_Callback(hObject, eventdata, handles)
    % hObject    handle to erosi (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % memproduksi SE (Struktur Elemen) berdasarkan inputan user
    handles.SE = strel(handles.namaStrel,handles.rangeStrel);
    
    % dapatkan foto biner dari handles
    fotoErosi = handles.fotoBW;
    
    % proses erosi
    pFotoErosi = imerode(fotoErosi, handles.SE);
    
    % tampilkan foto hasil ke axes3 (kanan)
    axes(handles.axes3);
    imshow(pFotoErosi);
    
    % simpan foto hasil di dalam handles
    handles.fotoHasil = pFotoErosi;
    
    % Update handles structure
    guidata(hObject, handles);

    
% --- Executes on button press in opening.
function opening_Callback(hObject, eventdata, handles)
    % hObject    handle to opening (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % memproduksi SE (Struktur Elemen) berdasarkan inputan user
    handles.SE = strel(handles.namaStrel,handles.rangeStrel);
    
    % dapatkan foto biner dari handles
    fotoOpening = handles.fotoBW;
    
    % proses opening (erosi kemudian dilasi)
    pFotoOpening = imdilate(imerode(fotoOpening, handles.SE), handles.SE);
    
    % tampilkan foto hasil ke axes3 (kanan)
    axes(handles.axes3);
    imshow(pFotoOpening);
    
    % simpan foto hasil di dalam handles
    handles.fotoHasil = pFotoOpening;
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in closing.
function closing_Callback(hObject, eventdata, handles)
    % hObject    handle to closing (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % memproduksi SE (Struktur Elemen) berdasarkan inputan user
    handles.SE = strel(handles.namaStrel,handles.rangeStrel);
    
    % dapatkan foto biner dari handles
    fotoClosing = handles.fotoBW;
    
    % proses closing (dilasi kemudian erosi)
    pFotoClosing = imerode(imdilate(fotoClosing, handles.SE), handles.SE);
    
    % tampilkan foto hasil ke axes3 (kanan)
    axes(handles.axes3);
    imshow(pFotoClosing);
    
    % simpan foto hasil di dalam handles
    handles.fotoHasil = pFotoClosing;
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in thinning.
function thinning_Callback(hObject, eventdata, handles)
    % hObject    handle to thinning (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % dapatkan foto biner dari handles
    fotoThinning = handles.fotoBW;
    
    % proses thinning
    pFotoThinning = bwmorph(fotoThinning,'thin',Inf);
    
    % tampilkan foto hasil ke axes3 (kanan)
    axes(handles.axes3);
    imshow(pFotoThinning);
    
    % simpan foto hasil di dalam handles
    handles.fotoHasil = pFotoThinning;
    
    % Update handles structure
    guidata(hObject, handles);

    
% --- Executes on button press in thickening.
function thickening_Callback(hObject, eventdata, handles)
    % hObject    handle to thickening (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % dapatkan foto biner dari handles
    fotoThickening = handles.fotoBW;
    
    % proses thickening
    pFotoThickening = bwmorph(fotoThickening,'thicken',handles.rangeStrel);
    
    % tampilkan foto hasil ke axes3 (kanan)
    axes(handles.axes3);
    imshow(pFotoThickening);
    
    % simpan foto hasil di dalam handles
    handles.fotoHasil = pFotoThickening;
    
    % Update handles structure
    guidata(hObject, handles);


function inputStrel_Callback(hObject, eventdata, handles)
    % hObject    handle to inputStrel (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of inputStrel as text
    %        str2double(get(hObject,'String')) returns contents of inputStrel as a double
    %        jika strel adalah octagon -> rangeStrel harus merupakan kelipatan tak negatif dari 3.
    handles.rangeStrel = str2double(get(hObject,'String'));
    
    % Update handles structure
    guidata(hObject, handles);
    

% --- Executes during object creation, after setting all properties.
function inputStrel_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to inputStrel (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes when selected object is changed in strelRadioGroup.
function strelRadioGroup_SelectionChangedFcn(hObject, eventdata, handles)
    % hObject    handle to the selected object in strelRadioGroup 
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % dapatkan dan cek nilai radio strel
    if handles.radioDisk.Value == 1
        handles.namaStrel = "disk";
    elseif handles.radioDiamond.Value == 1
        handles.namaStrel = "diamond";
    elseif handles.radioSquare.Value == 1
        handles.namaStrel = "square";
    elseif handles.radioOctagon.Value == 1
        handles.namaStrel = "octagon";
    end
    
    % Update handles structure
    guidata(hObject, handles);

    
