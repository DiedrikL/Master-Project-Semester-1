
function Diff = NormDistance(Hamiltonian, Gate)
% Function that measures the difference from a given gate for the
% Hamiltonian. 
%
% Hamiltonian is of the class HamiltonianInterface
%
% Gate must be a subclass of GateInterface, and is the gate to compare to,
% default Hadamard

arguments
    Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
    Gate Gates.GateInterface
end


% Compare distance for a gate U with a given gate

% Start positions
Psi0 = Gate.Psi0;

% Setup target gate
targetGate = Gate.gate;


% Solve with startvalues in Psi0
U = SolveForStartValue(Hamiltonian, Psi0);

% Rotate to reduce effect of global phase
U = Gate.rotation(U);

% Measuring distance
Diff = norm(U-targetGate);


