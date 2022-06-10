%%% START of IndexInputWindow.m code
% ------------------------------------------------------------------------------------------------------------


function varargout = IndexInputWindow(varargin)
    % INDEXINPUTWINDOW MATLAB code for IndexInputWindow.fig
    %      INDEXINPUTWINDOW, by itself, creates a new INDEXINPUTWINDOW or raises the existing
    %      singleton*.
    %
    %      H = INDEXINPUTWINDOW returns the handle to a new INDEXINPUTWINDOW or the handle to
    %      the existing singleton*.
    %
    %      INDEXINPUTWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in INDEXINPUTWINDOW.M with the given input arguments.
    %
    %      INDEXINPUTWINDOW('Property','Value',...) creates a new INDEXINPUTWINDOW or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before IndexInputWindow_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to IndexInputWindow_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help IndexInputWindow

    % Last Modified by GUIDE v2.5 06-Aug-2019 09:42:39

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @IndexInputWindow_OpeningFcn, ...
                       'gui_OutputFcn',  @IndexInputWindow_OutputFcn, ...
                       'gui_LayoutFcn',  @IndexInputWindow_LayoutFcn, ...
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


%-------------------------------------------------------------------------
function IndexInputWindow_OpeningFcn(hObject, eventdata, handles, varargin)
        
        % Choose default command line output for IndexInputWindow
            set(handles.CellIndexInput,'Min',1,'Max',20,'Value',1,'HorizontalAlignment','left')
            handles.output = hObject;
            if ~isempty(varargin)
                handles.LongAxisMainHandle = varargin{1};
            end
        % Update handles structure
            guidata(hObject, handles);

%-------------------------------------------------------------------------
function varargout = IndexInputWindow_OutputFcn(hObject, eventdata, handles) 
        
        % varargout{1} = handles.output;
          varargout{1} = handles;

%-------------------------------------------------------------------------
function CellIndexInput_Callback(hObject, eventdata, handles)
   


%-------------------------------------------------------------------------
function CellIndexInput_CreateFcn(hObject, eventdata, handles)
        
        if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
            set(hObject,'BackgroundColor','white');
        end

%-------------------------------------------------------------------------
function CloseButton_Callback(hObject, eventdata, handles)

        MainFigure2_CloseRequestFcn(handles.MainFigure2, eventdata, handles)

%-------------------------------------------------------------------------
function PasteTextButton_Callback(hObject, eventdata, handles)

        txt = clipboard('paste');
        temp = double(txt);
        temp(temp == 10) = 44;
        txt = char(temp);
        set(handles.CellIndexInput,'String',txt)

%%-------------------------------------------------------------------------
function ClearButton_Callback(hObject, eventdata, handles)

        set(handles.CellIndexInput,'String',' ')

%-------------------------------------------------------------------------
function MainFigure2_CloseRequestFcn(hObject, eventdata, handles)
        
        delete(hObject);

%-------------------------------------------------------------------------
function VisibleButton_Callback(hObject, eventdata, handles)

        FH = WaitToUpdateRendering;
        drawnow
        LAhandles = guidata(handles.LongAxisMainHandle);
        
        %-- Record Visibility State for Undo Button -----------------------------------------------------
            LAhandles = UpdateActionRecordingsForUNDO(LAhandles);
        %------------------------------------------------------------------------------------------------  

        Str = get(handles.CellIndexInput,'String');
        C = textscan(Str,'%f','delimiter',',');
        CellIndices = (C{1})';
        
        LAhandles.ObjVisible(CellIndices,1) = true;
        nObjects = length(LAhandles.IsoSurfaceHandles);
        LAhandles.ObjSelected = false(nObjects,1);

        for n = CellIndices
                set(LAhandles.IsoSurfaceHandles{n,1},'Visible','on')
                set(LAhandles.IsoCapHandles{n,1}    ,'Visible','on')
        end
        drawnow
        
        % Update Cell List ----------------------------------------------------------
        LAhandles.CellList.String = CreateCellListStringArray(LAhandles.CellIndices,...
                                                              LAhandles.CellSizes,...
                                                              LAhandles.ObjVisible,...
                                                              LAhandles.ObjSelected);
        % ---------------------------------------------------------------------------
        set(0,'CurrentFigure',LAhandles.RenderingFigure)
        nvis = sum(double(LAhandles.ObjVisible));
        set(LAhandles.nCellsVisibleDisplay,'String',['nCells Visible: ' num2str(nvis)])       
        
        try; close(FH); end
        
        guidata(handles.LongAxisMainHandle,LAhandles)
            
