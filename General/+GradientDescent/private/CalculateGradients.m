function [Gradients] = CalculateGradients(parameters, Hamiltonian, Gate, options)
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
    parameters should deviate from the input

    % Validate input
    arguments
        parameters(1,:) double
        Hamiltonian Hamiltonians.HamiltonianInterface
        Gate Gates.GateInterface
        options.h(1,1) double = 1e-3;
    end
    
    h = options.h;
    
    % Extract time
    Time = Hamiltonian.Time;
    
    % initialize vector
    vectorLength = length(parameters);
    Gradients = zeros(1,vectorLength);
       
    % For each parameter, find it's gradient
    for n = 1:vectorLength
        [plussVector, minusVector] = CalculateVectors(parameters, h, n);
        Hpluss = Hamiltonian.createHamiltonian(plussVector);
        Hminus = Hamiltonian.createHamiltonian(minusVector);
        Gradients(n) = (MeasureDiffGeneral(Hpluss, Gate=Gate, Time=Time)...
            - MeasureDiffGeneral(Hminus, Gate=Gate, Time=Time))/(2*h);
        
    end
end


            
