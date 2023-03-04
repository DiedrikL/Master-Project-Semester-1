function Diff = MeasureDiffGeneral(Hamiltonian, options)
    % Function that measures the difference from a given gate for the
    % Hamiltonian. 
    %
    % H the hamiltonian function handle
    %
    % gate must be a subclass of GateInterface, and is the gate to compare to,
    % default Hadamard
    
    arguments
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
        options.Gate Gates.GateInterface = Gates.Hadamard;
    end
    
    Gate = options.Gate;
    
    
    % Compare infidelity for a gate U with a given gate
    
    % get measure
    measure = Hamiltonian.Measure;
    
    % Use selected measure
    switch measure
        case Measure.NormDistance
            Diff = NormDistance(Hamiltonian, Gate);
    
        case Measure.AvgFidelity
            Diff = AverageGateFidelity(Hamiltonian, Gate);
    
        case Measure.ChoiFidelity
            Diff = 1-ChoiMatrixMeasure(Hamiltonian, Gate);
    
        otherwise
            error('Wrong measure value')
    end
end
