function Diff = ChoiMatrixMeasure(Lindbladian, Gate)
% Compares the difference of a Lindbladian with a given gate using a Choi
% matrix

    arguments
        Lindbladian Hamiltonians.HamiltonianInterface
        Gate Gates.GateInterface
    end
    
    
    % Get matrix size from gate
    Psi0 = Gate.Psi0;
    psiSize = size(Psi0, 2);

    % Setup values 
    exponent = size(factor(psiSize),2);
    index = 2^exponent;
    matrixSize = index^2;
    scale = 1/index;

    % Extract gate
    targetGate = Gate.gate;

    % initialize matrix
    ChoiPart = zeros(index, index, matrixSize, matrixSize);
    targetPart = zeros(index, index, matrixSize, matrixSize);
    
    for n = 1:index
        for m = 1:index
            Rho = sparse(m, n, 1, index, index);
            RhoVector = reshape(Rho,[],1);
            [~, solutionMatrix] = SolveTDSEgeneral(RhoVector, Lindbladian);
            lindbladSolution = reshape(solutionMatrix(:,end), index, index);
            ChoiPart(m,n,:,:) = kron(lindbladSolution, Rho).';
            
            targetPart(m,n,:,:) = kron(targetGate*Rho*targetGate', Rho);
    
        end
    end
        
    % Sums and reduces the parts of the choi matrix
    Choi = sum(ChoiPart, [1, 2]);
    Choi = squeeze(Choi);
    Choi = (Choi.*scale);
    sqrChoi = sqrtm(Choi);

    % Sums and reduces the kron products of the target gate
    TargetChoi = sum(targetPart,[1, 2]);
    TargetChoi = squeeze(TargetChoi);
    TargetChoi = TargetChoi.*scale;
   
    content = sqrtm(sqrChoi*TargetChoi*sqrChoi);

    
    % Finds fidelity
    Diff = trace(content)^2;

end

