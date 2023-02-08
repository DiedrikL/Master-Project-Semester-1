function U = SolveForStartValue(Hamiltonian, Psi0)
    arguments
        Hamiltonian Hamiltonians.Interfaces.HamiltonianInterface
        Psi0 double
    end

    % Setup matrices
    index = size(Psi0, 2);
    U = zeros(index);

    % Getting the solution for the start positions
    for n = 1:index
        [~, Psi] = SolveTDSEgeneral(Psi0(:,n), Hamiltonian);
        U(:,n) = Psi(:, end);
    end
end
    