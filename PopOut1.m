%%% START of PopOut1.m code
% ------------------------------------------------------------------------------------------------------------

function varargout = PopOut1(varargin)
% POPOUT1 MATLAB code for PopOut1.fig
%      POPOUT1, by itself, creates a new POPOUT1 or raises the existing
%      singleton*.
%
%      H = POPOUT1 returns the handle to a new POPOUT1 or the handle to
%      the existing singleton*.
%
%      POPOUT1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POPOUT1.M with the given input arguments.
%
%      POPOUT1('Property','Value',...) creates a new POPOUT1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PopOut1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PopOut1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PopOut1

% Last Modified by GUIDE v2.5 06-Aug-2019 09:41:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PopOut1_OpeningFcn, ...
                   'gui_OutputFcn',  @PopOut1_OutputFcn, ...
                   'gui_LayoutFcn',  @PopOut1_LayoutFcn, ...
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


% --- Executes just before PopOut1 is made visible.
function PopOut1_OpeningFcn(hObject, eventdata, handles, varargin)


    % Choose default command line output for PopOut1
    handles.output = hObject;
    if ~isequal(length(varargin),0) % Check to see if PopOut1 is being used as is, or inside LongAxis with Longaxis HANDLES argument passed to it.
        
        if ~isempty(varargin)
            handles.LongAxisMain = varargin{1};
        end
        % Update handles structure
        HANDLES = guidata(handles.LongAxisMain);
        %--------------------------------------------
         global LongAxis_MainHandle     
         LongAxis_MainHandle = handles.LongAxisMain;
         set(handles.figure1,'KeyPressFcn',@ShortCuts)
        %--------------------------------------------
        a = HANDLES.AxisRange;

        set(handles.X_Plane_Slider,'Min',a(1),'Max',a(2),'SliderStep',[0.02/(a(2)-a(1)) 1/(a(2)-a(1))],...
                                   'Value',HANDLES.X_Plane_Slider.Value,'Enable',HANDLES.X_Plane_Slider.Enable)   
        set(handles.XSliceDisplay,'String',sprintf('%5.2f',HANDLES.X_Plane_Slider.Value),'Enable',HANDLES.X_Plane_Slider.Enable)
        set(handles.XLow, 'String',HANDLES.XLow.String, 'Enable',HANDLES.XLow.Enable)
        set(handles.XHigh,'String',HANDLES.XHigh.String,'Enable',HANDLES.XHigh.Enable)
        set(handles.XSliceCheck,'Value',HANDLES.XSliceCheck.Value,'Enable',HANDLES.XSliceCheck.Enable)


        set(handles.Y_Plane_Slider,'Min',a(3),'Max',a(4),'SliderStep',[0.02/(a(4)-a(3)) 1/(a(4)-a(3))],...
                                   'Value',HANDLES.Y_Plane_Slider.Value,'Enable',HANDLES.Y_Plane_Slider.Enable)   
        set(handles.YSliceDisplay,'String',sprintf('%5.2f',HANDLES.Y_Plane_Slider.Value),'Enable',HANDLES.Y_Plane_Slider.Enable)
        set(handles.YLow, 'String',HANDLES.YLow.String, 'Enable',HANDLES.YLow.Enable)
        set(handles.YHigh,'String',HANDLES.YHigh.String,'Enable',HANDLES.YHigh.Enable)
        set(handles.YSliceCheck,'Value',HANDLES.YSliceCheck.Value,'Enable',HANDLES.YSliceCheck.Enable)


        set(handles.Z_Plane_Slider,'Min',a(5),'Max',a(6),'SliderStep',[0.02/(a(6)-a(5)) 1/(a(6)-a(5))],...
                                   'Value',HANDLES.Z_Plane_Slider.Value,'Enable',HANDLES.Z_Plane_Slider.Enable)   
        set(handles.ZSliceDisplay,'String',sprintf('%5.2f',HANDLES.Z_Plane_Slider.Value),'Enable',HANDLES.Z_Plane_Slider.Enable)
        set(handles.ZLow, 'String',HANDLES.ZLow.String, 'Enable',HANDLES.ZLow.Enable)
        set(handles.ZHigh,'String',HANDLES.ZHigh.String,'Enable',HANDLES.ZHigh.Enable)
        set(handles.ZSliceCheck,'Value',HANDLES.ZSliceCheck.Value,'Enable',HANDLES.ZSliceCheck.Enable)

        
        handles.SliceTransparency = HANDLES.SliceTransparency;    
        set(handles.SliceTransparencySlider, 'SliderStep',[1/100 10/100],'Min',0,'Max',100,'Value',handles.SliceTransparency,...
                'Enable',HANDLES.SliceTransparencySlider.Enable,'String','Slice Transparency: 100%')

            
        handles.ViewCellsNearSliceMenu.Value = HANDLES.ViewCellsNearPlane;    
        handles.ViewCellsNearSliceRangeInput.String = HANDLES.ViewCellsNearPlaneRange;
        handles.SliceIsStepSizeCheckBox.Value = HANDLES.SliceIsStepSizeCheckBox.Value;;

        
        handles.ViewAngle = HANDLES.ViewAngle;
        set(handles.ViewAngleSlider,'SliderStep',[1/100 1/10],'Min',5,'Max',15,'Value',HANDLES.ViewAngle)
        set(handles.ViewAngleDisplay,'String',['View Angle Zoom: ' num2str(HANDLES.ViewAngle)])
        
        
        val = logical(get(HANDLES.CamProjButton,'Value'));
        if val
            set(handles.CamProjButton,'String','Proj: Orthographic','Value',1);            
            handles.CamProjButton.Value = val;
            handles.Projection = 'orthographic';
        else
            set(HANDLES.CamProjButton,'String','Proj: Perspective','Value',0);
            handles.CamProjButton.Value = val;
            handles.Projection = 'perspective';
        end
    end
    
    %set(handles.figure1,'KeyPressFcn',@ShortCuts)
    
    
    guidata(hObject, handles);


%----------------------------------------------------------------------------------------------
function varargout = PopOut1_OutputFcn(hObject, eventdata, handles) 

    % Get default command line output from handles structure
    varargout{1} = handles.output;


%----------------------------------------------------------------------------------------------
function ViewCellsNearSliceMenu_Callback(hObject, eventdata, handles)

        handles.ViewCellsNearPlane = handles.ViewCellsNearSliceMenu.Value;
        
        HANDLES = guidata(handles.LongAxisMain);
        HANDLES.ViewCellsNearSliceMenu.Value = handles.ViewCellsNearPlane;
        HANDLES.ViewCellsNearPlane = handles.ViewCellsNearPlane;
        HANDLES = Update_Cells_Near_Slice(HANDLES);

        guidata(handles.LongAxisMain, HANDLES)
        guidata(hObject, handles)

%----------------------------------------------------------------------------------------------
function ViewCellsNearSliceMenu_CreateFcn(hObject, eventdata, handles)

        % Hint: popupmenu controls usually have a white background on Windows.
        %       See ISPC and COMPUTER.

        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%----------------------------------------------------------------------------------------------
function ViewCellsNearSliceRangeInput_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        
        v = round(str2double(handles.ViewCellsNearSliceRangeInput.String),3,'significant');
        
        handles.ViewCellsNearSliceRangeInput.String = v;
        handles.ViewCellsNearPlaneRange = v;
        HANDLES.ViewCellsNearSliceRangeInput.String = v;
        HANDLES.ViewCellsNearPlaneRange = v;
        
        HANDLES = Update_Cells_Near_Slice(HANDLES); 

        guidata(handles.LongAxisMain,HANDLES)
        guidata(hObject,handles)

%----------------------------------------------------------------------------------------------
function ViewCellsNearSliceRangeInput_CreateFcn(hObject, eventdata, handles)

        % Hint: edit controls usually have a white background on Windows.
        %       See ISPC and COMPUTER.
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%----------------------------------------------------------------------------------------------
function SliceIsStepSizeCheckBox_Callback(hObject, eventdata, handles)
        
        HANDLES = guidata(handles.LongAxisMain);
        V = handles.SliceIsStepSizeCheckBox.Value;
        HANDLES.SliceIsStepSizeCheckBox.Value = V;
        a = HANDLES.AxisRange;

        if V
            S = str2double(handles.ViewCellsNearSliceRangeInput.String);
            set(handles.X_Plane_Slider,'SliderStep',[S/(a(2)-a(1)) S/(a(2)-a(1))])
            set(handles.Y_Plane_Slider,'SliderStep',[S/(a(4)-a(3)) S/(a(4)-a(3))])
            set(handles.Z_Plane_Slider,'SliderStep',[S/(a(6)-a(5)) S/(a(6)-a(5))])
            set(HANDLES.X_Plane_Slider,'SliderStep',[S/(a(2)-a(1)) S/(a(2)-a(1))])
            set(HANDLES.Y_Plane_Slider,'SliderStep',[S/(a(4)-a(3)) S/(a(4)-a(3))])
            set(HANDLES.Z_Plane_Slider,'SliderStep',[S/(a(6)-a(5)) S/(a(6)-a(5))])
        else
            S = 0.05;
            set(handles.X_Plane_Slider,'SliderStep',[S/(a(2)-a(1)) 1/(a(2)-a(1))])
            set(handles.Y_Plane_Slider,'SliderStep',[S/(a(4)-a(3)) 1/(a(4)-a(3))])
            set(handles.Z_Plane_Slider,'SliderStep',[S/(a(6)-a(5)) 1/(a(6)-a(5))])
            set(HANDLES.X_Plane_Slider,'SliderStep',[S/(a(2)-a(1)) 1/(a(2)-a(1))])
            set(HANDLES.Y_Plane_Slider,'SliderStep',[S/(a(4)-a(3)) 1/(a(4)-a(3))])
            set(HANDLES.Z_Plane_Slider,'SliderStep',[S/(a(6)-a(5)) 1/(a(6)-a(5))])
        end

        guidata(handles.LongAxisMain,HANDLES)
        guidata(hObject,handles)

%----------------------------------------------------------------------------------------------
function Y_Plane_Slider_Callback(hObject, eventdata, handles)
        
            HANDLES = guidata(handles.LongAxisMain);
            yval = get(handles.Y_Plane_Slider,'Value');
            HANDLES.Y_Plane_Slider.Value = yval;
            
            handles.YSliceValue = yval;
            HANDLES.YSliceValue = yval;
            set(handles.YSliceDisplay,'String',sprintf('%5.2f',yval)) 
            set(HANDLES.YSliceDisplay,'String',sprintf('%5.2f',yval)) 
            
            if isgraphics(HANDLES.YSliceHandle);              delete(HANDLES.YSliceHandle); end            
            if isgraphics(HANDLES.XYSliceIntersectionHandle); delete(HANDLES.XYSliceIntersectionHandle); end            
            if isgraphics(HANDLES.ZYSliceIntersectionHandle); delete(HANDLES.ZYSliceIntersectionHandle); end            
            if isgraphics(HANDLES.YSliceBorderHandle);        delete(HANDLES.YSliceBorderHandle);        end            
            if isgraphics(HANDLES.CP); delete(HANDLES.CP); end
            
            HANDLES = Update_Slice_Plot(HANDLES,2);
            HANDLES = Update_Cells_Near_Slice(HANDLES);
            
            guidata(handles.LongAxisMain,HANDLES)
            guidata(hObject,handles)

%----------------------------------------------------------------------------------------------
function Y_Plane_Slider_CreateFcn(hObject, eventdata, handles)

    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


%----------------------------------------------------------------------------------------------
function X_Plane_Slider_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        
        xval = get(handles.X_Plane_Slider,'Value');
        HANDLES.X_Plane_Slider.Value = xval;
        
        handles.XSliceValue = xval;
        HANDLES.XSliceValue = xval;
        set(handles.XSliceDisplay,'String',sprintf('%5.2f',xval)) 
        set(HANDLES.XSliceDisplay,'String',sprintf('%5.2f',xval)) 

        if isgraphics(HANDLES.XSliceHandle);              delete(HANDLES.XSliceHandle);              end
        if isgraphics(HANDLES.ZXSliceIntersectionHandle); delete(HANDLES.ZXSliceIntersectionHandle); end
        if isgraphics(HANDLES.XYSliceIntersectionHandle); delete(HANDLES.XYSliceIntersectionHandle); end
        if isgraphics(HANDLES.XSliceBorderHandle);        delete(HANDLES.XSliceBorderHandle);        end
        if isgraphics(HANDLES.CP); delete(HANDLES.CP);                                               end

        HANDLES = Update_Slice_Plot(HANDLES,1);
        HANDLES = Update_Cells_Near_Slice(HANDLES);   

        guidata(handles.LongAxisMain,HANDLES)
        guidata(hObject,handles)

