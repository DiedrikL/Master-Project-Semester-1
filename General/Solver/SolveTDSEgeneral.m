function [Solution] = SolveTDSEgeneral(psi, Hamiltonian)
    arguments
        psi double
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
    end

    funkSolver = Hamiltonian.Solver;
    
    [Solution] = funkSolver.solver(psi, Hamiltonian);
end
