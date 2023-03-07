function SaveMatrixToOutput(matrix, nameTmp)
% Saves a given matrix with a given filename in the output folder, creating
% the output folder as necesary
    saveDirectory = 'Outputs';
    d = string(datetime('now'));
    redName = regexprep(nameTmp, '[0.]', '')

    formatSpec = string(redName)+'_%s';
    name = sprintf(formatSpec, d);
    nameFormat = regexprep(name, '[\s:.]', '_');
    fileName = fullfile(saveDirectory, nameFormat);

    if ~exist(saveDirectory, 'dir')
        mkdir(saveDirectory);
    end
    
    writematrix(matrix, fileName);
end