%----------------------------------------------------------------------------------------------
function X_Plane_Slider_CreateFcn(hObject, eventdata, handles)

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%----------------------------------------------------------------------------------------------
function XSliceCheck_Callback(hObject, eventdata, handles)
        
        HANDLES = guidata(handles.LongAxisMain);
        val = logical(get(handles.XSliceCheck,'Value'));
        HANDLES.XSliceCheck.Value = val;
        
        if val
            set(handles.X_Plane_Slider,'Enable','on'); set(HANDLES.X_Plane_Slider,'Enable','on')
            set(handles.XSliceDisplay,'Enable','on');  set(HANDLES.XSliceDisplay,'Enable','on')
            set(handles.XLow,'Enable','on');           set(HANDLES.XLow,'Enable','on')
            set(handles.XHigh,'Enable','on');          set(HANDLES.XHigh,'Enable','on')
            
            handles.DoXSlice = true;
            HANDLES.DoXSlice = true;
            
            if isgraphics(HANDLES.CP); delete(HANDLES.CP); end
            HANDLES = Update_Slice_Plot(HANDLES,1);
            HANDLES = Update_Cells_Near_Slice(HANDLES);
        else
            set(handles.X_Plane_Slider,'Enable','off'); set(HANDLES.X_Plane_Slider,'Enable','off')
            set(handles.XSliceDisplay,'Enable','off');  set(HANDLES.XSliceDisplay,'Enable','off')
            set(handles.XLow,'Enable','off');           set(HANDLES.XLow,'Enable','off')
            set(handles.XHigh,'Enable','off');          set(HANDLES.XHigh,'Enable','off')
            handles.DoXSlice = false;
            HANDLES.DoXSlice = false;
            
            HANDLES = Update_Cells_Near_Slice(HANDLES);
            
            %set(0,'CurrentFigure',HANDLES.RenderingFigure)
            
            if isgraphics(HANDLES.XSliceHandle);              delete(HANDLES.XSliceHandle);              end
            if isgraphics(HANDLES.ZXSliceIntersectionHandle); delete(HANDLES.ZXSliceIntersectionHandle); end
            if isgraphics(HANDLES.XYSliceIntersectionHandle); delete(HANDLES.XYSliceIntersectionHandle); end
            if isgraphics(HANDLES.XSliceBorderHandle);        delete(HANDLES.XSliceBorderHandle);        end
            if isgraphics(HANDLES.CP); delete(HANDLES.CP);  end
            
        end
        
        %---------------------------------------------------------------------
        if HANDLES.DoXSlice && HANDLES.DoYSlice && HANDLES.DoZSlice
            set(HANDLES.RecordIntersectionButton,'Enable','on')
        else
            set(HANDLES.RecordIntersectionButton,'Enable','off')
        end
        
        %---------------------------------------------------------------------
        if all([~HANDLES.DoXSlice, ~HANDLES.DoYSlice, ~HANDLES.DoZSlice])
            obj1 = findall(HANDLES.RenderingFigure,'Type','Surface');
            obj2 = findall(HANDLES.RenderingFigure,'Type','Line');
            delete(obj1)
            delete(obj2)
        end        
        
        %---------------------------------------------------------------------
        if any([HANDLES.DoXSlice, HANDLES.DoYSlice, HANDLES.DoZSlice])
            set(handles.SliceTransparencySlider,'Enable','on')
            set(handles.SliceTransparencyDisplay,'Enable','on')
            set(HANDLES.SliceTransparencySlider,'Enable','on')
            set(HANDLES.SliceTransparencyDisplay,'Enable','on')
        else
            set(handles.SliceTransparencySlider,'Enable','off')
            set(handles.SliceTransparencyDisplay,'Enable','off')
            set(HANDLES.SliceTransparencySlider,'Enable','off')
            set(HANDLES.SliceTransparencyDisplay,'Enable','off')
        end
        
        %---------------------------------------------------------------------
        guidata(handles.LongAxisMain,HANDLES)
        guidata(hObject,handles)

%----------------------------------------------------------------------------------------------
function YSliceCheck_Callback(hObject, eventdata, handles)

            HANDLES = guidata(handles.LongAxisMain);
            val = logical(get(handles.YSliceCheck,'Value'));
            HANDLES.YSliceCheck.Value = val;
            
            if val
                set(handles.Y_Plane_Slider,'Enable','on');      set(HANDLES.Y_Plane_Slider,'Enable','on')
                set(handles.YSliceDisplay,'Enable','on');       set(HANDLES.YSliceDisplay,'Enable','on')
                set(handles.YLow,'Enable','on');                set(HANDLES.YLow,'Enable','on')
                set(handles.YHigh,'Enable','on');               set(HANDLES.YHigh,'Enable','on')   
                if isgraphics(HANDLES.CP); delete(HANDLES.CP); end
                handles.DoYSlice = true;
                HANDLES.DoYSlice = true;
                HANDLES = Update_Slice_Plot(HANDLES,2);
                HANDLES = Update_Cells_Near_Slice(HANDLES);
                
            else
                set(handles.Y_Plane_Slider,'Enable','off');      set(HANDLES.Y_Plane_Slider,'Enable','off')
                set(handles.YSliceDisplay,'Enable','off');       set(HANDLES.YSliceDisplay,'Enable','off')
                set(handles.YLow,'Enable','off');                set(HANDLES.YLow,'Enable','off')
                set(handles.YHigh,'Enable','off');               set(HANDLES.YHigh,'Enable','of')   
                handles.DoYSlice = false;
                HANDLES.DoYSlice = false;
                HANDLES = Update_Cells_Near_Slice(HANDLES);
                
                if isgraphics(HANDLES.YSliceHandle);              delete(HANDLES.YSliceHandle);              end                
                if isgraphics(HANDLES.ZYSliceIntersectionHandle); delete(HANDLES.ZYSliceIntersectionHandle); end            
                if isgraphics(HANDLES.XYSliceIntersectionHandle); delete(HANDLES.XYSliceIntersectionHandle); end                
                if isgraphics(HANDLES.YSliceBorderHandle);        delete(HANDLES.YSliceBorderHandle);        end                
                if isgraphics(HANDLES.CP); delete(HANDLES.CP); end
                
            end

            %---------------------------------------------------------------------
            if HANDLES.DoXSlice && HANDLES.DoYSlice && HANDLES.DoZSlice
                set(HANDLES.RecordIntersectionButton,'Enable','on')
            else
                set(HANDLES.RecordIntersectionButton,'Enable','off')
            end
            
            %---------------------------------------------------------------------

            if all([~HANDLES.DoXSlice, ~HANDLES.DoYSlice, ~HANDLES.DoZSlice])
                obj1 = findall(HANDLES.RenderingFigure,'Type','Surface');
                obj2 = findall(HANDLES.RenderingFigure,'Type','Line');
                delete(obj1)
                delete(obj2)
            end  
            
            %---------------------------------------------------------------------
            if any([HANDLES.DoXSlice, HANDLES.DoYSlice, HANDLES.DoZSlice])
                set(handles.SliceTransparencySlider,'Enable','on')
                set(handles.SliceTransparencyDisplay,'Enable','on')
                set(HANDLES.SliceTransparencySlider,'Enable','on')
                set(HANDLES.SliceTransparencyDisplay,'Enable','on')
            else
                set(handles.SliceTransparencySlider,'Enable','off')
                set(handles.SliceTransparencyDisplay,'Enable','off')
                set(HANDLES.SliceTransparencySlider,'Enable','off')
                set(HANDLES.SliceTransparencyDisplay,'Enable','off')
            end
            %---------------------------------------------------------------------
            
            guidata(handles.LongAxisMain,HANDLES)
            guidata(hObject,handles)

%----------------------------------------------------------------------------------------------
function Z_Plane_Slider_Callback(hObject, eventdata, handles)

            HANDLES = guidata(handles.LongAxisMain);
    
            zval = get(handles.Z_Plane_Slider,'Value'); % <----
            HANDLES.Z_Plane_Slider.Value = zval;
            
            HANDLES.ZSliceValue = zval;
            handles.ZSliceValue = zval;
            set(HANDLES.ZSliceDisplay,'String',sprintf('%5.2f',zval)) 
            set(handles.ZSliceDisplay,'String',sprintf('%5.2f',zval)) 
            
            if isgraphics(HANDLES.ZSliceHandle);              delete(HANDLES.ZSliceHandle);              end
            if isgraphics(HANDLES.ZXSliceIntersectionHandle); delete(HANDLES.ZXSliceIntersectionHandle); end
            if isgraphics(HANDLES.ZYSliceIntersectionHandle); delete(HANDLES.ZYSliceIntersectionHandle); end
            if isgraphics(HANDLES.ZSliceBorderHandle);        delete(HANDLES.ZSliceBorderHandle);        end
            if isgraphics(HANDLES.CP); delete(HANDLES.CP);  end
            
            HANDLES = Update_Slice_Plot(HANDLES,3);
            HANDLES = Update_Cells_Near_Slice(HANDLES);
            
            guidata(handles.LongAxisMain,HANDLES)
            guidata(hObject,handles)

%----------------------------------------------------------------------------------------------
function Z_Plane_Slider_CreateFcn(hObject, eventdata, handles)

        if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor',[.9 .9 .9]);
        end


%----------------------------------------------------------------------------------------------
function ZSliceCheck_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        val = logical(get(handles.ZSliceCheck,'Value'));
        HANDLES.ZSliceCheck.Value = val;
        
        if val
            set(handles.Z_Plane_Slider,'Enable','on');      set(HANDLES.Z_Plane_Slider,'Enable','on')
            set(handles.ZSliceDisplay,'Enable','on');       set(HANDLES.ZSliceDisplay,'Enable','on')
            set(handles.ZLow,'Enable','on');                set(HANDLES.ZLow,'Enable','on')
            set(handles.ZHigh,'Enable','on');               set(HANDLES.ZHigh,'Enable','on'); 
            if isgraphics(HANDLES.CP); delete(HANDLES.CP); end
            handles.DoZSlice = true;
            HANDLES.DoZSlice = true;
            HANDLES = Update_Slice_Plot(HANDLES,3);
            HANDLES = Update_Cells_Near_Slice(HANDLES);
        else
            set(handles.Z_Plane_Slider,'Enable','off');      set(HANDLES.Z_Plane_Slider,'Enable','on')
            set(handles.ZSliceDisplay,'Enable','off');       set(HANDLES.ZSliceDisplay,'Enable','on')
            set(handles.ZLow,'Enable','off');                set(HANDLES.ZLow,'Enable','on')
            set(handles.ZHigh,'Enable','off');               set(HANDLES.ZHigh,'Enable','on'); 
            handles.DoZSlice = false;
            HANDLES.DoZSlice = false;
            HANDLES = Update_Cells_Near_Slice(HANDLES);
            
            % set(0,'CurrentFigure',HANDLES.RenderingFigure)
            
            if isgraphics(HANDLES.ZSliceHandle);              delete(HANDLES.ZSliceHandle);              end
            if isgraphics(HANDLES.ZXSliceIntersectionHandle); delete(HANDLES.ZXSliceIntersectionHandle); end
            if isgraphics(HANDLES.ZYSliceIntersectionHandle); delete(HANDLES.ZYSliceIntersectionHandle); end
            if isgraphics(HANDLES.ZSliceBorderHandle);        delete(HANDLES.ZSliceBorderHandle);        end
            if isgraphics(HANDLES.CP); delete(HANDLES.CP);   end
            
        end
        
        %---------------------------------------------------------------------
        if HANDLES.DoXSlice && HANDLES.DoYSlice && HANDLES.DoZSlice
            set(HANDLES.RecordIntersectionButton,'Enable','on')
        else
            set(HANDLES.RecordIntersectionButton,'Enable','off')
        end
        
        %---------------------------------------------------------------------
        if all([~HANDLES.DoXSlice, ~HANDLES.DoYSlice, ~HANDLES.DoZSlice])
            obj1 = findall(HANDLES.RenderingFigure,'Type','Surface');
            obj2 = findall(HANDLES.RenderingFigure,'Type','Line');
            delete(obj1)
            delete(obj2)
        end  
        
        %---------------------------------------------------------------------
        if any([HANDLES.DoXSlice, HANDLES.DoYSlice, HANDLES.DoZSlice])
            set(handles.SliceTransparencySlider,'Enable','on')
            set(handles.SliceTransparencyDisplay,'Enable','on')
            set(HANDLES.SliceTransparencySlider,'Enable','on')
            set(HANDLES.SliceTransparencyDisplay,'Enable','on')
        else
            set(handles.SliceTransparencySlider,'Enable','off')
            set(handles.SliceTransparencyDisplay,'Enable','off')
            set(HANDLES.SliceTransparencySlider,'Enable','off')
            set(HANDLES.SliceTransparencyDisplay,'Enable','off')
        end
        %---------------------------------------------------------------------
        
        guidata(handles.LongAxisMain,HANDLES)
        guidata(hObject,handles)


%----------------------------------------------------------------------------------------------
function SliceTransparencySlider_Callback(hObject, eventdata, handles)
        
        HANDLES = guidata(handles.LongAxisMain);

        handles.SliceTransparency = round(get(handles.SliceTransparencySlider,'Value'));
        handles.SliceTransparencySlider.Value = handles.SliceTransparency;
        
        HANDLES.SliceTransparencySlider.Value = handles.SliceTransparency;
        HANDLES.SliceTransparency = handles.SliceTransparency; 
        
        handles.SliceTransparencyDisplay.String = ['Slice Transparency: ' num2str(handles.SliceTransparency) '%'];
        HANDLES.SliceTransparencyDisplay.String = ['Slice Transparency: ' num2str(handles.SliceTransparency) '%'];
        
        if isgraphics(HANDLES.XSliceHandle)
            HANDLES.XSliceHandle.FaceAlpha = handles.SliceTransparency/100;
        end
        
        if isgraphics(HANDLES.YSliceHandle)
            HANDLES.YSliceHandle.FaceAlpha = handles.SliceTransparency/100;
        end
        
        if isgraphics(HANDLES.ZSliceHandle)
            HANDLES.ZSliceHandle.FaceAlpha = handles.SliceTransparency/100;
        end
                
        guidata(hObject,handles)
        guidata(handles.LongAxisMain,HANDLES)

%----------------------------------------------------------------------------------------------
function SliceTransparencySlider_CreateFcn(hObject, eventdata, handles)

    % Hint: slider controls usually have a light gray background.
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end

%----------------------------------------------------------------------------------------------
function CamProjButton_Callback(hObject, eventdata, handles)
        
        HANDLES = guidata(handles.LongAxisMain);
        val = logical(get(handles.CamProjButton,'Value'));
        figure(HANDLES.RenderingFigure)
        
        if val
            set(handles.CamProjButton, 'String', 'Proj: Orthographic', 'Value', 1);
            set(HANDLES.CamProjButton, 'String', 'Proj: Orthographic', 'Value', 1);
            HANDLES.CamProjButton.Value = val;
            handles.Projection = 'orthographic';
            HANDLES.Projection = 'orthographic';
            camproj(HANDLES.Projection)
        else
            set(handles.CamProjButton,'String', 'Proj: Perspective', 'Value',0);
            set(HANDLES.CamProjButton,'String', 'Proj: Perspective', 'Value',0);
            HANDLES.CamProjButton.Value = val;
            handles.Projection = 'perspective';
            HANDLES.Projection = 'perspective';
            camproj(HANDLES.Projection)
        end
            
        guidata(hObject,handles)
        guidata(handles.LongAxisMain,HANDLES)

