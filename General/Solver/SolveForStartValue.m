function U = SolveForStartValue(Hamiltonian, Psi0)
    arguments
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
        Psi0 double
    end

    % Setup matrices
    Hsize = Hamiltonian.matrixSize;
    index = size(Psi0, 2);
    U = zeros(Hsize,index);

    % Getting the solution for the start positions
    for n = 1:index
        [Psi] = UseSolver(Psi0(:,n), Hamiltonian);
        U(:,n) = Psi;
    end
end
    