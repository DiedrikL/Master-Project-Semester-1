function [Gradients] = CalculateGradients(Hamiltonian, Gate, options)
    % Function that takes four inputs and optional inputs
    %
    % parameters the variables the function should find the gradients to
    %
    % Hamiltonian a hamiltonian of the type HamiltonianInterface
    %
    % gate is a gate to compare to of the type GateInterface
    %
    % Time is a TimeOptions that specifies time period and scale.
    %
    % It has an optional input h with a default value that is how far the
    % parameters should deviate from the input

    % Validate input
    arguments
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
        Gate Gates.GateInterface
        options.h(1,1) double = 1e-3;
    end
    
    h = options.h;
    
    % Extract parameters
    para = Hamiltonian.Parameters;
    
    % initialize vector
    vectorLength = length(para);
    Gradients = zeros(1,vectorLength);
       
    % For each parameter, find it's gradient
    for n = 1:vectorLength
        [plussVector, minusVector] = CalculateVectors(para, h, n);
        Hamiltonian.Parameters = plussVector;
        Hpluss = MeasureDiffGeneral(Hamiltonian, Gate=Gate);
        
        Hamiltonian.Parameters = minusVector;
        Hminus = MeasureDiffGeneral(Hamiltonian, Gate=Gate);
        
        Gradients(n) = (Hpluss - Hminus)/(2*h);
        
    end
end


            
