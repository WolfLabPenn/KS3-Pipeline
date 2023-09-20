%%
addpath(genpath('./Functions')) % path to function folder
%%
addpath(genpath('./Functions')) % path to function folder
% Where all the results will be saved.
path_to_sort='Somewhere on your computer';
%%
% Name of the channel map
map_name='Shank_2'; 
%%
% Calling the function that creates the configuration file
create_config_file(path_to_sort,map_name);
% If you want to change any of the options, I recommand calling
% create_config_file with the modifeid option instead of changing the
% function itself. For example, let's say you only want sort units starting
% at t=10s to t=60s and change whitening range to 8. Then, you can use the following command:
% create_config_file(path_to_sort,map_name, trange=[10,60],whiteningRange=8);