%-------------------------------------------------------------------------
function HighlightButton_Callback(hObject, eventdata, handles)
            
        FH = WaitToUpdateRendering;
        
        Str = get(handles.CellIndexInput,'String');
        C = textscan(Str,'%f','delimiter',',');
        CellIndices = C{1};

        LAhandles = guidata(handles.LongAxisMainHandle);
        nObjects = length(LAhandles.IsoSurfaceHandles);
        LAhandles.ObjSelected(CellIndices,1) = true;

        for n = (CellIndices)'
            set(LAhandles.IsoSurfaceHandles{n,1},'FaceColor',LAhandles.HighlightColor);
            set(LAhandles.IsoSurfaceHandles{n,1},'FaceAlpha',LAhandles.HLFaceTransparency/100);
            set(LAhandles.IsoSurfaceHandles{n,1},'EdgeAlpha',LAhandles.HLMeshTransparency/100);
        end
        drawnow
        
        % Update Cell List ----------------------------------------------------------
        LAhandles.CellList.String = CreateCellListStringArray(LAhandles.CellIndices,...
                                                              LAhandles.CellSizes,...
                                                              LAhandles.ObjVisible,...
                                                              LAhandles.ObjSelected);
        % ---------------------------------------------------------------------------

        set(0,'CurrentFigure',LAhandles.RenderingFigure)
        nvis = sum(double(LAhandles.ObjVisible));
        set(LAhandles.nCellsVisibleDisplay,'String',['nCells Visible: ' num2str(nvis)])
        
        try close(FH); end
        
        guidata(handles.LongAxisMainHandle,LAhandles)

%-------------------------------------------------------------------------
function HideButton_Callback(hObject, eventdata, handles)

        FH = WaitToUpdateRendering;
        drawnow
        LAhandles = guidata(handles.LongAxisMainHandle);
        
        %-- Record Visibility State for Undo Button -----------------------------------------------------
            LAhandles = UpdateActionRecordingsForUNDO(LAhandles);
        %------------------------------------------------------------------------------------------------  

        Str = get(handles.CellIndexInput,'String');
        C = textscan(Str,'%f','delimiter',',');
        CellIndices = (C{1})';

        LAhandles.ObjVisible(CellIndices,1) = false;
        nObjects = length(LAhandles.IsoSurfaceHandles);
        LAhandles.ObjSelected = false(nObjects,1);

        for n = CellIndices
                set(LAhandles.IsoSurfaceHandles{n,1},'Visible','off')
                set(LAhandles.IsoCapHandles{n,1},    'Visible','off')
        end
        
        drawnow
        
        % Update Cell List ----------------------------------------------------------
        LAhandles.CellList.String = CreateCellListStringArray(LAhandles.CellIndices,...
                                                              LAhandles.CellSizes,...
                                                              LAhandles.ObjVisible,...
                                                              LAhandles.ObjSelected);
        % ---------------------------------------------------------------------------
        set(0,'CurrentFigure',LAhandles.RenderingFigure)
        nvis = sum(double(LAhandles.ObjVisible));
        set(LAhandles.nCellsVisibleDisplay,'String',['nCells Visible: ' num2str(nvis)])
        
        try close(FH); end
        
        guidata(handles.LongAxisMainHandle,LAhandles)

        
