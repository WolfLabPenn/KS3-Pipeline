function [ADBitVolts,SamplingFrequency]=read_header(filename)
temp = regexp(fileread(filename),'\n','split');
l = find(contains(temp,'ADBitVolts'));
ADBitVolts=str2double(regexp(temp{l},'\d+\.?\d*','match','once'));
l= find(contains(temp,'SamplingFrequency'));
SamplingFrequency=str2double(regexp(temp{l},'\d+\.?\d*','match','once'));
end