% 
epsilon = 5;
omegaX = 4;
omegaY = 2;
% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = 1.6971e+00;
gamma = 0;

parameters = [epsilon, omegaX, omegaY];
PsiL = [1; 0; 0; 0];
PsiH = [1;0];
Time = TimeOptions(Tpulse = pi/4);


Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters, Gamma = gamma, Time = Time);
% Gate = Gates.Hadamard;
Gate = Gates.TestGateOne;   
[Lindblad] = UseSolver(PsiL, Lindbladian);
LindbladSolution = reshape(Lindblad(:, end),2,2).';

SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters, Time = Time);
[Simple] = UseSolver(PsiH, SimpleHam);
S = Simple(:, end);
Solution = S*S'

% FindU(Hamiltonian)
% Unitary = FindU(SimpleHam)


index = 2;
for n = 1:index
    for m = 1:index
        Rho = sparse(m, n, 1, index, index);
        RhoVector = reshape(Rho,[],1);
        [solutionMatrix] = UseSolver(RhoVector, Lindbladian);
        lindbladSolution = reshape(solutionMatrix, index, index);
    end
end
lindbladSolution
