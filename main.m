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
path_to_sort=fullfile('');
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
    x=zeros(16,1); % Linear electrode
    % y coordinates of channels with the same order listed in map 
    y=0:-40:-40*127; % Linear electrode with spacing of 40 um.
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