%----------------------------------------------------------------------------------------------
function ViewYZ_Button_Callback(hObject, eventdata, handles)
        
        HANDLES = guidata(handles.LongAxisMain);
        if isgraphics(HANDLES.AxisHandle)
            view(HANDLES.AxisHandle,90,0) % view(-90,0)
        end

%----------------------------------------------------------------------------------------------
function ViewXZ_Button_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        if isgraphics(HANDLES.AxisHandle)
            view(HANDLES.AxisHandle,0,0) % view(180,0)
        end
        
%----------------------------------------------------------------------------------------------
function ViewXY_Button_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        if isgraphics(HANDLES.AxisHandle)
            view(HANDLES.AxisHandle,0,90) % view(0,-90)
         end

%----------------------------------------------------------------------------------------------
function ViewNegYZ_Button_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        if isgraphics(HANDLES.AxisHandle)
            view(HANDLES.AxisHandle,-90,0) 
        end

%----------------------------------------------------------------------------------------------
function ViewNegXZ_Button_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        if isgraphics(HANDLES.AxisHandle)
            view(HANDLES.AxisHandle,180,0) 
        end

%----------------------------------------------------------------------------------------------
function ViewNegXY_Button_Callback(hObject, eventdata, handles)

        HANDLES = guidata(handles.LongAxisMain);
        if isgraphics(HANDLES.AxisHandle)
            view(HANDLES.AxisHandle,0,-90)
        end
        
%----------------------------------------------------------------------------------------------
function handles = Update_Slice_Plot(handles,Plane)
    
            a = handles.AxisRange;
            % handles.RenderedSubVolumeIndices = [yr(1) yr(end) xr(1) xr(end) zr(1) zr(end)];
            I1   = handles.SubImStack;
            Xmin = handles.sX(1,1,1);
            Xmax = handles.sX(1,end,1);
            Ymin = handles.sY(1,1,1);
            Ymax = handles.sY(end,1,1);
            Zmin = handles.sZ(1,1,1);
            Zmax = handles.sZ(1,1,end);
            
             switch handles.SliceSmoothingMenu.Value;
                case 1; sm =   0;
                case 2; sm = 0.5;
                case 3; sm = 1.0;
                case 4; sm = 1.5;
                case 5; sm = 2.0;
                case 6; sm = 2.5;
                case 7; sm = 3.0;                    
            end
                        
            switch handles.SliceSaturateMenu.Value;
                case 1;  sat =  0;
                case 2;  sat =  2;
                case 3;  sat =  5;
                case 4;  sat = 10;
                case 5;  sat = 15;
                case 6;  sat = 20;
                case 7;  sat = 25;
            end
            
            hold(handles.AxisHandle,'on')
            
            if strcmp(handles.SliceOrLine,'Slice')
                    LineWidth = 1;
                    LineColor = [0 0 0];
                    switch Plane
                        case 1
                                XDiff = abs(squeeze(handles.sX(1,:,1)) - handles.XSliceValue);
                                [~,indx] = min((XDiff));
                                
                                %Smooth and Saturate ------------------------------------------------------------   
                                    if isequal(sm,0);   G = squeeze( I1(:,indx(1),:) );
                                    else;               G = imgaussfilt( squeeze( I1(:,indx(1),:) ) , [sm sm] );
                                    end
                                    SIx = imsaturate( G, sat);
                                %--------------------------------------------------------------------------------
%                                 IMx = imsaturate( squeeze(I1(:,indx(1),:)) , sat);
%                                 SIx = Smooth2D(double(IMx),2*sm-1); % Apply 2D smoothing based on user selection
%                                 SIx = 255*SIx./max(SIx(:));   

                                hs1 = surf(handles.AxisHandle,...
                                           handles.XSliceValue + zeros([ size(handles.sX,1), size(handles.sX,3) ]),...
                                           squeeze(handles.sY(:,1,:)),...
                                           squeeze(handles.sZ(:,1,:)),...
                                           SIx); 

                                shading flat

                                handles.XSliceHandle = hs1;
                                hs1.FaceColor = 'flat';
                                hs1.FaceAlpha = handles.SliceTransparency/100;
                                hs1.EdgeColor = 'none';
                                hs1.DiffuseStrength = 0;
                                hs1.SpecularStrength = 0;
                                hs1.AmbientStrength = 1;
                                hs1.BackFaceLighting = 'reverselit';

                                handles.XSliceBorderHandle = line(handles.AxisHandle,...
                                                                  ones(5,1)*handles.XSliceValue,...
                                                                  [Ymin;Ymin;Ymax;Ymax;Ymin],...
                                                                  [Zmin;Zmax;Zmax;Zmin;Zmin],...
                                                                  'LineWidth',LineWidth,'Color',[0 0 0],...
                                                                  'AlignVertexCenters','on','LineSmoothing','on');

                        case 2
                                YDiff = abs(squeeze(handles.sY(:,1,1)) - handles.YSliceValue);
                                [~,indy] = min((YDiff));
                                
                                %Smooth and Saturate ------------------------------------------------------------  
                                    if isequal(sm,0);   G = squeeze( I1(indy(1),:,:) );
                                    else;               G = imgaussfilt( squeeze( I1(indy(1),:,:) ) , [sm sm] );
                                    end
                                    SIy = imsaturate( G, sat);
                                %-------------------------------------------------------------------------------- 
%                                 IMy = imsaturate(squeeze(I1(indy(1),:,:)),sat);
%                                 SIy = Smooth2D(double(IMy),2*sm-1);
%                                 SIy = 255*SIy./max(SIy(:));   

                                hs2 = surf(handles.AxisHandle,...
                                           squeeze(handles.sX(1,:,:)),...
                                           handles.YSliceValue + zeros([ size(handles.sX,2), size(handles.sX,3) ]),...
                                           squeeze(handles.sZ(1,:,:)),...
                                           SIy); 

                                shading flat
                                    
                                handles.YSliceHandle = hs2;
                                hs2.FaceColor = 'flat';
                                hs2.FaceAlpha = handles.SliceTransparency/100;
                                hs2.EdgeColor = 'none';
                                hs2.DiffuseStrength = 0;
                                hs2.SpecularStrength = 0;
                                hs2.AmbientStrength = 1;
                                hs2.BackFaceLighting = 'reverselit';

                                handles.YSliceBorderHandle = line(handles.AxisHandle,...
                                                                  [Xmin;Xmin;Xmax;Xmax;Xmin],...
                                                                  ones(5,1)*handles.YSliceValue,...
                                                                  [Zmin;Zmax;Zmax;Zmin;Zmin],...
                                                                  'LineWidth',LineWidth,'Color',[0 0 0],...
                                                                  'AlignVertexCenters','on','LineSmoothing','on');

                        case 3
                                ZDiff = abs(squeeze(handles.sZ(1,1,:)) - handles.ZSliceValue);
                                [~,indz] = min((ZDiff));
                                
                                %Smooth and Saturate ------------------------------------------------------------  
                                    if isequal(sm,0);   G = squeeze( I1(:,:,indz(1)) );
                                    else;               G = imgaussfilt( squeeze( I1(:,:,indz(1)) ) , [sm sm] );
                                    end
                                    SIz = imsaturate( G, sat);
                                %--------------------------------------------------------------------------------
%                                 IMz = imsaturate(squeeze(I1(:,:,indz(1))),sat);
%                                 SIz = Smooth2D(double(IMz),2*sm-1);
%                                 SIz = 255*SIz./max(SIz(:));       

                                hs3 = surf(handles.AxisHandle,...
                                           squeeze(handles.sX(:,:,1)),...
                                           squeeze(handles.sY(:,:,1)),...
                                           handles.ZSliceValue + zeros([ size(handles.sX,1), size(handles.sX,2) ]),...
                                           SIz); 

                                shading flat
                                
                                handles.ZSliceHandle = hs3;
                                hs3.FaceColor = 'flat'; 
                                hs3.FaceAlpha = handles.SliceTransparency/100;
                                hs3.EdgeColor = 'none';
                                hs3.DiffuseStrength  = 0;  
                                hs3.SpecularStrength = 0;
                                hs3.AmbientStrength  = 1;
                                hs3.BackFaceLighting = 'reverselit';

                                handles.ZSliceBorderHandle = line(handles.AxisHandle,...
                                                                  [Xmin;Xmin;Xmax;Xmax;Xmin],...
                                                                  [Ymin;Ymax;Ymax;Ymin;Ymin],...
                                                                  ones(5,1)*handles.ZSliceValue,...
                                                                  'LineWidth',LineWidth,'Color',[0 0 0],...
                                                                  'AlignVertexCenters','on','LineSmoothing','on');
                    end
                    
            else
                
                LineWidth = 2;
                LineColor = [0 0.5 1];
                if ~isgraphics(handles.CP)
                    if handles.DoXSlice && handles.DoYSlice && handles.DoZSlice
                        handles.CP = scatter3(handles.AxisHandle, handles.XSliceValue,...
                                                                  handles.YSliceValue,...
                                                                  handles.ZSliceValue);
                        handles.CP.LineWidth = 1;
                        handles.CP.SizeData = 50;
                        handles.CP.CData = handles.HighlightColor;
                    end
                end
                
            end
            
            % Draw Axis Lines between Slice planes -----------------------------------------------------
          
                if  handles.DoZSlice && handles.DoXSlice
                        if ~isgraphics(handles.ZXSliceIntersectionHandle) 
                              handles.ZXSliceIntersectionHandle = line(handles.AxisHandle,...
                                                                      [handles.XSliceValue; handles.XSliceValue],...
                                                                      [Ymin; Ymax],...
                                                                      [handles.ZSliceValue; handles.ZSliceValue],...
                                                                      'LineWidth',LineWidth,'Color',LineColor); 

                        elseif isempty(handles.ZXSliceIntersectionHandle)
                              handles.ZXSliceIntersectionHandle = line(handles.AxisHandle,...
                                                                      [handles.XSliceValue; handles.XSliceValue],...
                                                                      [Ymin; Ymax],...
                                                                      [handles.ZSliceValue; handles.ZSliceValue],...
                                                                      'LineWidth',LineWidth,'Color',LineColor); 
                        end
                end


                if handles.DoZSlice && handles.DoYSlice
                        if ~isgraphics(handles.ZYSliceIntersectionHandle) 
                              handles.ZYSliceIntersectionHandle = line(handles.AxisHandle,...
                                                                      [Xmin; Xmax],...
                                                                      [handles.YSliceValue; handles.YSliceValue],...
                                                                      [handles.ZSliceValue; handles.ZSliceValue],...
                                                                      'LineWidth',LineWidth,'Color',LineColor,...
                                                                      'AlignVertexCenters','on'); 

                        elseif isempty(handles.ZYSliceIntersectionHandle)
                             handles.ZYSliceIntersectionHandle = line(handles.AxisHandle,...
                                                                     [Xmin; Xmax],...
                                                                     [handles.YSliceValue; handles.YSliceValue],...
                                                                     [handles.ZSliceValue; handles.ZSliceValue],...
                                                                     'LineWidth',LineWidth,'Color',LineColor,...
                                                                     'AlignVertexCenters','on'); 
                        end
                end


                if handles.DoXSlice && handles.DoYSlice
                        if ~isgraphics(handles.XYSliceIntersectionHandle) 
                              handles.XYSliceIntersectionHandle = line(handles.AxisHandle,...
                                                                      [handles.XSliceValue; handles.XSliceValue],...
                                                                      [handles.YSliceValue; handles.YSliceValue],...
                                                                      [Zmin; Zmax],...
                                                                      'LineWidth',LineWidth,'Color',LineColor,...
                                                                      'AlignVertexCenters','on');  

                        elseif isempty(handles.XYSliceIntersectionHandle)
                              handles.XYSliceIntersectionHandle = line(handles.AxisHandle,...
                                                                      [handles.XSliceValue; handles.XSliceValue],...
                                                                      [handles.YSliceValue; handles.YSliceValue],...
                                                                      [Zmin; Zmax],...
                                                                      'LineWidth',LineWidth,'Color',LineColor,...
                                                                      'AlignVertexCenters','on');  
                        end
                end  
      
            
           %-------------------------------------------------------------------------------------
           colormap(eval([handles.ColorMap '(25)']))

           hold(handles.AxisHandle,'off')  
           
           
