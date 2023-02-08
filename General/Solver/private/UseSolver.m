function [tVector, Solution] = UseSolver(psi, Hamiltonian)
    arguments
        psi double
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
    end

    solver = Hamiltonian.Solver;

    switch solver
        case HamiltSettings.Solvers.Crank_Nicolson
            [time, solv] = solver.solver(psi, Hamiltonian);

        case HamiltSettings.Solvers.Runge_Kutta
            [time, solv] = solver.solver(rho, Hamiltonian);

        else
            error('Unknown solver')
    end

    tVector = time;
    Solution = solv;
end
