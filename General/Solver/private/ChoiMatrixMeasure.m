function Diff = ChoiMatrixMeasure(Lindbladian, Gate)
% Compares the difference of a Lindbladian with a given gate using a Choi
% matrix and returns the fidelity

    arguments
        Lindbladian Hamiltonians.Interfaces.HamiltonianInterface
        Gate Gates.GateInterface
    end
    
    % Extract gate
    targetGate = Gate.gate;
    
    % Get matrix size from gate
    index = size(targetGate, 2);

    % Setup values 
    matrixSize = index^2;
    scale = 1/index;


    % initialize matrix
    ChoiPart = zeros(index, index, matrixSize, matrixSize);
    targetPart = zeros(index, index, matrixSize, matrixSize);
    
    % Solve for all rho values
    for n = 1:index
        for m = 1:index
            if(n>m)
                % Use the fact the parts are symmetrical around the
                % diagonal to reduce runtime with the upper triangular
                % matrix to fill in the lower triangular
                Rho = sparse(m, n, 1, index, index);
                lindbladSolution = SolveFunk.SolveForRho(Lindbladian, Rho, index);
                part = kron(lindbladSolution, Rho);
                ChoiPart(m,n,:,:) = part;
                ChoiPart(n,m,:,:) = ctranspose(part);
                
                tPart = kron(targetGate*Rho*targetGate', Rho);
                targetPart(m,n,:,:) = tPart;
                targetPart(n,m,:,:) = ctranspose(tPart);
            elseif(n==m)
                % Adding the diagonal parts directly
                Rho = sparse(m, n, 1, index, index);
                lindbladSolution = SolveFunk.SolveForRho(Lindbladian, Rho, index);
                ChoiPart(m,n,:,:) = kron(lindbladSolution, Rho);
                
                targetPart(m,n,:,:) = kron(targetGate*Rho*targetGate', Rho);
            end
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
    Diff = abs(trace(content)^2);

end

