function Diff = MeasureDiffGeneral(Hamiltonian, options)
    % Function that measures the difference from a given gate for the
    % Hamiltonian. 
    %
    % H the hamiltonian function handle
    %
    % gate must be a subclass of GateInterface, and is the gate to compare to,
    % default Hadamard
    
    arguments
        Hamiltonian Hamiltonians.HamiltonianInterface
        options.Gate Gates.GateInterface = Gates.Hadamard;
    end
    
    Gate = options.Gate;
    
    
    % Compare distance for a gate U with a given gate
    
    % Start positions
    Psi0 = options.Gate.Psi0;
    
    % Setup target and measure
    targetGate = Gate.gate;
    
    measure = Hamiltonian.Measure;
    
    % Use selected measure
    switch measure
        case Measure.NormDistance
            U = solveForStartValue(Hamiltonian, Psi0);
            % Measure distance with norm
            U = Gate.rotation(U);
            % Measuring distance
            Diff = norm(U-targetGate);
    
    
        case Measure.AvgFidelity
            U = SolveForStartValue(Hamiltonian, Psi0);
            % Measure with average gate fidelity
            index = size(Psi0, 2);
            Diff = 1-(abs(trace(U'*targetGate))^2 +index)/(index^2 +index);
    
        case Measure.ChoiFidelity
            Diff = 1-ChoiMatrixMeasure(Hamiltonian, Gate);
    
        otherwise
            error('Wrong measure value')
    end
end
