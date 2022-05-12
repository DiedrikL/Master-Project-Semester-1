function [plusVector, minusVector] = CalculateVectors(parameters, h, location)
    % Calculates the next variables for calculateGradients. It takes three
    % parameters
    %
    % Parameters is an (1,:) array of the parameters
    %
    % h is how much plus or minus each parameter should be
    %
    % location is what parameter to change
    
    % Sets up vectors
    plusVector = parameters;
    plusVector(location) = plusVector(location) + h;
    
    minusVector = parameters;
    minusVector(location) = minusVector(location) - h;    
end