%------------------------------------------------------------------------        
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

%-------------------------------------------------------------------------------------------------------------
function UnHighlightButton_Callback(hObject, eventdata, handles)

            FH = WaitToUpdateRendering;
    
            Str = get(handles.CellIndexInput,'String');
            C = textscan(Str,'%f','delimiter',',');
            CellIndices = C{1};

            LAhandles = guidata(handles.LongAxisMainHandle);
            nObjects = length(LAhandles.IsoSurfaceHandles);
            LAhandles.ObjSelected(CellIndices,1) = false;

            for n = (CellIndices)'
                set(LAhandles.IsoSurfaceHandles{n,1},'FaceColor',LAhandles.FaceColor);
                set(LAhandles.IsoSurfaceHandles{n,1},'FaceAlpha',LAhandles.FaceTransparency/100);
                set(LAhandles.IsoSurfaceHandles{n,1},'EdgeAlpha',LAhandles.MeshTransparency/100);
            end
            drawnow
            
            % Update Cell List -----------------------------------------------------------------------------------
            LAhandles.CellList.String = CreateCellListStringArray(LAhandles.CellIndices, LAhandles.CellSizes,...
                                                                  LAhandles.ObjVisible, LAhandles.ObjSelected);
            % ----------------------------------------------------------------------------------------------------
                
            set(0,'CurrentFigure',LAhandles.RenderingFigure)
            nvis = sum(double(LAhandles.ObjVisible));
            set(LAhandles.nCellsVisibleDisplay,'String',['nCells Visible: ' num2str(nvis)])
            
            try close(FH); end
            
            guidata(handles.LongAxisMainHandle,LAhandles)

%---------------------------------------------------------------------------------------------------------------        
function handles = Update_Single_Cell(handles,n)
           
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
                                                           'EdgeColor','none',... % 0.5.*handles.HighlightColor,...
                                                           'FaceAlpha',handles.FaceTransparency/100,...
                                                           'EdgeAlpha',handles.MeshTransparency/100,...
                                                           'Visible','on',...
                                                           'ButtonDownFcn',@PatchBDF)

                            set(handles.IsoCapHandles{n,1},'FaceColor',handles.HighlightColor,...
                                                           'EdgeColor','none',...
                                                           'FaceAlpha',handles.FaceTransparency/100,...
                                                           'EdgeAlpha',handles.MeshTransparency/100,...
                                                           'Visible','on',...
                                                           'ButtonDownFcn',@PatchBDF)
                    end
            else
                    set(handles.IsoSurfaceHandles{n,1},'Visible','off')
                    set(handles.IsoCapHandles{n,1},'Visible','off')
            end

            
%---------------------------------------------------------------------------------------------------------------------    
function handles = UpdateActionRecordingsForUNDO(handles)
    
        handles.UndoButtonRecordedVisActions = [handles.ObjVisible, handles.UndoButtonRecordedVisActions]; 
        
        if size(handles.UndoButtonRecordedVisActions,2) > handles.nRecordings
            handles.UndoButtonRecordedVisActions = handles.UndoButtonRecordedVisActions(:,1:handles.nRecordings);
        end
        
%--------------------------------------------------------------------------------------------------------------   
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
function h1 = IndexInputWindow_LayoutFcn(policy)
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
    'text', 2, ...
    'uipanel', 3, ...
    'edit', 2, ...
    'pushbutton', 11), ...
    'override', 0, ...
    'release', [], ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', 'C:\Matlab Files\LongAxis\LongAxis main program and subfunctions\Fig and Code files combined\IndexInputWindow.m', ...
    'lastFilename', 'C:\Matlab Files\LongAxis\LongAxis main program and subfunctions\IndexInputWindow.fig');
appdata.lastValidTag = 'MainFigure2';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'MainFigure2');

