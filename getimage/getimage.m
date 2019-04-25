function getimage
%GETIMAGE Return renamed high quality images at desired location indicated by user;
%
% Line Width is changeable at 1st row
%
% Font Size is changable at 2nd row
%clc;
%   Line width recommended is 2
linew = 2;
%   Font Size recommended is 14-18 optimal 16
fontsizes = 14;
%   Resolution is 300DPI, if higher desired, change to 600 in line below
resolution = '-r300';


%% DO NOT CHANGE THE CODES BEYOND THIS PART!!!
persistent lastPath 

% If this is the first time running the function this session,
% Initialize lastPath to 0
if isempty(lastPath)
    lastPath = 0;
end


% Looking for opening figures
figHandles = findobj('Type', 'figure');

% Change Line Widths
hh = findobj(figHandles,'-depth',1,'-property','LineWidth');
set(hh,'LineWidth',linew);


% Change Background Color to white (default)
ss = findobj(figHandles,'flat','-property','Color');
set(ss,'Color',[1 1 1]);

% Change Font Size including all legend objects
wordsize = findobj(figHandles,'-property','FontSize');
set(wordsize,'FontSize',fontsizes);



%% Saving loop
% Define file formats
condition = {'*.tif';'*.png';'*.bmp'};

for kk = 1:1:length(figHandles)
    %% Get Input
    
    % Name each file according to the figure number
    filenaming = sprintf('Image_%d',kk);
    
    
    
    % All subsequent calls, use the path to the last selected file          
    
    if lastPath == 0
        
        [filname,filpath,indx] = uiputfile(condition,'Select Output Folder',filenaming);
    else
        
        filenaming = strcat(lastPath,filenaming);
        [filname,filpath,indx] = uiputfile(condition,'Select Output Folder',filenaming);
    end
    
    
    % Cancel operation if nothing obtained, or else save it as last path
    % accessed
    if filpath == 0
        return
    else
        lastPath = filpath;
    end
    
    % Save file as format
    
    switch indx
        case 3
            
            formattype = '-bmp';
            
        case 2
            
            formattype = '-png';
            
        case 1
            
            formattype = '-tif';
            
    end
    
    nameq = strcat(filpath,filname);
    export_fig(figHandles(kk),nameq,resolution,formattype);
    
end


end