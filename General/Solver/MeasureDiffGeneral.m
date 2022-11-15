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
    
    % Setup matrices
    index = size(Psi0, 2);
    U = zeros(index);
    
    function U = solveForStartValue(Hamiltonian)
        % Getting the solution for the start positions
        for n = 1:index
            [~, Psi] = SolveTDSEgeneral(Psi0(:,n), Hamiltonian);
            for m = 1:index
                U(m,n) = Psi(m, end);
            end
        end
    end
    
    
    targetGate = Gate.gate;
    
    measure = Hamiltonian.Measure;
    
    switch measure
        case Measure.NormDistance
            U = solveForStartValue(Hamiltonian);
            % Measure distance with norm
            U = Gate.rotation(U);
            % Measuring distance
            Diff = norm(U-targetGate);
    
    
        case Measure.AvgFidelity
            U = solveForStartValue(Hamiltonian);
            % Measure with average gate fidelity
            Diff = 1-(abs(trace(U'*targetGate))^2 +index)/(index^2 +index);
    
        case Measure.ChoiFidelity
            solveIndex = index^2;
            Upart = zeros(solveIndex);

            for o = 1:solveIndex
                Hamiltonian.Rho = o;
                Upart(o) = solveForStartValue(Hamiltonian);
            end

            U = sum(Upart, 'all');

            error('Not finished')
    
        otherwise
            error('Wrong measure value')
    end
end
