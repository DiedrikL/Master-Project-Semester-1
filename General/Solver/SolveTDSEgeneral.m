function [tVector, Solution] = SolveTDSEgeneral(psi, Hamiltonian)
    arguments
        psi double
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
    end

    funkSolver = Hamiltonian.Solver;

    switch funkSolver
        case HamiltSettings.Solvers.Crank_Nicolson

        case HamiltSettings.Solvers.Runge_Kutta

        otherwise
            error('Unknown solver')
    end
    
    [tVector, Solution] = funkSolver.solver(psi, Hamiltonian);
end
