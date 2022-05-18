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
psi0 = [1;0];
psi1 = [0;1];

% Getting the solution for the start positions
[~, Psi1] = SolveTDSEgeneral(psi0, Hamiltonian);
[~, Psi2] = SolveTDSEgeneral(psi1, Hamiltonian);

% Creating the gate
U1 = [Psi1(1, end); Psi1(2, end)];
U2 = [Psi2(1, end); Psi2(2, end)];
U = [U1, U2];

targetGate = Gate.gate;

U = Gate.rotation(U);


% Measuring distance
Diff = norm(U-targetGate);