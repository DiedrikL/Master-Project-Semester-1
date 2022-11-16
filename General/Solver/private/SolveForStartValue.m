function U = SolveForStartValue(Hamiltonian, Psi0)
    arguments
        Hamiltonian Hamiltonians.HamiltonianInterface
        Psi0 double
    end

    % Setup matrices
    index = size(Psi0, 2);
    U = zeros(index);

    % Getting the solution for the start positions
    for n = 1:index
        [~, Psi] = SolveTDSEgeneral(Psi0(:,n), Hamiltonian);
        for m = 1:index
            U(m,n) = Psi(m, end);
        end
    end
end
    