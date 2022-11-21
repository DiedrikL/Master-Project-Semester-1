function Diff = ChoiMatrixMeasure(Lindbladian, Gate)

    arguments
        Lindbladian Hamiltonians.HamiltonianInterface
        Gate Gates.GateInterface
    end
        
    
    % Compare distance for a gate U with a given gate
    
    % Start positions
    Psi0 = Gate.Psi0;
    
    % Setup matrices
    psiSize = size(Psi0, 2);

    exponent = size(factor(psiSize),2);

    index = 2^exponent;
    matrixSize = index^2;
    scale = 1/index;
    targetGate = Gate.gate;

    
    part = zeros(index, index, matrixSize, matrixSize);
    targetPart = zeros(index, index, matrixSize, matrixSize);
    
    for n = 1:index
        for m = 1:index
            Rho = sparse(m, n, 1, index, index);
            RhoVector = reshape(Rho,[],1);
            [~, solutionMatrix] = SolveTDSEgeneral(RhoVector, Lindbladian);
            lindbladSolution = reshape(solutionMatrix(:,end), index, index);
            part(m,n,:,:) = kron(lindbladSolution, Rho);

            targetPart(m,n,:,:) = kron(targetGate*Rho*targetGate', Rho);
    
    
        end
    end
        
    % Sums and reduces the parts of the choi matrix
    Choi = sum(part, [1, 2]);
    Choi = squeeze(Choi);
    Choi = Choi.*scale;
    sqrChoi = sqrtm(Choi);

    % Sums and reduces the kron products of the target gate
    TargetSum = sum(targetPart,[1, 2]);
    TargetSum = squeeze(TargetSum);
    TargetSum = TargetSum.*scale;
   
    content = sqrtm(sqrChoi*TargetSum*sqrChoi);
    
    % Finds fidelity
    Diff = trace(abs(content))^2;

end

