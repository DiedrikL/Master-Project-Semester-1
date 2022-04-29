function [plusVector, minusVector] = CalculateVectors(parameters, h, location)
    % Calculates the next variables for calculateGradients
    
    % Sets up vectors
    plusVector = parameters;
    plusVector(location) = plusVector(location) + h;
    
    minusVector = parameters;
    minusVector(location) = minusVector(location) + h;    
end