addpath(genpath('./Functions')) % path to function folder
%%
map_name='Shank_2'; % Name of the channel map
map(:,1)=1:128; % Order of the channels
%% Bad channels. 
% If you do not have bad channels or want to include them in your sorting,
% leave this variable empty: bad_channels=[];
bad_channels=[7, 10, 15]; 
%%
% X coordinates of the contacts with the same order defined in map
x(1:2:16)=0;
x(2:2:16)=10;
%%
% Y coordinates of the contacts with the same order defined in map
y=0:-5:-5*15;
%%
% Where all the results will be saved.
path_to_sort='Somewhere on your computer';
%%
% Calling the function that creates the channel map
create_channel_map(map,bad_channels,x,y,map_name,path_to_sort);