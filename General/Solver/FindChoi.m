function Solution = FindChoi(Lindbladian)
% Function that finds the effect on the lindbladian for all possible values
% of rho
%
% Lindbladian is the lindblad function handle


arguments
    Lindbladian Hamiltonians.Interfaces.LindbladInterface
end


% Finds the size of the hamiltonian
RhoSize = Lindbladian.rhoSize;

index = RhoSize^2;


% Setup matrices
Choi = zeros(index);

% Getting the solution for the different start positions
for n = 1:index
    Rho0 = zeros(RhoSize);
    Rho0(n) = 1;
    Rho = SolveFunk.SolveForRho(Lindbladian, Rho0, RhoSize);
    choiPart = kron(Rho, Rho0);
    Choi = Choi + choiPart;
end

% Scaling and returning the answer
Solution = Choi/double(RhoSize);
