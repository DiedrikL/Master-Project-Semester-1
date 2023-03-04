function Diff = AverageGateFidelity(Hamiltonian, Gate)
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
index = double(Hamiltonian.matrixSize);


% Solving the shrödinger equation
U = SolveForStartValue(Hamiltonian, Psi0);

% loading the gate matrix
targetGate = Gate.gate;

% Average fidelity
Diff = 1-(abs(trace(U'*targetGate))^2 +index)/(index^2 +index);
