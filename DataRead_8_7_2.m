
close all force
clear all
%% Load control and cancer datasets and save them into a single .mat file
%% Cancer data 
dirName = '/Users/dixon/Documents/TAMU/Ovarian/data3/Cancer/';              %# folder path

files = dir( fullfile(dirName,'*.csv') );   %# list all *.xyz files
files = {files.name}';                      %'# file names

nfi = numel(files);
data = cell(nfi,1);                %# store file contents

Ca=[];
for i=1:nfi
    fname = fullfile(dirName,files{i});     %# full path to file
  %  data{i} = myLoadFunction(fname); 
    data{i} = csvread(fname,2.0);
    Ca=[Ca data{i}(:,2)];
    %# load file
end

ovarian13.Ca = Ca;

%% Controld data 
dirName = '/Users/dixon/Documents/TAMU/Ovarian/data3/Control/';              %# folder path
files = dir( fullfile(dirName,'*.csv') );   %# list all *.xyz files
files = {files.name}';                      %'# file names

nfi = numel(files);
data = cell(nfi,1);                %# store file contents

Co=[];
for i=1:nfi
    fname = fullfile(dirName,files{i});     %# full path to file
  %  data{i} = myLoadFunction(fname); 
    data{i} = csvread(fname,2.0);
    Co=[Co data{i}(:,2)];
    %# load file
end

ovarian13.Co = Co;
moz = data{1}(:,1);
ovarian13.moz = moz;

%% Save data into a .mat file at the given path.
save ovarian13.mat  ovarian13 -mat


