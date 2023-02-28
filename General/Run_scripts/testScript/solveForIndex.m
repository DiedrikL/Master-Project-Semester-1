function choiPart = solveForIndex(Lindblad, rhoSize, index)
    arguments
        Lindblad Hamiltonians.Interfaces.HamiltonianInterface
        rhoSize(1,1) int8
        index(1,1) int8
    end
    
    Rho0 = zeros(rhoSize);
    Rho0(index) = 1;
    Rho = SolveFunk.SolveForRho(Lindblad, Rho0, rhoSize);
    choiPart = kron(Rho, Rho0);
end