%----------------------------------------------------------------------------------------------
function handles = Update_Cells_Near_Slice(handles)
        
    if logical(handles.ViewCellsNearPlane - 1) && logical(handles.DoXSlice + handles.DoYSlice + handles.DoZSlice)
        if (isequal(handles.ViewCellsNearPlane,2) && handles.DoXSlice) || ...
           (isequal(handles.ViewCellsNearPlane,3) && handles.DoYSlice) || ...
           (isequal(handles.ViewCellsNearPlane,4) && handles.DoZSlice)
       
            handles.ObjNearSliceView = true(handles.nObjs,1); 
            %---------------------------------------------------------------------------------------------------------------
            if ~isequal(handles.nObjs, length(handles.COM)) || isempty(handles.COM)
                handles.COM = zeros(handles.nObjs,3);
                for k = 1:handles.nObjs
                    handles.COM(k,:) = handles.CellData{k,1}.CellCenterOfMass; % Center of Data Points (center of mass of cell)
                end 
            end 
            %---------------------------------------------------------------------------------------------------------------
            switch handles.ViewCellsNearPlane
                case 1 % Turn OFF

                case 2 % Only show cells near X Plane ----------------------------------------------
                    LowerBound  = handles.XSliceValue - handles.ViewCellsNearPlaneRange;
                    HigherBound = handles.XSliceValue + handles.ViewCellsNearPlaneRange;
                    handles.ObjNearSliceView(handles.COM(:,1) < LowerBound | handles.COM(:,1) > HigherBound) = false;
                case 3 % Only show cells near Y Plane ----------------------------------------------
                    LowerBound  = handles.YSliceValue - handles.ViewCellsNearPlaneRange;
                    HigherBound = handles.YSliceValue + handles.ViewCellsNearPlaneRange;
                    handles.ObjNearSliceView(handles.COM(:,2) < LowerBound | handles.COM(:,2) > HigherBound) = false;
                case 4 % Only show cells near Z Plane ----------------------------------------------
                    LowerBound  = handles.ZSliceValue - handles.ViewCellsNearPlaneRange;
                    HigherBound = handles.ZSliceValue + handles.ViewCellsNearPlaneRange;
                    handles.ObjNearSliceView(handles.COM(:,3) < LowerBound | handles.COM(:,3) > HigherBound) = false;
            end
            %----------------------------------------------------------------------------------------------------------------
            for n = 1:handles.nObjs
                if handles.ObjNearSliceView(n,1) && handles.ObjVisible(n,1)
                    set(handles.IsoSurfaceHandles{n,1},'Visible','on')
                    set(handles.IsoCapHandles{n,1},'Visible','on')
                else
                    set(handles.IsoSurfaceHandles{n,1},'Visible','off')
                    set(handles.IsoCapHandles{n,1},'Visible','off')
                end
            end            
            %----------------------------------------------------------------------------------------------------------------
        end
        %--------------------------------------------------------------------------------------------------------------------
    else
        for n = 1:handles.nObjs
            if handles.ObjVisible(n,1)
                set(handles.IsoSurfaceHandles{n,1},'Visible','on')
                set(handles.IsoCapHandles{n,1},'Visible','on')
            else
                set(handles.IsoSurfaceHandles{n,1},'Visible','off')
                set(handles.IsoCapHandles{n,1},'Visible','off')
            end
        end
    end

%-----------------------------------------------------------------------------------------------------------
    function SI = Smooth2D(Im,n)
        
            obj = class(Im);
            S = conv2(double(Im),ones(n)./n^2,'same');
            
            switch obj
                case 'double'
                    SI = S;
                case 'single'
                    SI = single(S);
                case 'uint8'
                    SI = uint8(S);
                case 'uint16'
                    SI = uint16(S);
            end


%-----------------------------------------------------------------------------------------------------------
function ViewAngleSlider_Callback(hObject, eventdata, handles)
    
        HANDLES = guidata(handles.LongAxisMain);
        val = (round(10*get(handles.ViewAngleSlider,'Value')))./10;
        
            set(handles.ViewAngleSlider,'Value',val)
            set(HANDLES.ViewAngleSlider,'Value',val)

            set(handles.ViewAngleDisplay,'String',['View Angle Zoom: ' sprintf('%3.1f',val) ' deg'])
            set(HANDLES.ViewAngleDisplay,'String',['View Angle Zoom: ' sprintf('%3.1f',val) ' deg'])

            handles.ViewAngle = val;
            HANDLES.ViewAngle = val;

            set(HANDLES.AxisHandle,'CameraViewAngle',handles.ViewAngle)
        
        guidata(hObject,handles)
        guidata(handles.LongAxisMain,HANDLES)

%-----------------------------------------------------------------------------------------------------------
function ViewAngleSlider_CreateFcn(hObject, eventdata, handles)

    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end
%-----------------------------------------------------------------------------------------------------------
function IMS = imsaturate(Im,p)
%
%     Image Saturation (AutoContrast)
%           IMS = imsaturate(Im,p)
%
%           Im = 8bit grayscale image
%           p = percent saturation on each end of histogram (0-49)
%
% KRC 06/26/2009
%
            IMS = imadjust( Im,...
                            stretchlim(Im, [p/100 (100-p)/100]) );
          
%----------------------------------------------------------------------------------------------------------- 
function ShortCuts(src,evnt)
            
            global LongAxis_MainHandle   
            handles = guidata(LongAxis_MainHandle); 
            %=================================================================================================
            if ~isequal(handles.nObjs, length(handles.COM)) || isempty(handles.COM)
                handles.COM = zeros(handles.nObjs,3);
                for k = 1:handles.nObjs
                    % Center of Data Points (center of mass of cell)
                    handles.COM(k,:) = handles.CellData{k,1}.CellCenterOfMass; 
                end 
            end 
            %================================================================================================
            key = double(lower(evnt.Character));
            LBT = handles.CellList.ListboxTop;
            
            if isnumeric(key) && ~isempty(key)
                switch key
                    %----------------------------------------------------------------------------------------    
                    case 114 % 'r' or 'R'
                       set(0,'CurrentFigure',handles.RenderingFigure)
                       rotate3d                      
                       %######################################################################################  
                        % This code fixes MATLAB 'bug' that won't allow a figure's 
                        % Key-Press Functions to work while in Rotate3d mode
                        % http://undocumentedmatlab.com/blog/enabling-user-callbacks-during-zoom-pan     
                            handles = KeyPressWithRotate3DFix(handles);
                        % ##################################################################################  
                    %-----------------------------------------------------------------------------------------               
                    case 28 %Left Arrow - 
                       
                    %-----------------------------------------------------------------------------------------    
                    case 29 %Right Arrow - 
                       
                    %-----------------------------------------------------------------------------------------    
                    case 31 %Down Arrow 
                        index = handles.CellList.Value;
                        N = length(handles.CellList.String);
                        if ~isequal(index,N)
                            index = index + 1;
                            handles.CellList.Value = index;
                            handles.CurrentlySelectedCell = index;
                            set(handles.RecentCellSelectionDisplay,'String',...
                            ['Recent Cell Select: ' num2str(index)])
                            handles = Update_SingleCellAxis(handles,index); 
                            set(handles.nCellsVisibleDisplay,'String',...
                                ['nCells Visible: ' num2str(sum(handles.ObjVisible(:))) ]);
                        end
                    %----------------------------------------------------------------------------------------                  
                    case 30 %Up Arrow 
                        index = handles.CellList.Value;
                        if ~isequal(index,1)
                            index = index - 1;
                            handles.CellList.Value = index;
                            handles.CurrentlySelectedCell = index;
                            set(handles.RecentCellSelectionDisplay,'String',...
                            ['Recent Cell Select: ' num2str(index)])
                            handles = Update_SingleCellAxis(handles,index); 
                            set(handles.nCellsVisibleDisplay,'String',...
                                ['nCells Visible: ' num2str(sum(handles.ObjVisible(:))) ]);
                        end
                    %----------------------------------------------------------------------------------------        
                    case 104 % 'h' or 'H' key press
                            % Check to see that there is a cell that is highlighted
                            if ~isequal(handles.CurrentlySelectedCell,0) 
                                    N = handles.CurrentlySelectedCell;
                                    if handles.ObjSelected(N,1) 
                                        % If Object is already Highlighted ----
                                        handles.ObjVisible(N,1)  = true;
                                        handles.ObjSelected(N,1) = false;
                                        handles = Update_Single_Cell(handles,N);
                                        handles = Update_SingleCellAxis(handles,N); 
                                    else
                                        % If Object is NOT Highlighted --------
                                        % Check if SingleCellHighlight Mode is checked
                                        if handles.SingleCellHighLight 
                                            % If so unhighlight all other highlighted 
                                            % cells before highlighting this one------------------------------
                                            idx = find(handles.ObjSelected(:,1))';
                                            nObj = length(handles.ObjSelected(:,1));
                                            handles.ObjSelected(:,1) = false(nObj,1);
                                            for ii = idx
                                                handles = Update_Single_Cell(handles,ii);
                                            end
                                            %-----------------------------------------------------------------
                                        end 
                                        handles.ObjVisible(N,1)  = true;
                                        handles.ObjSelected(N,1) = true;
                                        handles = Update_Single_Cell(handles,N);
                                        handles = Update_SingleCellAxis(handles,N); 
                                    end
                                    handles.CellList.String = ...
                                        CreateCellListStringArray(handles.CellIndices, handles.CellSizes,...
                                                                  handles.ObjVisible, handles.ObjSelected); 
                            end
                            
                    %----------------------------------------------------------------------------------------    
                    case 115 % 's' or 'S'
                        % START: Turn ButtonDownFunctions OFF for all the cell renderings -----------------
                            for n = 1:handles.nObjs
                                set(handles.IsoSurfaceHandles{n,1},'ButtonDownFcn','')
                            end
                        % ---------------------------------------------------------------------------------
                        
                        test1 = any([(isequal(handles.ViewCellsNearPlane,2) && handles.DoXSlice),...
                                     (isequal(handles.ViewCellsNearPlane,3) && handles.DoYSlice),...
                                     (isequal(handles.ViewCellsNearPlane,4) && handles.DoZSlice)]);
                                 
                        test2 = isequal(handles.Projection,'orthographic');
                        
                        [az,el] = view(handles.AxisHandle);
                        ViewVec = [az,el];
                           
                        if     isequal(ViewVec,[   0,  90 ]); rView = 'posXY'; test3 = true; 
                        elseif isequal(ViewVec,[   0, -90 ]); rView = 'negXY'; test3 = true;
                        elseif isequal(ViewVec,[   0,   0 ]); rView = 'posXZ'; test3 = true;
                        elseif isequal(ViewVec,[ 180,   0 ]); rView = 'negXZ'; test3 = true;
                        elseif isequal(ViewVec,[  90,   0 ]); rView = 'posYZ'; test3 = true;
                        elseif isequal(ViewVec,[ -90,   0 ]); rView = 'negYZ'; test3 = true;
                        else                                  rView = '';      test3 = false;
                        end
                        
                        if ~test2 || ~test3 
                            % Error Boxes --------------------------------------------------------------------
                            if ~test2 && ~test3
                              hmes = errordlg({'For MULTI-CELL HIGHLIGHTING to work, go to the IMAGE panel';...
                                                'and make the following adjustments:';...
                                                 '      - Proj: ORTHOGRAPHIC';...
                                                 '      - Select the VIEW as +/-XZ, +/-YZ, or +/-XY';' '},...
                                                 'Selection-Mode Error');
                            elseif ~test2
                              hmes = errordlg({'For MULTI-CELL HIGHLIGHTING to work, go to the IMAGE panel';...
                                                 'and make the following adjustments:';...
                                                 '      - Proj: ORTHOGRAPHIC'; ' '},...
                                                 'Selection-Mode Error');
                            elseif ~test3
                              hmes = errordlg({'For MULTI-CELL HIGHLIGHTING to work, go to the IMAGE panel';...
                                                 'and make the following adjustments:';...
                                                 '      - Select the VIEW as +/-XZ, +/-YZ, or +/-XY'; ' '},...
                                                 'Selection-Mode Error');
                            end % ----------------------------------------------------------------------------
                            
                        else % Start Region Selection ||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                             try   
                                global POINTDATA 
                                                                
                                set(0,'CurrentFigure',handles.RenderingFigure)
                                set(handles.RenderingFigure,'Pointer','crosshair')
                                rotate3d(handles.AxisHandle,'off'); 
                                zoom(handles.AxisHandle,'off'); 
                                pan(handles.AxisHandle,'off')
                                %-----------------------------------------------------------------------------
                                     POINTDATA.Figure    = handles.RenderingFigure;
                                     POINTDATA.Axis      = handles.AxisHandle;
                                     POINTDATA.Limits    = handles.AxisRange;
                                     POINTDATA.rView     = rView;
                                     POINTDATA.COM       = handles.COM;
                                     POINTDATA.ONSV      = handles.ObjNearSliceView;
                                     POINTDATA.ObjVis    = handles.ObjVisible;
                                     POINTDATA.ObjSel    = handles.ObjSelected;
                                %-----------------------------------------------------------------------------
                                % Initiate Rectangle by waiting for first-point-click on figure window
                                    k = waitforbuttonpress; 
                                % Grab first point and record it
                                    p = get(handles.AxisHandle, 'CurrentPoint');  
                                    POINTDATA.p1 = p(1,:);
                                % Turn on Motion function that updates rectangle drawing in real time
                                    set(handles.RenderingFigure, 'WindowButtonMotionFcn',...
                                                                 @DrawSelectionRectangle,...
                                                                 'WindowButtonDownFcn'  ,...
                                                                 @GrabSelectionNewPoint) 
                                % waitfor next point to be selected, record it, and draw finalized triangle
                                    waitfor(POINTDATA.Figure, 'WindowButtonDownFcn'  , '');                 
                                %-----------------------------------------------------------------------------
                                handles.ObjSelected = POINTDATA.ObjSel;
                                clear POINTDATA
                                set(handles.RenderingFigure, 'WindowButtonMotionFcn', '',...
                                                             'WindowButtonDownFcn'  , '')
                                                         
                                handles.CellList.String = CreateCellListStringArray(handles.CellIndices,...
                                                                                    handles.CellSizes,...
                                                                                    handles.ObjVisible,...
                                                                                    handles.ObjSelected);                         
                             %||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                              
                             end
                             
                            % START: Turn ButtonDownFunctions back ON for all the cell renderings ----
                                for n = 1:handles.nObjs
                                    set(handles.IsoSurfaceHandles{n,1},'ButtonDownFcn',@PatchBDF)
                                end
                            % ------------------------------------------------------------------------
                             
                        end
                        
                        set(handles.RenderingFigure,'Pointer','arrow')    
                %---------------------------------------------------------------------------------------------  
                    case 117 % 'u' or 'U' Key Press
                            
                            [M,N] = size(handles.UndoButtonRecordedVisActions);

                            if M > 0
                                    FH = WaitToUpdateRendering;
                                    drawnow
                                    %Find only the cells that need to be changed
                                    idx = find(abs(diff([handles.ObjVisible,...
                                        handles.UndoButtonRecordedVisActions(:,1)],1,2)))'; 
                                    handles.ObjVisible  = handles.UndoButtonRecordedVisActions(:,1);
                                    handles.ObjSelected = false(size(handles.ObjVisible,1),1);
                                    handles.UndoButtonRecordedVisActions(:,1) = [];
                                    
                                    if isequal(numel(handles.UndoButtonRecordedVisActions),0)
                                        handles.UndoButtonRecordedVisActions = false(0,1);  
                                    end 
                                    
                                    L = length(handles.ObjVisible);     Toggle = [{'off'};{'on'}];

                                    if handles.ViewCellsNearPlane == 1
                                        for k = idx
                                            set(handles.IsoSurfaceHandles{k,1}, 'Visible',...
                                                Toggle{ handles.ObjVisible(k,1) + 1},...
                                                'FaceColor', handles.FaceColor)
                                            set(handles.IsoCapHandles{k,1},     'Visible',...
                                                Toggle{ handles.ObjVisible(k,1) + 1},...
                                                'FaceColor', handles.FaceColor)
                                        end
                                    else
                                        handles = Update_Cells_Near_Slice(handles);
                                    end

                                    nvis = sum(double(handles.ObjVisible));
                                    set(handles.nCellsVisibleDisplay,'String',...
                                        ['nCells Visible: ' num2str(nvis)]) 
                                    
                                   %-------------Update Cell List box ----------------------------------------
                                   handles.CellList.String = CreateCellListStringArray(handles.CellIndices,...
                                                                                        handles.CellSizes,...
                                                                                        handles.ObjVisible,...
                                                                                        handles.ObjSelected);
                                    %-------------------------------------------------------------------------
                                    drawnow
                                    try close(FH); end    
                            end
                        
                %---------------------------------------------------------------------------------------------    
                    case 118 % 'v' or 'V' Key press
                            % Turn Visibility of selected object OFF or ON ===================================  
                            if any(handles.ObjSelected) % Check to see if there are cells Highlighted.
                                % If so, change Visibility to 'off'
                                %-- Record Visibility State for Undo Button ----------------------------------
                                    handles = UpdateActionRecordingsForUNDO(handles);
                                %-----------------------------------------------------------------------------  
                                ind1 = find(handles.ObjSelected);
                                for k = ind1'
                                    set(handles.IsoSurfaceHandles{k},'Visible','off',...
                                        'FaceColor',handles.FaceColor)%,'EdgeColor',handles.MeshColor)
                                    set(handles.IsoCapHandles{k},    'Visible','off',...
                                        'FaceColor',handles.FaceColor)%,'EdgeColor',handles.MeshColor) 
                                    handles.ObjSelected(k,1) = false;
                                    handles.ObjVisible(k,1)  = false;
                                end
                                
                            else
                                    % Check to see that there is a cell that is highlighted in Cell list box
                                    if ~isequal(handles.CurrentlySelectedCell,0) 
                                            %-- Record Visibility State for Undo Button -----------------------
                                            handles = UpdateActionRecordingsForUNDO(handles);
                                            %------------------------------------------------------------------
                                            N = handles.CurrentlySelectedCell;
                                            if handles.ObjVisible(N,1) % If Object is already visible ---------
                                                    handles.ObjSelected(N,1) = false;
                                                    handles.ObjVisible(N,1)  = false;
                                                    handles.CellList.ListboxTop = LBT;
                                                    % Turn off Visibility of Selected Cell ----------
                                                    set(handles.IsoSurfaceHandles{N},'Visible','off',...
                                                        'FaceColor',handles.FaceColor)
                                                    set(handles.IsoCapHandles{N},    'Visible','off',...
                                                        'FaceColor',handles.FaceColor)
                                                    handles = Update_SingleCellAxis(handles,N);    
                                                    % -----------------------------------------------
                                                    if ~isempty(handles.VectorHandles)
                                                            V = zeros(length(handles.VectorData),1); 
                                                            for k = 1:length(V)
                                                                V(k,1) = handles.VectorData{k,1}.CellIndex; 
                                                            end
                                                            Vind = find(V == N);
                                                            delete(handles.VectorHandles{Vind,1})
                                                    end
                                            else
                                                    handles.ObjSelected(N,1) = false;
                                                    handles.ObjVisible(N,1)  = true;
                                                    handles.CellList.ListboxTop = LBT;
                                                    % Turn off Visibility of Selected Cell ----------
                                                    if handles.ShowFace; FC = handles.FaceColor; else; FC = 'none'; end
                                                    if handles.ShowMesh; MC = handles.MeshColor; else; MC = 'none'; end
                                                    set(handles.IsoSurfaceHandles{N},'Visible','on',...
                                                        'FaceColor',FC,...
                                                        'FaceAlpha',handles.FaceTransparency/100,...
                                                        'EdgeColor',MC,...
                                                        'EdgeAlpha',handles.MeshTransparency/100)
                                                    set(handles.IsoCapHandles{N},'Visible','on',...
                                                        'FaceColor',FC,...
                                                        'FaceAlpha',handles.FaceTransparency/100,...
                                                        'EdgeColor',MC,...
                                                        'EdgeAlpha',handles.MeshTransparency/100)
                                                    handles = Update_SingleCellAxis(handles,N);    
                                            end
                                    end
                            end
                            
                            handles.CellList.String = CreateCellListStringArray(handles.CellIndices,...
                                                                                handles.CellSizes,...
                                                                                handles.ObjVisible,...
                                                                                handles.ObjSelected); 
                            drawnow
                            %set(0,'CurrentFigure',handles.MainFigure1)
                            nvis = sum(double(handles.ObjVisible));
                            set(handles.nCellsVisibleDisplay,'String',['nCells Visible: ' num2str(nvis)])
                end %========================================================================================
            end
            
            %set(handles.RenderingFigure,'Pointer','arrow')
            guidata(LongAxis_MainHandle,handles)
            
