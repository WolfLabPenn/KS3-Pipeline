%% This script calls all the necessary functions
clc;
clear;
%%
addpath(genpath('./Functions')) % path to function folder
%%
% If you do not need to do any of the steps, change the flag from true to false
read_and_write=true; % The flag that controls generating the binary file
create_electrode=true; % The flag that controls generating electrode map
create_config=true; % The flag that controls generating config file
sort_units=true; % The flag that controls calling KS3.
%% The folder where all the resutls are saved.
path_to_sort=fullfile('your_path_to_save_data');
[status,msg,msgID]=mkdir(path_to_sort);
temp=clock;
copyfile('main.m', [path_to_sort,'/main_',char(datetime('today')),'_',num2str(temp(4)),'_',num2str(temp(5)),'.m'], 'f');
if ~isempty(msg)
    warning(msg)
    answer = questdlg({msg;'Do you want to continue?'},'Warning','Yes','No','No');
    if strcmp(answer,'No')
        return;
    else
        warning('Potential overwriting of data. Please manually stop the code if you chose to continue by accident');
    end
end
%% Generating the binary file
if read_and_write
    % The path where CSC files are located at.
    paths_to_read{1,:}='X:\PIG_ARCHIVE_AND_SOPS\PIG_ARCHIVE\JAW_102_23\2_EPHYS_and_BEHAVIOR_DATA\BEHAVIOR\Track_DATA\5-26-23\2023-05-26_10-50-05';
    % The extension of CSC files. Use "" if they do not have any.
    extensions{1}="";
    % Channels to read.
    channels=1:128;
    % Invert the signal
    sign=-1;
    % Calling the function
    write_to_sort(paths_to_read,extensions,channels,sign,path_to_sort);
end
%% Generating the channel map
if create_electrode
    % Name of the map
    map_name='Linear_128';
    % Order of the channels
    map=1:128;
    % Bad channels. If none or you do not care, use bad_channels=[];
    bad_channels=[1,4,10,16,18,20,22,24,28,30,32,34,36,44,46];
    % x coordinates of channels with the same order listed in map 
    x=zeros(128,1); % Linear electrode
    % y coordinates of channels with the same order listed in map 
    y=0:-40:-40*127; % Linear electrode with spacing of 40 um.
    %map_name='ASSY-77-E-1_Shank_2';
    %remap=[21,22,23,28,24,32,30,26,29,25,16,17,18,19,20,27,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,31,64,63,62,61,60,59,58,57,56,55,54,53,52,51,50,34,44,43,42,37,41,33,35,39,36,40,49,48,47,46,45,38];
    %[x,y,id]=read_probe('./Probes/ASSY-77-E-1.json',remap=remap,plot=false);
    %x=x(17:32);
    %y=y(17:32);
    %map=1:16;
    % Calling the function that creates the channel map
    create_channel_map(map,bad_channels,x,y,map_name,path_to_sort);
end
%% Generating the configuration file.
% Call the functions with options you want to change.
if create_config
    create_config_file(path_to_sort,map_name);
end
%%
if sort_units
    Results=call_KS3(path_to_sort);
end
