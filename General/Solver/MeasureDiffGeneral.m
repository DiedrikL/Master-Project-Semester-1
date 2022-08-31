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

% Getting the solution for the start positions
for n = 1:index
    [~, Psi] = SolveTDSEgeneral(Psi0(:,n), Hamiltonian);
    for m = 1:index
        U(m,n) = Psi(m, end);
    end
end

psi0 = [1;0];
psi1 = [0;1];


targetGate = Gate.gate;

U = Gate.rotation(U);


% Measuring distance
Diff = norm(U-targetGate);