%--------------------------------------------------------------------------------------------------------------
function handles = KeyPressWithRotate3DFix(handles);    

% This code fixes MATLAB's 'bug' that won't allow a figure's Key-Press 
% Functions to work while in Rotate3d mode
% http://undocumentedmatlab.com/blog/enabling-user-callbacks-during-zoom-pan   
% Currently works for R2017b.
    
        try 
            % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            % This may need to be updated in future MATLAB releases.
            %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            
            % Fix for main Longaxis main figure ----------------------
            hManager =    uigetmodemanager(handles.MainFigure1); 
            [hManager.WindowListenerHandles.Enabled] =  deal(false);  
            set(handles.MainFigure1, 'WindowKeyPressFcn',   []);
            set(handles.MainFigure1, 'KeyPressFcn', @ShortCuts);            
            
            % Fix for Rendering figure -------------------------------
            hManager =    uigetmodemanager(handles.RenderingFigure); 
            [hManager.WindowListenerHandles.Enabled] =  deal(false);  
            set(handles.RenderingFigure, 'WindowKeyPressFcn',   []);
            set(handles.RenderingFigure, 'KeyPressFcn', @ShortCuts);
            
            % Fix for PopOut1 figure ---------------------------------
            hManager =    uigetmodemanager(handles.figure1); 
            [hManager.WindowListenerHandles.Enabled] =  deal(false);  
            set(handles.figure1, 'WindowKeyPressFcn',   []);
            set(handles.figure1, 'KeyPressFcn', @ShortCuts);     
            
            
        catch
            warning('Warning: KeyPressWithRotate3DFix function is not working properly')
        end
    
        
%--------------------------------------------------------------------------------------------------------------
function DrawSelectionRectangle(src,evnt)

        global POINTDATA
        global LongAxis_MainHandle  
        
        handles = guidata(LongAxis_MainHandle);
        
        s1 = POINTDATA.p1;
        s = get(POINTDATA.Axis,'CurrentPoint');
        s2 = s(1,:);
        POINTDATA.p2 = s2;
        P = sort([s1;s2]);
            p1 = P(1,:);
            p2 = P(2,:);
            d = diff(P);
        ind = find(~logical(d));  % ~logical(d);
            x1 = P(1,1); x2 = P(2,1);
            y1 = P(1,2); y2 = P(2,2);
            z1 = P(1,3); z2 = P(2,3);
            
        %--------------------------------------------------------    
        B = logical(handles.ViewCellsNearSliceMenu.Value - 1);   
        switch B
            case 1
                ind1 = find(POINTDATA.ONSV & POINTDATA.ObjVis);    
            case 0
                ind1 = find(POINTDATA.ObjVis);
        end
        %--------------------------------------------------------
        
        %|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        if ~isempty(ind) && isequal(length(ind),1)   
            switch ind
                    %-----------------------------------------------------------------------------
                case 1 % YZ
                    %-----------------------------------------------------------------------------
                    x = [x1;x1;x1;x1;x1];
                    y = [y1;y2;y2;y1;y1];
                    z = [z1;z1;z2;z2;z1];
                    for k = ind1'
                        if (handles.COM(k,2) <= y2 && handles.COM(k,2) >= y1 &&...
                            handles.COM(k,3) <= z2 && handles.COM(k,3) >= z1)
                        
                            set(handles.IsoSurfaceHandles{k,1},'FaceColor',handles.HighlightColor)
                            if handles.PartialCell(k,1)
                                set(handles.IsoCapHandles{k,1},'FaceColor',handles.HighlightColor)
                            end
                            POINTDATA.ObjSel(k,1) = true;
                        else
                            set(handles.IsoSurfaceHandles{k,1},'FaceColor',handles.FaceColor)
                            if handles.PartialCell(k,1)
                                set(handles.IsoCapHandles{k,1},'FaceColor',handles.FaceColor)
                            end
                            POINTDATA.ObjSel(k,1) = false;
                        end
                    end
                    %-----------------------------------------------------------------------------
                case 2 % XZ
                    %-----------------------------------------------------------------------------
                    x = [x1;x2;x2;x1;x1];
                    y = [y1;y1;y1;y1;y1];
                    z = [z1;z1;z2;z2;z1];
                    for k = ind1'
                        if (handles.COM(k,1) <= x2 && handles.COM(k,1) >= x1 &&...
                            handles.COM(k,3) <= z2 && handles.COM(k,3) >= z1)
                        
                            set(handles.IsoSurfaceHandles{k},'FaceColor',handles.HighlightColor)
                            if handles.PartialCell(k,1)
                                set(handles.IsoCapHandles{k,1},'FaceColor',handles.HighlightColor)
                            end
                            POINTDATA.ObjSel(k,1) = true;
                        else
                            set(handles.IsoSurfaceHandles{k},'FaceColor',handles.FaceColor)
                            if handles.PartialCell(k,1)
                                set(handles.IsoCapHandles{k,1},'FaceColor',handles.FaceColor)
                            end
                            POINTDATA.ObjSel(k,1) = false;
                        end
                    end
                    %-----------------------------------------------------------------------------
                case 3 % XY
                    %-----------------------------------------------------------------------------
                    x = [x1;x2;x2;x1;x1];
                    y = [y1;y1;y2;y2;y1];
                    z = [z1;z1;z1;z1;z1];
                    for k = ind1'
                        if (handles.COM(k,1) <= x2 && handles.COM(k,1) >= x1 &&...
                            handles.COM(k,2) <= y2 && handles.COM(k,2) >= y1)
                            set(handles.IsoSurfaceHandles{k},'FaceColor',handles.HighlightColor)
                            if handles.PartialCell(k,1)
                                set(handles.IsoCapHandles{k,1},'FaceColor',handles.HighlightColor)
                            end
                            POINTDATA.ObjSel(k,1) = true;
                        else
                            set(handles.IsoSurfaceHandles{k},'FaceColor',handles.FaceColor)
                            if handles.PartialCell(k,1)
                                set(handles.IsoCapHandles{k,1},'FaceColor',handles.FaceColor)
                            end
                            POINTDATA.ObjSel(k,1) = false;
                        end
                    end
                    %-----------------------------------------------------------------------------
            end
            
            set(0,'CurrentFigure',POINTDATA.Figure)
            %-------------------------------------------
            if isfield(POINTDATA,'HR')
                if isgraphics(POINTDATA.HR); delete(POINTDATA.HR); end
            end
            %-------------------------------------------
            hold(POINTDATA.Axis,'on')
                POINTDATA.HR = plot3(x,y,z,'-.c','LineWidth',1.5);
            hold(POINTDATA.Axis,'off')
        end
        
        
%------------------------------------------------------------------------------------------------------       
function GrabSelectionNewPoint(src,evnt)
    
        global POINTDATA 
       
        set(POINTDATA.Figure,'WindowButtonDownFcn','',...
                             'WindowButtonMotionFcn','',...
                             'WindowStyle','Normal')
        %-----------------------------------------
        if isfield(POINTDATA,'HR')
            if isgraphics(POINTDATA.HR)
                delete(POINTDATA.HR)
            end
        end
        %-----------------------------------------
 
%------------------------------------------------------------------------------------------------------               
function LS = CreateCellListStringArray(CellIndices,CellSizes,IsCellVisible,IsCellHighLighted)

                % for N cells
                % CellIndex             (N,1) double prec array
                % CellSize (voxels)     (N,1) double prec array
                % IsCellVisible         (N,1) logical array
                % IsCellHighLighted     (N,1) logical array

                N = size(CellIndices,1);
                Cs = num2str([11111;  CellIndices]);  Cs = Cs(2:end,:);
                Ss = num2str([111111; CellSizes]);    Ss = Ss(2:end,:);
                B  = blanks(N)';
                Vs = B; 
                Vs(IsCellVisible) = 'V'; 
                Hs = B; 
                Hs(IsCellHighLighted) = 'H'; 

                SA = [Cs,B,Ss,B,B,Vs,B,B,Hs];
                LS = mat2cell(SA,ones(1,N),size(SA,2));  
                
