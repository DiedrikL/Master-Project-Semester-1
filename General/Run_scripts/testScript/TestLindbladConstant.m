% 
epsilon = 1;
omegaX = 1;
omegaY = 1;
% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = 1.6971e+00;
lambda = 1;

parameters = [epsilon, omegaX, omegaY];
PsiL = [1; 0; 0; 0];
PsiH = [1;0];
time = TimeOptions(Tpulse = 4*pi, Tsize = 1e4);


Lindbladian = Hamiltonians.LindbladOneConstant(Parameters = parameters, Lambda = lambda, Time = time);

[~, Lindblad] = SolveTDSEgeneral(PsiL, Lindbladian);
LindbladSolution = reshape(Lindblad(:, end),2,2).';

% SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters, Time = Time);
% [~, Simple] = SolveTDSEgeneral(PsiH, SimpleHam);
% S = Simple(:, end);
% Solution = S*S'


index = 2;
matrixSize = index^2;
scale = 1/index;



% initialize matrix
ChoiPart = zeros(index, index, matrixSize, matrixSize);

for n = 1:index
    for m = 1:index
        Rho = sparse(m, n, 1, index, index);
        RhoVector = reshape(Rho,[],1);
        [~, solutionMatrix] = SolveTDSEgeneral(RhoVector, Lindbladian);
        lindbladSolution = reshape(solutionMatrix(:,end), index, index);
        ChoiPart(m,n,:,:) = transpose(kron(lindbladSolution, Rho));
        
    end
end


% Sums and reduces the parts of the choi matrix
Choi = sum(ChoiPart, [1, 2]);
Choi = squeeze(Choi);
Choi = (Choi.*scale);
Choi



