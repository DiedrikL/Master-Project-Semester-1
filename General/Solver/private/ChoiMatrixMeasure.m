function Diff = ChoiMatrixMeasure(Hamiltonian, Gate)

    arguments
        Hamiltonian Hamiltonians.HamiltonianInterface
        Gate Gates.GateInterface
    end
        
    
    % Compare distance for a gate U with a given gate
    
    % Start positions
    Psi0 = Gate.Psi0;
    
    % Setup matrices
    index = size(Psi0, 2);
    U = zeros(index);

    exponent = size(factor(index),2);

    solveIndex = 2^exponent;
    matrixSize = solveIndex^2;
    scale = 1/2^solveIndex;
    targetGate = Gate.gate;

    
    part = zeros(solveIndex, solveIndex, matrixSize, matrixSize);
    targetPart = zeros(solveIndex, solveIndex, matrixSize, matrixSize);
    
    for n = 1:solveIndex
        for m = 1:solveIndex
            Rho = sparse(m, n, 1, solveIndex, solveIndex);
            ind = sub2ind([solveIndex, solveIndex], m, n);
            Hamiltonian.Rho = ind;
            part(m,n,:,:) = kron(SolveForStartValue(Hamiltonian, Psi0), Rho);
            targetPart(m,n,:,:) = kron(targetGate, eye(index)) * kron(Rho, Rho);
    
    
        end
    end
    Upart = part.*scale
    Tpart = targetPart.*scale
        
    U = sum(Upart, [3, 4])
    sqrU = sqrtm(U);
    TargetSum = sum(targetPart,[3, 4])
    content = sqrtm(sqrU*TargetSum*sqrU)
    
    
    Diff = trace(content)^2


end