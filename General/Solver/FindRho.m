function Solution = FindRho(Lindbladian)
% Function that finds the effect on the hamiltonian
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
Solution = zeros(RhoSize);

% Getting the solution for the start positions
for n = 1:index
    Rho0 = zeros(RhoSize);
    Rho0(n) = 1;
    [Rho] = SolveTDSEgeneral(Rho0, Lindbladian);
    Solution = Solution + Rho;
end

% Scaling the answer
% Solution = Solution;