%------------------------------------------------------------------------------------------------------                  
 function handles = Update_SingleCellAxis(handles,index)      
       
        if ~isempty(index) && ~isequal(index,0)
         
            cla(handles.SelectedCellAxis)
            
                       X = mean(handles.IsoSurfaceHandles{index,:}.XData)';
                       Y = mean(handles.IsoSurfaceHandles{index,:}.YData)';
                       Z = mean(handles.IsoSurfaceHandles{index,:}.ZData)';   
                       nVal = numel(X); 
                       COM = double(handles.CellData{index}.CellCenterOfMass);

                       Xmin = min(X); Xmax = max(X);
                       Ymin = min(Y); Ymax = max(Y);
                       Zmin = min(Z); Zmax = max(Z);
                       
                       if isfield(handles.CellData{index,1},'MinBoundingSphereRadiusOfCell');
                            MinDiameter = 2*handles.CellData{index,1}.MinBoundingSphereRadiusOfCell;
                            SC = handles.CellData{index,1}.CenterOfMinBoundingSphere;
                       else
                            MinDiameter = 0;
                            SC = 0;
                       end 
                       
                       switch handles.SingleCellDisplayStyle
                           case 'nodata'
                                
                           case 'datasurface' % Create Cell Surface
                                % Create IsoSurface
                                FS = handles.IsoSurfaceHandles{index,1}.Faces;
                                VS = handles.IsoSurfaceHandles{index,1}.Vertices;
                                    
                                VSorigin = [VS(:,1)-Xmin, VS(:,2)-Ymin, VS(:,3)-Zmin];
                                % For use with calulcated cross sectional Min 
                                % Bounding Circle through center of ellipsoid
                                        CellSurface.faces = FS; 
                                        CellSurface.vertices = VSorigin;
                                %----------------------------------------------------------------------------
                                patch(handles.SelectedCellAxis,'Faces',FS,'Vertices',VSorigin,...
                                                   'FaceColor',handles.FaceColor,...
                                                   'EdgeColor',handles.MeshColor,...
                                                   'FaceAlpha',handles.FaceTransparency/100,...
                                                   'EdgeAlpha',handles.MeshTransparency/100,...
                                                   'Visible','on')
                                % Create IsoCap
                                FC = handles.IsoCapHandles{index}.Faces;
                                VC = handles.IsoCapHandles{index}.Vertices;    
                                VCorigin = [VC(:,1)-Xmin, VC(:,2)-Ymin, VC(:,3)-Zmin];
                                patch(handles.SelectedCellAxis,'Faces',FC,'Vertices',VCorigin,...
                                                               'FaceColor',0.8*handles.FaceColor,...
                                                               'EdgeColor','none',...
                                                               'FaceAlpha',handles.FaceTransparency/100,...
                                                               'EdgeAlpha',handles.MeshTransparency/100,...
                                                               'Visible','on')
                                
                                % Plot center of mass point --------------------------------------------------                           
                                hold(handles.SelectedCellAxis,'on')
                                    plot3(handles.SelectedCellAxis, COM(1)-Xmin, ...
                                        COM(2)-Ymin, COM(3)-Zmin,'.','MarkerSize',20,'Color','r')  
                                hold(handles.SelectedCellAxis,'off')                           

                           case 'datapoints' 
                                FS = handles.IsoSurfaceHandles{index,1}.Faces;
                                VS = handles.IsoSurfaceHandles{index,1}.Vertices;
                                    
                                VSorigin = [VS(:,1)-Xmin, VS(:,2)-Ymin, VS(:,3)-Zmin];
                                % For use with calulcated cross sectional Min 
                                % Bounding Circle through center of ellipsoid
                                        CellSurface.faces = FS; 
                                        CellSurface.vertices = VSorigin;
                                % Plot center of mass point --------------------------------------------------
                                hold(handles.SelectedCellAxis,'on')
                                    plot3(handles.SelectedCellAxis, X-Xmin, Y-Ymin, Z-Zmin,'.',...
                                        'MarkerSize',4,'Color',[0 0 0])
                                    plot3(handles.SelectedCellAxis, COM(1)-Xmin,...
                                        COM(2)-Ymin, COM(3)-Zmin,'.','MarkerSize',20,'Color','r')  
                                hold(handles.SelectedCellAxis,'off')
                       end
                       
                        

                     switch handles.DataFitMethod
                         case 'ellipsoidfit'
                            % Calculate Ellipsoid Equation Fit ----------------
                                [c, r, ev, v, chi2] = ellipsoid_fit([X Y Z], '' );
                            % Draw fit ----------------------------------------
                                mind = min( [ X Y Z ] );
                                maxd = max( [ X Y Z ] );
                                nsteps = 50;
                                step = ( maxd - mind ) / nsteps;
                                [Xm,Ym,Zm] = meshgrid( linspace( mind(1) - 20*step(1),...
                                                       maxd(1) + 20*step(1), nsteps ),...
                                                       linspace( mind(2) - 20*step(2),...
                                                       maxd(2) + 20*step(2), nsteps ),...
                                                       linspace( mind(3) - 20*step(3),...
                                                       maxd(3) + 20*step(3), nsteps ) );
                                %  v = the 10 parameters describing the ellipsoid/conic algebraically: 
                                %  Ax^2 + By^2 + Cz^2 + 2Dxy + 2Exz + 2Fyz + 2Gx + 2Hy + 2Iz + J = 0  
                                Ellipsoid = v(1) *Xm.*Xm +   v(2)*Ym.*Ym +   v(3) * Zm.*Zm + ...
                                          2*v(4) *Xm.*Ym + 2*v(5)*Xm.*Zm + 2*v(6) * Ym.*Zm + ...
                                          2*v(7) *Xm     + 2*v(8)*Ym     + 2*v(9) * Zm;
                                      
                                hold(handles.SelectedCellAxis,'on')
                                    p = patch(handles.SelectedCellAxis, ...
                                        isosurface( Xm-Xmin, Ym-Ymin, Zm-Zmin, Ellipsoid, -v(10) ) );
                                hold(handles.SelectedCellAxis,'off')
                                
                                set(p, 'FaceColor', [1 0 0], 'EdgeColor',[0.3 0 0],...
                                       'FaceAlpha',0.1,'EdgeAlpha',0.2 );

                                axmin = min([min(mean(p.XData)) min(X)]);
                                axmax = max([max(mean(p.XData)) max(X)]);
                                aymin = min([min(mean(p.YData)) min(Y)]);
                                aymax = max([max(mean(p.YData)) max(Y)]);
                                azmin = min([min(mean(p.ZData)) min(Z)]);
                                azmax = max([max(mean(p.ZData)) max(Z)]);
                                xpad = 0.1*(axmax-axmin);
                                ypad = 0.1*(aymax-aymin);
                                zpad = 0.1*(azmax-azmin);

%           axis(handles.SelectedCellAxis,[axmin - xpad - Xmin, axmax + xpad - Xmin, aymin - ypad - Ymin,...
%                                             aymax + ypad - Ymin, azmin - zpad - Zmin, azmax + zpad - Zmin])

                                [XL1,YL1,ZL1] = UnitVec2Line(ev(1,1),ev(2,1),ev(3,1),c(1),c(2),c(3),r(1)); 
                                [XL2,YL2,ZL2] = UnitVec2Line(ev(1,2),ev(2,2),ev(3,2),c(1),c(2),c(3),r(2));
                                [XL3,YL3,ZL3] = UnitVec2Line(ev(1,3),ev(2,3),ev(3,3),c(1),c(2),c(3),r(3));
                                
                                hold(handles.SelectedCellAxis,'on')
                                    plot3(handles.SelectedCellAxis, XL1-Xmin,YL1-Ymin,ZL1-Zmin, '-',...
                                        'LineWidth', 3, 'Color', [0   0   0.7]) % Plot Major Axis Line
                                    plot3(handles.SelectedCellAxis, XL2-Xmin,YL2-Ymin,ZL2-Zmin, '-',...
                                        'LineWidth', 2, 'Color', [0.7 0   0  ]) % 
                                    plot3(handles.SelectedCellAxis, XL3-Xmin,YL3-Ymin,ZL3-Zmin, '-',...
                                        'LineWidth', 2, 'Color', [0   0.5 0  ])
                                hold(handles.SelectedCellAxis,'off')
                                
                                % Calculate Minimum Bounding Circle on a plane perpendicular
                                % to R1 and intersecting Ellipsoid Center
                                    
                                    % C  = [c(1,1)-Xmin, c(2,1)-Ymin, c(3,1)-Zmin]; %  Center of Ellipsoid
                                    C  = [COM(1,1)-Xmin, COM(1,2)-Ymin, COM(1,3)-Zmin]; % Center of Cell
                                    R1 = [ev(1,1), ev(2,1), ev(3,1)];
                                    R2 = [ev(1,2), ev(2,2), ev(3,2)];
                                    R3 = [ev(1,3), ev(2,3), ev(3,3)];
                                    rmag = sqrt(r(2)^2 + r(3)^2);
                                    MBCD = CalculateMBCDIntersectingPlane(handles.SelectedCellAxis,...
                                                                          CellSurface, C, R1, R2, R3, rmag);   
                                                            
                                % ----------------------------------------------------------------------------
                                CellSize = handles.VoxelSize * handles.CellSizes(index,1);
                               
                                text1 = ['Cell: ', sprintf('%4.0d',index),  '      CellVolume: ', ...
                                                   sprintf('%#.6g',CellSize), ' ', ...
                                                   texlabel('mu'), 'm', texlabel('^3')];    
                                              
                                test1b = ['Center of Mass:   < ', sprintf('%#.5g',COM(1)), ', ',...
                                                                  sprintf('%#.5g',COM(2)), ', ',...
                                                                  sprintf('%#.5g',COM(3)), ' >'];
                                                             
                                test1c = ['Min Bounding Sphere Diam (MBSD): ',...
                                           sprintf('%#.5g',MinDiameter), ' ', texlabel('mu'), 'm'];
                                                             
                                text2  = ['Ellipsoid Center: < ', sprintf('%#.5g',c(1,1)),  ', ', ...
                                                                  sprintf('%#.5g',c(2,1)),  ', ',...
                                                                  sprintf('%#.5g',c(3,1)), ' >'];
                                                  
                                text3 = ['uVec1: [ ', sprintf('%+4.3f',ev(1,1)), '  ', ...
                                                      sprintf('%+4.3f',ev(2,1)), '  ', ...
                                                      sprintf('%+4.3f',ev(3,1)), ' ]  r1: ', ...
                                                      sprintf('%#.4g',r(1))];
                                                  
                                text4 = ['uVec2: [ ', sprintf('%+4.3f',ev(1,2)), '  ', ...
                                                      sprintf('%+4.3f',ev(2,2)), '  ', ...
                                                      sprintf('%+4.3f',ev(3,2)), ' ]  r2: ', ...
                                                      sprintf('%#.4g',r(2))];  
                                                  
                                text5 = ['uVec3: [ ', sprintf('%+4.3f',ev(1,3)), '  ', ...
                                                      sprintf('%+4.3f',ev(2,3)), '  ', ...
                                                       sprintf('%+4.3f',ev(3,3)), ' ]  r3: ', ...
                                                      sprintf('%#.4g',r(3))]; 
                                                  
                                EV = (4/3)*pi*r(1)*r(2)*r(3);
                                
                                text6  = ['r1/r2: ',        sprintf('%#.4g',r(1)./r(2)),...
                                          '  r2/r3: ',      sprintf('%#.4g',r(2)./r(3)),...
                                          '  EllipVol: ',   sprintf('%#.5g',EV)];
                                      
                                text6b = ['MBCD(' texlabel('mu') 'm): ' sprintf('%#.3g',MBCD), ' ',...
                                                 texlabel('mu'), 'm',...
                                          '         MBSD/MBCD: ' sprintf('%#.3g',MinDiameter/MBCD) ];     
                                
                                text7 = ['AveFitDev(AFD): ',     sprintf('%1.3f',sqrt(chi2./nVal)),...
                                         '  VolPerDiff(PVD): ',  ...
                                         sprintf('%#.3g',abs(100*(CellSize-EV)/CellSize))];
                                
                         case 'nofit'
                             %Draw Minimum Bounding Sphere ------------------------------------------------  
                             if ~isequal(MinDiameter,0)
                                    [SX,SY,SZ] = sphere(40);
                                    SX = (MinDiameter/2).*SX + SC(1) - Xmin;
                                    SY = (MinDiameter/2).*SY + SC(2) - Ymin;
                                    SZ = (MinDiameter/2).*SZ + SC(3) - Zmin;
                                hold(handles.SelectedCellAxis,'on')
                                    S = surf(handles.SelectedCellAxis,SX,SY,SZ);
                                    S.FaceAlpha = 0.05;
                                    S.FaceColor = [0,0,1];
                                    S.EdgeAlpha = 0.1;
                                    S.EdgeColor = 'none';
                                hold(handles.SelectedCellAxis,'off')
                             end
                             %-----------------------------------------------------------------------------  
                            CellSize = handles.VoxelSize * handles.CellSizes(index,1);
                            COM = handles.CellData{index}.CellCenterOfMass;
                            
                            text1 = ['Cell: ', sprintf('%4.0d',index),  '      CellVolume: ',...
                                      sprintf('%#.6g',CellSize), ' ', texlabel('mu'), 'm', texlabel('^3')];   
                                  
                            test1b = ['Center of Mass:   < ', sprintf('%#.5g',COM(1)), ', ',...
                                                              sprintf('%#.5g',COM(2)), ', ',...
                                                              sprintf('%#.5g',COM(3)), ' >'];
                                                         
                            test1c = ['Min Bounding Sphere Diam (MBSD): ',...
                                     sprintf('%#.3g',MinDiameter), ' ', texlabel('mu'), 'm'];
                            
                            text2  = 'Ellipsoid Center: ';
                            text3  = 'uVec1: ';
                            text4  = 'uVec2: ';
                            text5  = 'uVec3: '; 
                            text6  = 'r1/r2: ';
                            text6b = [ 'MBCD(', texlabel('mu'), 'm): ' ]; 
                            text7  = 'AveFitDev(AFD): ';
                     end
                    
                    set(handles.SelectedCellAxis,'Color',handles.MainFigure1.Color,...
                                       'FontSize',8,...
                                       'DataAspectRatio',[1 1 1],...
                                       'CameraPositionMode','auto','CameraTargetMode','auto',...
                                       'CameraUpVectorMode','auto','BoxStyle','full',...
                                       'CameraViewAngleMode','manual',...
                                       'CameraViewAngle',handles.SingleCellViewAngle,...
                                       'XColor',[0 0 0],...
                                       'YColor',[0 0 0],...
                                       'ZColor',[0 0 0],...
                                       'GridColor',[0 0 0])
                                   
                    rotate3d(handles.SelectedCellAxis,'on')  
                    
                    %######################################################################################  
                    % This code fixes MATLAB 'bug' that won't allow a figure's 
                    % Key-Press Functions to work while in Rotate3d mode
                    % http://undocumentedmatlab.com/blog/enabling-user-callbacks-during-zoom-pan       
                        handles = KeyPressWithRotate3DFix(handles);
                    % ######################################################################################  
                    
                    daspect(handles.SelectedCellAxis,[1,1,1])
                    view(handles.SelectedCellAxis,3)
                    camlight(handles.SelectedCellAxis,'left');
                    camlight(handles.SelectedCellAxis,'right')
                    lighting(handles.SelectedCellAxis,'gouraud')
                    camproj(handles.SelectedCellAxis,'perspective')
                    box(handles.SelectedCellAxis,'off')
                    grid(handles.SelectedCellAxis,'on')
                    axis(handles.SelectedCellAxis,'tight')       
                    xlabel(handles.SelectedCellAxis,'X (\mum)'); 
                    ylabel(handles.SelectedCellAxis,'Y (\mum)'); 
                    zlabel(handles.SelectedCellAxis,'Z (\mum)'); 
                    
                 %----------------------------------------------------------------------------------------- 
                    %set(0,'CurrentFigure',handles.MainFigure1)
                    %set(handles.MainFigure1,'CurrentAxes',handles.CellSpecsDisplayAxis)
                    set(handles.CellSpecsDisplayAxis,'Visible','off')
                    cla(handles.CellSpecsDisplayAxis)
                    axis(handles.CellSpecsDisplayAxis,[0 1 0 1])

                    handles.CellText3 = text(handles.CellSpecsDisplayAxis,0.07,0.85,{text1,test1b,test1c},...
                        'FontName','Monospaced','FontWeight','bold','FontSize',8.5,...
                        'Color',[0 0 0],  'Interpreter','tex');

                    handles.CellText = text(handles.CellSpecsDisplayAxis,0.07,-0.08,...
                        {text2,text3,text4,text5,text6,text6b,text7},...
                        'FontName','Monospaced','FontWeight','bold','FontSize',8.5,...
                        'Color',[0 0 0.8],'Interpreter','tex');

                    if handles.PartialCell(index,1)
                        text4 = 'Partial';
                        tc1 = [0.5 0 0];
                    else
                        text4 = 'Complete ';
                        tc1 = [0 0.5 0];
                    end

                    if handles.ObjVisible(index,1)
                        text5 = 'Visible';
                        tc2 = [0 0.5 0];
                    else
                        text5 = 'Hidden';
                        tc2 = [0.5 0 0];
                    end

                    handles.CellText2 = text(handles.CellSpecsDisplayAxis,0.28,-0.9,text4,...
                                        'FontName','Ariel','FontWeight','bold','FontSize',11,'Color',tc1);
                    handles.CellText3 = text(handles.CellSpecsDisplayAxis,0.50,-0.9,text5,...
                                        'FontName','Ariel','FontWeight','bold','FontSize',11,'Color',tc2);                     

        end   
        
        
