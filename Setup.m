% Small script to add folders and subfolders to path

% Get paht to current folder with General subfolder
base = pwd;
folder = 'General';
basePath = fullfile(base, folder);

% Generate and add path for all subfolders
path = genpath(basePath);
addpath(path);

% Clear variables from memory
clear base folder basePath path
