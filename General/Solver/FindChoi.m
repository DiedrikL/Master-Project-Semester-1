function Solution = FindChoi(Lindbladian)
% Function that finds the effect on the lindbladian
%
% H the hamiltonian function handle


arguments
    Lindbladian Hamiltonians.Interfaces.LindbladInterface
end


% Finds the size of the hamiltonian
RhoSize = Lindbladian.rhoSize;

index = RhoSize^2;

% Start positions

% Setup matrices
Choi = zeros(index);

% Getting the solution for the start positions
for n = 1:index
    Rho0 = zeros(RhoSize);
    Rho0(n) = 1;
    Rho = SolveFunk.SolveForRho(Lindbladian, Rho0, RhoSize);
    choiPart = kron(Rho, Rho0);
    Choi = Choi + choiPart;
end

% Scaling the answer
Solution = Choi/double(RhoSize);
