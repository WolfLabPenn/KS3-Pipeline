%% Code by Ehsan Mirzakhalili
%  ehsan.mirzakhalili@gmail.com
%  ehsan.mirzakhalili@pennmedicine.upenn.edu
%  mirzakh@umich.edu
%  5/25/2022
%  MATLAB 9.11.0.1769968 (R2021b)
function [samples,header,time_stamps]=read_CSC(path_to_read,channels_to_read,options)

arguments
    path_to_read
    channels_to_read
    options.sign (1,1) double = -1;
    options.extension (1,:) char='';
    options.header (1,1) logical = true;
    options.timestamps (1,1) logical = true;
end
%%
path_to_read=fullfile(path_to_read);
%%
if options.timestamps
    flags.time_stamps=1;
else
    flags.time_stamps=0;
end
flags.channel_numbers = 0;
flags.sampling_frequency = 1;
flags.valid_samples= 1;
flags.samples = 1;
if options.header
    flags.header = 1;
else
    flags.header = 0;
end
flags.mode = 1;
%%
num_channels=length(channels_to_read);
%%
list=dir(fullfile(path_to_read,'*.ncs'));
for i=1:size(list,1)
    [channel_number,filename]=find_channel(list(i).name,options.extension);
    if channel_number==channels_to_read(1)
        data=import_CSC(fullfile(path_to_read,filename),flags);
        break;
    end
end
%%
flags.time_stamps=0;
if options.header
    header=data.header;
else
    header=[];
end
%%
%%
valid_samples=data.valid_samples;
%%
length_data=512*size(data.samples,2);
size_channels=[num_channels,length_data];
samples=zeros(size_channels,'int16');
%%
if options.timestamps
    dt=1./data.sampling_frequency*1e6;
    block=0:511;
    inner_block=block'*dt;
    time_stamps=data.time_stamps+inner_block;
    time_stamps=reshape(time_stamps,1,length_data);
else
    time_stamps=[];
end
%%
samples(1,:)=int16(reshape(data.samples,1,length_data));
%%
flags.time_stamps=0;
flags.channel_numbers = 0;
flags.sampling_frequency = 0;
flags.valid_samples= 0;
flags.samples = 1;
flags.header = 0;
flags.mode = 1;
%%
I=1;
if num_channels>1
    for i=channels_to_read(2:end)
        for j=1:size(list,1)
            [channel_number,filename]=find_channel(list(j).name,options.extension);
            if channel_number==i
                I=I+1;
                data=import_CSC(fullfile(path_to_read,filename),flags);
                samples(I,:)=int16(reshape(data.samples,1,length_data));
            end
        end
    end
end
%%
samples=options.sign*samples;
%%
length_valid=sum(valid_samples);
if length_data~=length_valid
    samples=samples(:,1:length_valid);
end