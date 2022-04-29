function [Gradients] = CalculateGradients(parameters, Hamiltonian, gate, h, options)
    % Function that takes four inputs
    %
    % parameters the variables
    %
    % Hamiltonian a hamiltonian as a HamiltonianInterface
    %
    % gate a gate to compare to as a GateInterface
    %
    %

    arguments
        parameters(1,:) double
        Hamiltonian Hamiltonians.HamiltonianInterface
        gate Gates.GateInterface
        h(1,1) double = 1e-3;
        options.?SolveTDSEgeneral
    end


    vectorLength = length(parameters);
    Gradients = zeros(1,vectorLength);
       
    for n = 1:vectorLength
        [plussVector, minusVector] = CalculateVectors(parameters, h, n);
        Hpluss = Hamiltonian.createHamiltonian(plussVector, options)
        Hminus = Hamiltonian.createHamiltonian(minusVector, options)
        
        Gradients(n) = (MeasureDiffGeneral(Hpluss, gate, options) ...
            - MeasureDiffGeneral(Hminus, gate, options))/(2*h);
        
    end
end


            
