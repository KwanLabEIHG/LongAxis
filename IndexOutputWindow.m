%%% START of IndexOutputWindow.m code
% ------------------------------------------------------------------------------------------------------------

function varargout = IndexOutputWindow(varargin)
% INDEXOUTPUTWINDOW MATLAB code for IndexOutputWindow.fig
%      INDEXOUTPUTWINDOW, by itself, creates a new INDEXOUTPUTWINDOW or raises the existing
%      singleton*.
%
%      H = INDEXOUTPUTWINDOW returns the handle to a new INDEXOUTPUTWINDOW or the handle to
%      the existing singleton*.
%
%      INDEXOUTPUTWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INDEXOUTPUTWINDOW.M with the given input arguments.
%
%      INDEXOUTPUTWINDOW('Property','Value',...) creates a new INDEXOUTPUTWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IndexOutputWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IndexOutputWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IndexOutputWindow

% Last Modified by GUIDE v2.5 06-Aug-2019 09:42:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IndexOutputWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @IndexOutputWindow_OutputFcn, ...
                   'gui_LayoutFcn',  @IndexOutputWindow_LayoutFcn, ...
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


%-------------------------------------------------------------------------------------
function IndexOutputWindow_OpeningFcn(hObject, eventdata, handles, varargin)

    handles.output = hObject;
    
    if ~isempty(varargin)
        handles.LongAxisHandle = varargin{1};
        LAHANDLES = guidata(handles.LongAxisHandle);
        handles.CSV = LAHANDLES.CSV; 
       
        
        set(handles.CellindicesTextBox,'Min',0,'Max',2,'String',handles.CSV)
        uicontrol(handles.CopyTextButton)
   
    end
    
    % Update handles structure
    guidata(hObject, handles);


%-------------------------------------------------------------------------------------
function varargout = IndexOutputWindow_OutputFcn(hObject, eventdata, handles) 

    varargout{1} = handles.output;


%-------------------------------------------------------------------------------------
function CellindicesTextBox_Callback(hObject, eventdata, handles)



%-------------------------------------------------------------------------------------
function CellindicesTextBox_CreateFcn(hObject, eventdata, handles)

    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


%-------------------------------------------------------------------------------------
function CloseButton_Callback(hObject, eventdata, handles)

    MainFigure_CloseRequestFcn(handles.MainFigure, eventdata, handles);

%-------------------------------------------------------------------------------------
function MainFigure_CloseRequestFcn(hObject, eventdata, handles)

    delete(hObject);

%-------------------------------------------------------------------------------------
function SaveButton_Callback(hObject, eventdata, handles)

    [FileName, PathName] = uiputfile('*.txt','Select filename and save location','Visible_Cell_Numbers');
    
    if ~isequal(FileName,0)
        fileID = fopen([PathName, FileName],'w');
        fprintf(fileID,'%s', handles.CSV)
        fclose(fileID)
    end
%-------------------------------------------------------------------------------------


% --- Executes on button press in CopyTextButton.
function CopyTextButton_Callback(hObject, eventdata, handles)

        clipboard('copy',handles.CSV)
        
        fp = get(handles.MainFigure,'Position');
        
        % Position [X Y W H]
        f = figure('NumberTitle','off','Position',[fp(1)+fp(3)/2-100  fp(2)+fp(4)/2-50 200 100],'Name','Visible Cell Indices',...
           'Resize','off','Toolbar','none','WindowStyle','normal','MenuBar','none');   
       
        uicontrol('Parent',f,'Style','text','FontName','FixedWidth','FontWeight','bold','FontSize',16,...
              'String','COPIED!!!','Position',[40 40 180 30],'HorizontalAlignment','Left');
        
        pause(0.5)
        close(f)
        
        
        
        
        


% --- Creates and returns a handle to the GUI figure. 
function h1 = IndexOutputWindow_LayoutFcn(policy)
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
    'edit', 2, ...
    'pushbutton', 4, ...
    'text', 2, ...
    'uipanel', 2), ...
    'override', 0, ...
    'release', 13, ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', 'C:\Matlab Files\LongAxis\LongAxis main program and subfunctions\Fig and Code files combined\IndexOutputWindow.m', ...
    'lastFilename', 'C:\Matlab Files\LongAxis\LongAxis main program and subfunctions\IndexOutputWindow.fig');
appdata.lastValidTag = 'MainFigure';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'MainFigure');

h1 = figure(...
'Units',get(0,'defaultfigureUnits'),...
'Position',[520 267 360 533],...
'Visible','on',...
'Color',get(0,'defaultfigureColor'),...
'CloseRequestFcn',@(hObject,eventdata)IndexOutputWindow('MainFigure_CloseRequestFcn',hObject,eventdata,guidata(hObject)),...
'IntegerHandle','off',...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'MenuBar','none',...
'NumberTitle','off',...
'HandleVisibility','callback',...
'Tag','MainFigure',...
'UserData',[],...
'Resize','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
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
'Title','Cell Indices :',...
'Tag','uipanel1',...
'Position',[8 69 344 455],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'CellindicesTextBox';

h3 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'HorizontalAlignment','left',...
'Style','edit',...
'Position',[17 68 308 362],...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)IndexOutputWindow('CellindicesTextBox_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)IndexOutputWindow('CellindicesTextBox_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','CellindicesTextBox');

appdata = [];
appdata.lastValidTag = 'SaveButton';

h4 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Save',...
'Position',[200 16 120 37],...
'Callback',@(hObject,eventdata)IndexOutputWindow('SaveButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'Tag','SaveButton',...
'FontSize',12,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'CopyTextButton';

h5 = uicontrol(...
'Parent',h2,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Copy Text',...
'Position',[29 15 120 37],...
'Callback',@(hObject,eventdata)IndexOutputWindow('CopyTextButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'ButtonDownFcn',blanks(0),...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'DeleteFcn',blanks(0),...
'Tag','CopyTextButton',...
'KeyPressFcn',blanks(0),...
'FontSize',12,...
'FontWeight','bold');

appdata = [];
appdata.lastValidTag = 'CloseButton';

h6 = uicontrol(...
'Parent',h1,...
'Units',get(0,'defaultuicontrolUnits'),...
'FontUnits',get(0,'defaultuicontrolFontUnits'),...
'String','Close',...
'Position',[117 16 106 26],...
'Callback',@(hObject,eventdata)IndexOutputWindow('CloseButton_Callback',hObject,eventdata,guidata(hObject)),...
'Children',[],...
'BusyAction','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} ,...
'Tag','CloseButton',...
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
    % INDEXOUTPUTWINDOW
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % INDEXOUTPUTWINDOW(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % INDEXOUTPUTWINDOW('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % INDEXOUTPUTWINDOW(...)
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


