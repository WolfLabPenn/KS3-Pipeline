%% Code by Ehsan Mirzakhalili
%  ehsan.mirzakhalili@gmail.com
%  ehsan.mirzakhalili@pennmedicine.upenn.edu
%  mirzakh@umich.edu
%  5/25/2022
%  MATLAB 9.11.0.1769968 (R2021b)
function write_to_sort(paths_to_read,extension,channels,sign,path_to_write)
I=0;
for i=1:size(paths_to_read,1)
    for j=1:length(extension{i})
        I=I+1;
        disp("Initial reading:")
        disp(paths_to_read{i})
        disp(['CSC',extension{i}(j)])
        [test,header,time_stamps]=read_CSC(paths_to_read{i},channels(1),sign=sign,extension=extension{i}(j),header=true,timestamps=true);
        writecell(header,fullfile(path_to_write,sprintf('Header_%0.0f.txt',I)));
        save(fullfile(path_to_write,sprintf('Timestamps_%0.0f',I)),'time_stamps');
        l(I)=length(test);
    end
end
clear time_stamps test
l=[0,l];
ls=cumsum(l);
data=zeros(length(channels)*sum(l),1,'int16');
I=0;
for i=1:size(paths_to_read,1)
    for j=1:length(extension{i})
        I=I+1;
        disp("Main reading:")
        disp(paths_to_read{i})
        disp(['CSC',extension{i}(j)])
        [samples,~,~]=read_CSC(paths_to_read{i},channels,sign=sign,extension=extension{i}(j),header=false,timestamps=false);
        try
        data((ls(I))*length(channels)+1:ls(I+1)*length(channels))=samples(:);
        catch
            keyboard;
        end
        clear samples;
    end
end
disp('Writing binary file')
fid=fopen(fullfile(path_to_write,'binary_data.dat'),'W');
fwrite(fid,data(:),'int16');
fclose(fid);
disp('Finished')