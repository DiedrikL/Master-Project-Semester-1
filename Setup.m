% Small script to add folders and subfolders to path

% Get paht to current folder with General subfolder
base = pwd;
folder = 'General';
basePath = fullfile(base, folder);

% Generate and add path for all subfolders
path = genpath(basePath);
addpath(path);

% Create save directory if it don't exist
saveDirectory = 'Outputs';
if ~isfolder(saveDirectory)
    mkdir(saveDirectory);
end


% Clear variables from memory
clear base folder basePath path saveDirectory