h1 = figure(...
'Units',get(0,'defaultfigureUnits'),...
'Position',[680 668 403 453],...
'Visible',get(0,'defaultfigureVisible'),...
'Color',get(0,'defaultfigureColor'),...
'CloseRequestFcn',@(hObject,eventdata)IndexInputWindow('MainFigure2_CloseRequestFcn',hObject,eventdata,guidata(hObject)),...
'IntegerHandle','off',...
'MenuBar','none',...
'Name','IndexInputWindow',...
'NumberTitle','off',...
'HandleVisibility','callback',...
'Tag','MainFigure2',...
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
'BorderType','beveledin',...
'BorderWidth',2,...
'Title','Input Cell Indices',...
'Tag','uipanel1',...
'Position',[8 52 387 391],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'CellIndexInput';

h3 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String',blanks(0),...
'Style','edit',...
'Position',[20 193 348 172],...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)IndexInputWindow('CellIndexInput_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)IndexInputWindow('CellIndexInput_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','CellIndexInput');

appdata = [];
appdata.lastValidTag = 'PasteTextButton';

h4 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Paste Text',...
'Position',[51 152 120 29],...
'Callback',@(hObject,eventdata)IndexInputWindow('PasteTextButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','PasteTextButton',...
'KeyPressFcn',blanks(0),...
'FontSize',12,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'ClearButton';

h5 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Clear',...
'Position',[221 152 120 29],...
'Callback',@(hObject,eventdata)IndexInputWindow('ClearButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','ClearButton',...
'KeyPressFcn',blanks(0),...
'FontSize',12,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'uipanel2';

h6 = uipanel(...
'Parent',h2,...
'FontUnits',get(0,'defaultuipanelFontUnits'),...
'Units','pixels',...
'BorderType','beveledout',...
'BorderWidth',2,...
'Title','Cell Function',...
'Tag','uipanel2',...
'Position',[61 24 270 109],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'VisibleButton';

h7 = uicontrol(...
'Parent',h6,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Visible',...
'Position',[21 56 100 28],...
'Callback',@(hObject,eventdata)IndexInputWindow('VisibleButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ForegroundColor',[0.63921568627451 0.0784313725490196 0.180392156862745],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','VisibleButton',...
'KeyPressFcn',blanks(0),...
'FontSize',9,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'HighlightButton';

h8 = uicontrol(...
'Parent',h6,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Highlight',...
'Position',[149 56 100 28],...
'Callback',@(hObject,eventdata)IndexInputWindow('HighlightButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ForegroundColor',[0.63921568627451 0.0784313725490196 0.180392156862745],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','HighlightButton',...
'KeyPressFcn',blanks(0),...
'FontSize',9,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'HideButton';

h9 = uicontrol(...
'Parent',h6,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Hide',...
'Position',[21 16 100 28],...
'Callback',@(hObject,eventdata)IndexInputWindow('HideButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ForegroundColor',[0.63921568627451 0.0784313725490196 0.180392156862745],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','HideButton',...
'KeyPressFcn',blanks(0),...
'FontSize',9,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'UnHighlightButton';

h10 = uicontrol(...
'Parent',h6,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Un-Highlight',...
'Position',[149 16 100 28],...
'Callback',@(hObject,eventdata)IndexInputWindow('UnHighlightButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ForegroundColor',[0.63921568627451 0.0784313725490196 0.180392156862745],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','UnHighlightButton',...
'KeyPressFcn',blanks(0),...
'FontSize',9,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'CloseButton';

h11 = uicontrol(...
'Parent',h1,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Close',...
'Position',[146 13 106 26],...
'Callback',@(hObject,eventdata)IndexInputWindow('CloseButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','CloseButton',...
'KeyPressFcn',blanks(0),...
'FontSize',10);


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
    % INDEXINPUTWINDOW
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % INDEXINPUTWINDOW(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % INDEXINPUTWINDOW('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % INDEXINPUTWINDOW(...)
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