%-------------------------------------------------------------------------------------------------------------
function handles = Update_Single_Cell(handles,n)
                
            %figure(handles.RenderingFigure)
            set(handles.RenderingFigure,'Color',handles.BackgroundColor)      
            set(handles.AxisHandle,'Color',handles.BackgroundColor,...
                                   'XColor',handles.AxesColor,...
                                   'YColor',handles.AxesColor,...
                                   'ZColor',handles.AxesColor,...
                                   'GridColor',handles.GridColor)
                    
            if handles.ShowFace 
                FC = handles.FaceColor; 
                FCC = 0.8.*handles.FaceColor;
            else
                FC = 'none'; 
                FCC = 'none';
            end

            if handles.ShowMesh 
                MC = handles.MeshColor; 
                MCC = 0.8.*handles.MeshColor;
            else
                MC = 'none'; 
                MCC = 'none';
            end
            
            if handles.ObjVisible(n,1)
                    if ~handles.ObjSelected(n,1)
                        set(handles.IsoSurfaceHandles{n,1},'FaceColor',FC,...
                                                           'EdgeColor',MCC,...
                                                           'FaceAlpha',handles.FaceTransparency/100,...
                                                           'EdgeAlpha',handles.MeshTransparency/100,...
                                                           'Visible','on',...
                                                           'ButtonDownFcn',@PatchBDF)

                            set(handles.IsoCapHandles{n,1},'FaceColor',FCC,...
                                                           'EdgeColor','none',...
                                                           'FaceAlpha',handles.FaceTransparency/100,...
                                                           'EdgeAlpha',handles.MeshTransparency/100,...
                                                           'Visible','on',...
                                                           'ButtonDownFcn',@PatchBDF)
                    else
                        set(handles.IsoSurfaceHandles{n,1},'FaceColor',handles.HighlightColor,...
                                                           'EdgeColor',0.5.*handles.HighlightColor,...
                                                           'FaceAlpha',handles.HLFaceTransparency/100,...
                                                           'EdgeAlpha',handles.HLMeshTransparency/100,...
                                                           'Visible','on',...
                                                           'ButtonDownFcn',@PatchBDF)

                            set(handles.IsoCapHandles{n,1},'FaceColor',handles.HighlightColor,...
                                                           'EdgeColor','none',...
                                                           'FaceAlpha',handles.HLFaceTransparency/100,...
                                                           'EdgeAlpha',handles.HLMeshTransparency/100,...
                                                           'Visible','on',...
                                                           'ButtonDownFcn',@PatchBDF)
                    end
            else
                    set(handles.IsoSurfaceHandles{n,1},'Visible','off')
                    set(handles.IsoCapHandles{n,1},'Visible','off')
            end
            drawnow
            
            
            
%------------------------------------------------------------------------------------------------------    
function handles = UpdateActionRecordingsForUNDO(handles)
    
    handles.UndoButtonRecordedVisActions = [handles.ObjVisible, handles.UndoButtonRecordedVisActions]; 

    if size(handles.UndoButtonRecordedVisActions,2) > handles.nRecordings
        handles.UndoButtonRecordedVisActions = handles.UndoButtonRecordedVisActions(:,1:handles.nRecordings);
    end
            
    
%------------------------------------------------------------------------------------------------------
function FH = WaitToUpdateRendering
    
        ScreenSize = get(0,'ScreenSize');  
        FH = figure;
        W = 320;
        H = 150;
        set(FH,'ToolBar','none','MenuBar','none','NumberTitle','off','Name','Updating Rendering',...
              'Position',[(ScreenSize(3)/2 - W/2) (ScreenSize(4)/2 - H/2) W H])  
        a = gca;
        set(a,'Visible','off','XLim',[0 1],'YLim',[0 1])  
        text(a,0,0.5,[{'Updating Rendering...'}],'FontSize',14,'FontName','Monospaced')  
        
        
        

% --- Creates and returns a handle to the GUI figure. 
function h1 = PopOut1_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', [], ...
    'taginfo', struct(...
    'figure', 2, ...
    'text', 15, ...
    'slider', 6, ...
    'checkbox', 5, ...
    'togglebutton', 2, ...
    'pushbutton', 7, ...
    'uipanel', 4, ...
    'popupmenu', 2, ...
    'edit', 2), ...
    'override', 0, ...
    'release', [], ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', 'C:\Matlab Files\LongAxis\LongAxis main program and subfunctions\Fig and Code files combined\PopOut1.m', ...
    'lastFilename', 'C:\Matlab Files\LongAxis\LongAxis main program and subfunctions\PopOut1.fig');
appdata.lastValidTag = 'figure1';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'figure1');

