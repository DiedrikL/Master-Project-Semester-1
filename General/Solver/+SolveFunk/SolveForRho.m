function U = SolveForRho(Hamiltonian, Rho, index)
% Reshapes Rho for solver functions that cannot take rho as matrix before
% usinging the solver function
    arguments
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
        Rho double
        index int8
    end

    solver = Hamiltonian.Solver;
    
    switch solver
        case HamiltSettings.Solvers.Runge_Kutta_Rho
            % Straightforward solver that uses rho

            U = solver.solver(Rho, Hamiltonian);
        
        case {HamiltSettings.Solvers.Crank_Nicolson, HamiltSettings.Solvers.Runge_Kutta}
            % Solver that uses rho as vector instead of matrix, needs
            % transpose to conserve row wise structure

            RhoVector = reshape(transpose(Rho), 1, []);
            solution = solver.solver(RhoVector, Hamiltonian);
            U = transpose(reshape(solution, index, index));

        otherwise
            error('Unown solver')
    end
end