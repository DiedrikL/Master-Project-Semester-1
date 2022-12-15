function SaveMatrixToOutput(matrix, name)
% Saves a given matrix with a given filename in the output folder, creating
% the output folder as necesary
    saveDirectory = 'Outputs';
    fileName = fullfile(saveDirectory, name);

    if ~exist(saveDirectory, 'dir')
        mkdir(saveDirectory);
    end
    
    writematrix(matrix, fileName);
end