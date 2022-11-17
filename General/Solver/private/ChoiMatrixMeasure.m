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
            RhoVect = reshape(Rho,[],1);
            [~, solVect] = SolveTDSEgeneral(RhoVect, Hamiltonian);
            sol = reshape(solVect(:,end), index, index);
            part(m,n,:,:) = kron(sol, Rho);
            targetPart(m,n,:,:) = kron(targetGate, eye(index)) * kron(Rho, Rho);
    
    
        end
    end
    Upart = part.*scale;
    Tpart = targetPart.*scale;
        
    U = sum(Upart, [1, 2]);
    U = squeeze(U);
    sqrU = sqrtm(U);

    TargetSum = sum(targetPart,[1, 2]);
    TargetSum = squeeze(TargetSum);
    content = sqrtm(sqrU*TargetSum*sqrU);
    
    
    Diff = trace(abs(content))^2;

end