function U = FindU(Hamiltonian)
% Function that finds the effect on the hamiltonian
%
% H the hamiltonian function handle


arguments
    Hamiltonian Hamiltonians.HamiltonianInterface
end


% Finds the size of the hamiltonian
H = Hamiltonian.createHamiltonian;
Hmatrice = H(0);
Hsize = size(Hmatrice);

% Start positions
Psi0 = eye(Hsize);

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


% showing U
U;