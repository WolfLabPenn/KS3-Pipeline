function rez=call_KS3(path_to_sort)

options=load(fullfile(path_to_sort,'options')).options;
addpath(genpath('./Kilosort3')) % path to kilosort folder

rootZ = path_to_sort; % the raw data binary file is in this folder

% find the binary file
options.fbinary = fullfile(rootZ, 'binary_data.dat');

rez                = preprocessDataSub(options);
rez                = datashift2(rez, 1);

[rez, st3, tF]     = extract_spikes(rez);

rez                = template_learning(rez, tF, st3);

[rez, st3, tF]     = trackAndSort(rez);

rez                = final_clustering(rez, tF, st3);

rez                = find_merges(rez, 1);

if options.remove_duplicate
    rez = remove_ks3_duplicate_spikes(rez);
    rez                = find_merges(rez, 1);
end
rootZ = fullfile(rootZ);

rezToPhy2(rez, rootZ);
save (fullfile(rootZ,'Results'),'rez')

%%
