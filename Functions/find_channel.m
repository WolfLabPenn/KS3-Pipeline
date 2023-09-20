%% Code by Ehsan Mirzakhalili
%  ehsan.mirzakhalili@gmail.com
%  ehsan.mirzakhalili@pennmedicine.upenn.edu
%  mirzakh@umich.edu
%  5/25/2022
%  MATLAB 9.11.0.1769968 (R2021b)
function [channel_number,clean_name]=find_channel(test_string,extension)
channel_number=[];
clean_name=[];
dot_loc=strfind(test_string,'.ncs');
check=true;
pass=true;
if ~isempty(dot_loc)
    clean_name=test_string(1:dot_loc+3);
    if ~isempty(extension)
        if isempty(regexp(clean_name,extension,'Match'))
            check=false;
        end
    end
    if check==true
        temp=regexp(clean_name,'\d*','Match');
        if length(temp)>1
            if ~isempty(extension)
                pass=true;
            else
                pass=false;
            end
        end
        if pass==true
            channel_number=str2double(temp{1,1});
            test=str2double(temp{1,1});
            if isnan(test)
                temp=test_string(dot_loc-1);
                test=str2double(temp);
                if isnan(test)

                else
                    channel_number=test;
                end
            else
                channel_number=test;
            end
        end
    end
end