h1 = figure(...
'Units',get(0,'defaultfigureUnits'),...
'Position',[680 861 497 237],...
'Visible',get(0,'defaultfigureVisible'),...
'Color',get(0,'defaultfigureColor'),...
'IntegerHandle','off',...
'MenuBar','none',...
'Name','Longaxis pop-out controller',...
'NumberTitle','off',...
'HandleVisibility','callback',...
'Tag','figure1',...
'Resize','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'ScreenPixelsPerInchMode','manual',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel1';

h2 = uipanel(...
'Parent',h1,...
'FontUnits',get(0,'defaultuipanelFontUnits'),...
'Units','pixels',...
'Title',blanks(0),...
'Tag','uipanel1',...
'Position',[340 45.9999999999999 152 190],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'CamProjButton';

h3 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Proj: Perspective',...
'Style','togglebutton',...
'Position',[12 153 127 30],...
'Callback',@(hObject,eventdata)PopOut1('CamProjButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','CamProjButton',...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'));

appdata = [];
appdata.lastValidTag = 'ViewYZ_Button';

h4 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','View +YZ',...
'Style',get(0,'defaultuicontrolStyle'),...
'Position',[11 92 62 27],...
'Callback',@(hObject,eventdata)PopOut1('ViewYZ_Button_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewYZ_Button',...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'));

appdata = [];
appdata.lastValidTag = 'ViewXZ_Button';

h5 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','View +XZ',...
'Style',get(0,'defaultuicontrolStyle'),...
'Position',[11 122 62 27],...
'Callback',@(hObject,eventdata)PopOut1('ViewXZ_Button_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewXZ_Button',...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'));

appdata = [];
appdata.lastValidTag = 'ViewXY_Button';

h6 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','View +XY',...
'Style',get(0,'defaultuicontrolStyle'),...
'Position',[11 62 62 27],...
'Callback',@(hObject,eventdata)PopOut1('ViewXY_Button_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewXY_Button',...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'));

appdata = [];
appdata.lastValidTag = 'ViewNegYZ_Button';

h7 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','View -YZ',...
'Style',get(0,'defaultuicontrolStyle'),...
'Position',[78 92 62 27],...
'Callback',@(hObject,eventdata)PopOut1('ViewNegYZ_Button_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewNegYZ_Button',...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'));

appdata = [];
appdata.lastValidTag = 'ViewNegXZ_Button';

h8 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','View -XZ',...
'Style',get(0,'defaultuicontrolStyle'),...
'Position',[78 122 62 27],...
'Callback',@(hObject,eventdata)PopOut1('ViewNegXZ_Button_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewNegXZ_Button',...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'));

appdata = [];
appdata.lastValidTag = 'ViewNegXY_Button';

h9 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','View -XY',...
'Style',get(0,'defaultuicontrolStyle'),...
'Position',[78 62 62 27],...
'Callback',@(hObject,eventdata)PopOut1('ViewNegXY_Button_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewNegXY_Button',...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'));

appdata = [];
appdata.lastValidTag = 'ViewAngleDisplay';

h10 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','View Angle Zoom: 10',...
'Style','text',...
'Position',[15 9 122 15],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewAngleDisplay');

appdata = [];
appdata.lastValidTag = 'ViewAngleSlider';

h11 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String',blanks(0),...
'Style','slider',...
'Position',[15 27 123 20],...
'BackgroundColor',[0.9 0.9 0.9],...
'Callback',@(hObject,eventdata)PopOut1('ViewAngleSlider_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)PopOut1('ViewAngleSlider_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewAngleSlider',...
'KeyPressFcn',blanks(0));

appdata = [];
appdata.lastValidTag = 'uipanel2';

h12 = uipanel(...
'Parent',h1,...
'FontUnits',get(0,'defaultuipanelFontUnits'),...
'Units','pixels',...
'Title',blanks(0),...
'Tag','uipanel2',...
'Position',[1 50.9999999999999 340 185],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Y_Plane_Slider';

h13 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment',get(0,'defaultuicontrolHorizontalAlignment'),...
'ListboxTop',get(0,'defaultuicontrolListboxTop'),...
'Max',get(0,'defaultuicontrolMax'),...
'Min',get(0,'defaultuicontrolMin'),...
'SliderStep',get(0,'defaultuicontrolSliderStep'),...
'String',{  'Slider' },...
'Style','slider',...
'Value',get(0,'defaultuicontrolValue'),...
'Position',[16 76 194 17],...
'BackgroundColor',[0.9 0.9 0.9],...
'Callback',@(hObject,eventdata)PopOut1('Y_Plane_Slider_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ForegroundColor',get(0,'defaultuicontrolForegroundColor'),...
'Enable',get(0,'defaultuicontrolEnable'),...
'TooltipString',blanks(0),...
'Visible',get(0,'defaultuicontrolVisible'),...
'HandleVisibility',get(0,'defaultuicontrolHandleVisibility'),...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)PopOut1('Y_Plane_Slider_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','Y_Plane_Slider',...
'UserData',[],...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName',get(0,'defaultuicontrolFontName'),...
'FontAngle',get(0,'defaultuicontrolFontAngle'),...
'FontWeight',get(0,'defaultuicontrolFontWeight'));

appdata = [];
appdata.lastValidTag = 'X_Plane_Slider';

h14 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment',get(0,'defaultuicontrolHorizontalAlignment'),...
'ListboxTop',get(0,'defaultuicontrolListboxTop'),...
'Max',get(0,'defaultuicontrolMax'),...
'Min',get(0,'defaultuicontrolMin'),...
'SliderStep',get(0,'defaultuicontrolSliderStep'),...
'String',{  'Slider' },...
'Style','slider',...
'Value',get(0,'defaultuicontrolValue'),...
'Position',[16 120 194 17],...
'BackgroundColor',[0.9 0.9 0.9],...
'Callback',@(hObject,eventdata)PopOut1('X_Plane_Slider_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ForegroundColor',get(0,'defaultuicontrolForegroundColor'),...
'Enable',get(0,'defaultuicontrolEnable'),...
'TooltipString',blanks(0),...
'Visible',get(0,'defaultuicontrolVisible'),...
'HandleVisibility',get(0,'defaultuicontrolHandleVisibility'),...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)PopOut1('X_Plane_Slider_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','X_Plane_Slider',...
'UserData',[],...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName',get(0,'defaultuicontrolFontName'),...
'FontAngle',get(0,'defaultuicontrolFontAngle'),...
'FontWeight',get(0,'defaultuicontrolFontWeight'));

appdata = [];
appdata.lastValidTag = 'XLow';

h15 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','45.1',...
'Style','text',...
'Position',[15 101 76 17],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','XLow',...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName','Monospaced');

appdata = [];
appdata.lastValidTag = 'XHigh';

h16 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','right',...
'String','100.2',...
'Style','text',...
'Position',[125 101 81 17],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','XHigh',...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName','Monospaced');

appdata = [];
appdata.lastValidTag = 'XSliceCheck';

h17 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','X Slice',...
'Style','checkbox',...
'Position',[275 118 61 23],...
'Callback',@(hObject,eventdata)PopOut1('XSliceCheck_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','XSliceCheck',...
'KeyPressFcn',blanks(0));

appdata = [];
appdata.lastValidTag = 'XSliceDisplay';

h18 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','300.2',...
'Style','text',...
'Position',[213 118 58 20],...
'Children',[],...
'ForegroundColor',[0.63921568627451 0.0784313725490196 0.180392156862745],...
'Enable',get(0,'defaultuicontrolEnable'),...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','XSliceDisplay',...
'FontSize',10,...
'FontName','Monospaced',...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'YLow';

h19 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','45.1',...
'Style','text',...
'Position',[15 57 73 17],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','YLow',...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName','Monospaced');

appdata = [];
appdata.lastValidTag = 'YHigh';

h20 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','right',...
'String','100.2',...
'Style','text',...
'Position',[129 58 77 16],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','YHigh',...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName','Monospaced');

appdata = [];
appdata.lastValidTag = 'YSliceCheck';

h21 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Y Slice',...
'Style','checkbox',...
'Position',[275 74 61 23],...
'Callback',@(hObject,eventdata)PopOut1('YSliceCheck_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','YSliceCheck',...
'KeyPressFcn',blanks(0));

appdata = [];
appdata.lastValidTag = 'YSliceDisplay';

h22 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','300.2',...
'Style','text',...
'Position',[213 74 58 20],...
'Children',[],...
'ForegroundColor',[0.63921568627451 0.0784313725490196 0.180392156862745],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','YSliceDisplay',...
'FontSize',10,...
'FontName','Monospaced',...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'Z_Plane_Slider';

h23 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment',get(0,'defaultuicontrolHorizontalAlignment'),...
'ListboxTop',get(0,'defaultuicontrolListboxTop'),...
'Max',get(0,'defaultuicontrolMax'),...
'Min',get(0,'defaultuicontrolMin'),...
'SliderStep',get(0,'defaultuicontrolSliderStep'),...
'String',{  'Slider' },...
'Style','slider',...
'Value',get(0,'defaultuicontrolValue'),...
'Position',[16 33 194 17],...
'BackgroundColor',[0.9 0.9 0.9],...
'Callback',@(hObject,eventdata)PopOut1('Z_Plane_Slider_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ForegroundColor',get(0,'defaultuicontrolForegroundColor'),...
'Enable',get(0,'defaultuicontrolEnable'),...
'TooltipString',blanks(0),...
'Visible',get(0,'defaultuicontrolVisible'),...
'HandleVisibility',get(0,'defaultuicontrolHandleVisibility'),...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)PopOut1('Z_Plane_Slider_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','Z_Plane_Slider',...
'UserData',[],...
'KeyPressFcn',blanks(0),...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName',get(0,'defaultuicontrolFontName'),...
'FontAngle',get(0,'defaultuicontrolFontAngle'),...
'FontWeight',get(0,'defaultuicontrolFontWeight'));

appdata = [];
appdata.lastValidTag = 'ZLow';

h24 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','45.1',...
'Style','text',...
'Position',[15 15 76 16],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ZLow',...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName','Monospaced');

appdata = [];
appdata.lastValidTag = 'ZHigh';

h25 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','right',...
'String','100.2',...
'Style','text',...
'Position',[118 14 88 17],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ZHigh',...
'FontSize',get(0,'defaultuicontrolFontSize'),...
'FontName','Monospaced');

appdata = [];
appdata.lastValidTag = 'ZSliceCheck';

h26 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Z Slice',...
'Style','checkbox',...
'Position',[275 32 61 23],...
'Callback',@(hObject,eventdata)PopOut1('ZSliceCheck_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ZSliceCheck',...
'KeyPressFcn',blanks(0));

appdata = [];
appdata.lastValidTag = 'SliceTransparencySlider';

h27 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String',blanks(0),...
'Style','slider',...
'Position',[164 156 159 16],...
'BackgroundColor',[0.9 0.9 0.9],...
'Callback',@(hObject,eventdata)PopOut1('SliceTransparencySlider_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)PopOut1('SliceTransparencySlider_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','SliceTransparencySlider',...
'KeyPressFcn',blanks(0));

appdata = [];
appdata.lastValidTag = 'SliceTransparencyDisplay';

h28 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','Slice Transparency:   100 %',...
'Style','text',...
'Position',[18 157 144 15],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','SliceTransparencyDisplay');

appdata = [];
appdata.lastValidTag = 'ZSliceDisplay';

h29 = uicontrol(...
'Parent',h12,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','300.2',...
'Style','text',...
'Position',[214 31 58 20],...
'Children',[],...
'ForegroundColor',[0.63921568627451 0.0784313725490196 0.180392156862745],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ZSliceDisplay',...
'FontSize',10,...
'FontName','Monospaced',...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'uipanel3';

h30 = uipanel(...
'Parent',h1,...
'FontUnits',get(0,'defaultuipanelFontUnits'),...
'Units','pixels',...
'BorderType',get(0,'defaultuipanelBorderType'),...
'BorderWidth',get(0,'defaultuipanelBorderWidth'),...
'Title','View Cells Near Slice Plane',...
'ResizeFcn',blanks(0),...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','uipanel3',...
'Position',[4 2.99999999999989 490 54]);

appdata = [];
appdata.lastValidTag = 'ViewCellsNearSliceMenu';

h31 = uicontrol(...
'Parent',h30,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String',{  'OFF'; 'X-plane'; 'Y-plane'; 'Z-plane' },...
'Style','popupmenu',...
'Value',1,...
'ValueMode',get(0,'defaultuicontrolValueMode'),...
'Position',[18 9 106 25],...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)PopOut1('ViewCellsNearSliceMenu_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)PopOut1('ViewCellsNearSliceMenu_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewCellsNearSliceMenu',...
'KeyPressFcn',blanks(0),...
'FontSize',9);

appdata = [];
appdata.lastValidTag = 'ViewCellsNearSliceRangeInput';

h32 = uicontrol(...
'Parent',h30,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','10',...
'Style','edit',...
'Position',[154 10 34 25],...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)PopOut1('ViewCellsNearSliceRangeInput_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)PopOut1('ViewCellsNearSliceRangeInput_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ViewCellsNearSliceRangeInput',...
'KeyPressFcn',blanks(0),...
'FontSize',9);

appdata = [];
appdata.lastValidTag = 'text12';

h33 = uicontrol(...
'Parent',h30,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','right',...
'String','+/-',...
'Style','text',...
'Position',[124 14 27 16],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','text12',...
'FontSize',9,...
'FontName','Monospaced',...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'text13';

h34 = uicontrol(...
'Parent',h30,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'String','microns ',...
'Style','text',...
'Position',[192 14 58 16],...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','text13',...
'FontSize',9,...
'FontName','Monospaced',...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'SliceIsStepSizeCheckBox';

h35 = uicontrol(...
'Parent',h30,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Image Slice Step  = Slice Thickness',...
'Style','checkbox',...
'Position',[261 11 204 23],...
'Callback',@(hObject,eventdata)PopOut1('SliceIsStepSizeCheckBox_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','SliceIsStepSizeCheckBox',...
'KeyPressFcn',blanks(0));


hsingleton = h1;


% --- Set application data first then calling the CreateFcn. 
function local_CreateFcn(hObject, eventdata, createfcn, appdata)

if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   if isa(createfcn,'function_handle')
       createfcn(hObject, eventdata);
   else
       eval(createfcn);
   end
end


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)

gui_StateFields =  {'gui_Name'
    'gui_Singleton'
    'gui_OpeningFcn'
    'gui_OutputFcn'
    'gui_LayoutFcn'
    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error(message('MATLAB:guide:StateFieldNotFound', gui_StateFields{ i }, gui_Mfile));
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % POPOUT1
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % POPOUT1(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % POPOUT1('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % POPOUT1(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = true;
end

if ~gui_Create
    % In design time, we need to mark all components possibly created in
    % the coming callback evaluation as non-serializable. This way, they
    % will not be brought into GUIDE and not be saved in the figure file
    % when running/saving the GUI from GUIDE.
    designEval = false;
    if (numargin>1 && ishghandle(varargin{2}))
        fig = varargin{2};
        while ~isempty(fig) && ~ishghandle(fig,'figure')
            fig = get(fig,'parent');
        end
        
        designEval = isappdata(0,'CreatingGUIDEFigure') || (isscalar(fig)&&isprop(fig,'GUIDEFigure'));
    end
        
    if designEval
        beforeChildren = findall(fig);
    end
    
    % evaluate the callback now
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else       
        feval(varargin{:});
    end
    
    % Set serializable of objects created in the above callback to off in
    % design time. Need to check whether figure handle is still valid in
    % case the figure is deleted during the callback dispatching.
    if designEval && ishghandle(fig)
        set(setdiff(findall(fig),beforeChildren), 'Serializable','off');
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end

    % Check user passing 'visible' P/V pair first so that its value can be
    % used by oepnfig to prevent flickering
    gui_Visible = 'auto';
    gui_VisibleInput = '';
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        % Recognize 'visible' P/V pair
        len1 = min(length('visible'),length(varargin{index}));
        len2 = min(length('off'),length(varargin{index+1}));
        if ischar(varargin{index+1}) && strncmpi(varargin{index},'visible',len1) && len2 > 1
            if strncmpi(varargin{index+1},'off',len2)
                gui_Visible = 'invisible';
                gui_VisibleInput = 'off';
            elseif strncmpi(varargin{index+1},'on',len2)
                gui_Visible = 'visible';
                gui_VisibleInput = 'on';
            end
        end
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.

    
    % Do feval on layout code in m-file if it exists
    gui_Exported = ~isempty(gui_State.gui_LayoutFcn);
    % this application data is used to indicate the running mode of a GUIDE
    % GUI to distinguish it from the design mode of the GUI in GUIDE. it is
    % only used by actxproxy at this time.   
    setappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]),1);
    if gui_Exported
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);

        % make figure invisible here so that the visibility of figure is
        % consistent in OpeningFcn in the exported GUI case
        if isempty(gui_VisibleInput)
            gui_VisibleInput = get(gui_hFigure,'Visible');
        end
        set(gui_hFigure,'Visible','off')

        % openfig (called by local_openfig below) does this for guis without
        % the LayoutFcn. Be sure to do it here so guis show up on screen.
        movegui(gui_hFigure,'onscreen');
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        end
    end
    if isappdata(0, genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]))
        rmappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]));
    end

    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    % Singleton setting in the GUI MATLAB code file takes priority if different
    gui_Options.singleton = gui_State.gui_Singleton;

    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA. If there is
        % user set GUI data already, keep that also.
        data = guidata(gui_hFigure);
        handles = guihandles(gui_hFigure);
        if ~isempty(handles)
            if isempty(data)
                data = handles;
            else
                names = fieldnames(handles);
                for k=1:length(names)
                    data.(char(names(k)))=handles.(char(names(k)));
                end
            end
        end
        guidata(gui_hFigure, data);
    end

    % Apply input P/V pairs other than 'visible'
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        if ~strncmpi(varargin{index},'visible',len1)
            try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
        end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end

    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});

    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        % Handle the default callbacks of predefined toolbar tools in this
        % GUI, if any
        guidemfile('restoreToolbarToolPredefinedCallback',gui_hFigure); 
        
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);

        % Call openfig again to pick up the saved visibility or apply the
        % one passed in from the P/V pairs
        if ~gui_Exported
            gui_hFigure = local_openfig(gui_State.gui_Name, 'reuse',gui_Visible);
        elseif ~isempty(gui_VisibleInput)
            set(gui_hFigure,'Visible',gui_VisibleInput);
        end
        if strcmpi(get(gui_hFigure, 'Visible'), 'on')
            figure(gui_hFigure);
            
            if gui_Options.singleton
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        if isappdata(gui_hFigure,'InGUIInitialization')
            rmappdata(gui_hFigure,'InGUIInitialization');
        end

        % If handle visibility is set to 'callback', turn it on until
        % finished with OutputFcn
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end

    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end

    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end

function gui_hFigure = local_openfig(name, singleton, visible)

% openfig with three arguments was new from R13. Try to call that first, if
% failed, try the old openfig.
if nargin('openfig') == 2
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = matlab.hg.internal.openfigLegacy(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
else
    % Call version of openfig that accepts 'auto' option"
    gui_hFigure = matlab.hg.internal.openfigLegacy(name, singleton, visible);  
%     %workaround for CreateFcn not called to create ActiveX
%         peers=findobj(findall(allchild(gui_hFigure)),'type','uicontrol','style','text');    
%         for i=1:length(peers)
%             if isappdata(peers(i),'Control')
%                 actxproxy(peers(i));
%             end            
%         end
end

function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
end

function result = local_isInvokeHGCallback(gui_State, varargin)

try
    fhandle = functions(gui_State.gui_Callback);
    result = ~isempty(findstr(gui_State.gui_Name,fhandle.file)) || ...
             (ischar(varargin{1}) ...
             && isequal(ishghandle(varargin{2}), 1) ...
             && (~isempty(strfind(varargin{1},[get(varargin{2}, 'Tag'), '_'])) || ...
                ~isempty(strfind(varargin{1}, '_CreateFcn'))) );
catch
    result = false;
end


