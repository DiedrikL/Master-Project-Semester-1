% Setup parameters
range = 10;
minimum = 0;
learning = 1e-3;
HGate = Gates.RandomUnitary;


% Result matrices
parameters = rand(1,6).*range+minimum;

Hamiltonian = Hamiltonians.TwoParticleMultiInteractionHamiltonian(Parameters = parameters);


% Compare distance for a gate U with a given gate

% Start positions
Psi0 = eye(4);

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
U
