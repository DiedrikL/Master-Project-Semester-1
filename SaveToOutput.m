function SaveToOutput(nameTmp)
% Saves a the workspace with a given filename in the output folder, creating
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
    


    save(fileName);
end

