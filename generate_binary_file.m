addpath(genpath('./Functions')) % path to function folder
% Add the paths where the CSC files are located at
paths_to_read{1,:}='A';
paths_to_read{2,:}='B';
%%
% Include the extension of CSC files. The extension is the part between CSC
% and .ncs. If the recordings you are interested in are CSC1.ncs, CSC2.ncs,
% then the extension is empty ("").
% Make sure the extensions are within "" and not ''.
extensions{1}="";
extensions{2}(1)="";
extensions{2}(2)="_0001";
%%
% The channels that you interested in. You do not need to exclude the bad
% channels.
channels=17:32;
%%
% Where all the results will be saved.
path_to_sort='Somewhere on your computer';
%%
% Calling the function that generates the binary file
sign=-1; %Inverting the recording
write_to_sort(paths_to_read,extensions,channels,sign,path_to_sort);