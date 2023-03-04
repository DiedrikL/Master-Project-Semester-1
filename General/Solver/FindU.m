function U = FindU(Hamiltonian)
% Function that finds the effect on the hamiltonian
%
% H the hamiltonian function handle


arguments
    Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
end


% Finds the size of the hamiltonian
Hsize = Hamiltonian.matrixSize;

% Start positions
Psi0 = eye(Hsize);

% Setup matrices
index = Hsize;
U = zeros(index);

% Getting the solution for the start positions
for n = 1:index
    [Psi] = UseSolver(Psi0(:,n), Hamiltonian);
    U(:,n) = Psi(:);
end


% showing U
U;