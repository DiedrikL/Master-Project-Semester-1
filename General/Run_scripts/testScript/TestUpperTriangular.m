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
Lindblad = UseSolver(PsiL, Lindbladian);
LindbladSolution = reshape(Lindblad(:, end),2,2).'

SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters, Time = Time);
[Simple] = UseSolver(PsiH, SimpleHam);
S = Simple(:, end);
Choi = S*S';

tic
Choi1 = FindChoi(Lindbladian);
toc
disp('Time for FindChoi')


parameters = 1;
% Lindbladian = Hamiltonians.LindbladRhoTwo(Parameters = parameters, Time = Time);
RhoSize = double(Lindbladian.rhoSize);
matrixSize = RhoSize^2;

tic
% initialize matrix
ChoiPart2 = zeros(RhoSize, RhoSize, matrixSize, matrixSize);

for n = 1:RhoSize
    for m = 1:RhoSize
        Rho = sparse(m, n, 1, RhoSize, RhoSize);
        lindbladSolution = SolveFunk.SolveForRho(Lindbladian, Rho, RhoSize);
        part = kron(lindbladSolution, Rho);
        ChoiPart2(m,n,:,:) = part;
    end
end
    
% Sums and reduces the parts of the choi matrix
Choi2 = sum(ChoiPart2, [1, 2]);
Choi2 = squeeze(Choi2);
Choi2 = (Choi2./RhoSize);

% find time
toc
disp('Time for ChoiMatrix')



% start time
tic

% initialize matrix
ChoiPart3 = zeros(RhoSize, RhoSize, matrixSize, matrixSize);

for n = 1:RhoSize
    for m = 1:RhoSize
        if(n>m)
            Rho = sparse(m, n, 1, RhoSize, RhoSize);
            lindbladSolution = SolveFunk.SolveForRho(Lindbladian, Rho, RhoSize);
            part = kron(lindbladSolution, Rho);
            ChoiPart3(m,n,:,:) = part;
            ChoiPart3(n,m,:,:) = ctranspose(part);
        elseif(n==m)
            Rho = sparse(m, n, 1, RhoSize, RhoSize);
            lindbladSolution = SolveFunk.SolveForRho(Lindbladian, Rho, RhoSize);
            part = kron(lindbladSolution, Rho);
            ChoiPart3(m,n,:,:) = part;
        end
    end
end

Choi3 = sum(ChoiPart3, [1, 2]);
Choi3 = squeeze(Choi3);
Choi3 = (Choi3./RhoSize);



% find time
toc
disp('Time for ChoiMatrix with if and elseif')



% take time
tic
counter = reshape(1:matrixSize, RhoSize,RhoSize);
Iset = reshape(nonzeros(triu(counter, 1)), 1, []);
nonmirror = reshape(nonzeros(diag(counter)), 1, []);

% Setup matrices
Choi4 = zeros(matrixSize);

% Getting the solution for the start positions
for n = Iset
    choiPart = solveForIndex(Lindbladian, RhoSize, n);
    Choi4 = Choi4 + choiPart + ctranspose(choiPart);
end

for n = nonmirror
    choiPart = solveForIndex(Lindbladian, RhoSize, n);
    Choi4 = Choi4 + choiPart;
end


% Scaling the answer
Choi4 = Choi4/double(RhoSize);
toc
disp('Time for Choi with transposed lower diagonal')


% tic
% Choi5 = zeros(matrixSize);
% for n = 1:matrixSize
%     choiPart = solveForIndex(Lindbladian, RhoSize, n);
%     Choi5 = Choi5 + choiPart;
% end
% Choi5 = Choi5/double(RhoSize);
% 
% toc

% Test = sum(Choi1 - Choi2, 'all')
% Test2 = sum(Choi2 - Choi3, 'all')
Test3 = sum(Choi3 - Choi4, 'all')
% Test4 = sum(Choi4 - Choi5, 'all');


% function choiPart = solveForIndex(index, Lindblad)
%     Rho0 = zeros(2);
%     Rho0(index) = 1;
%     Rho = SolveFunk.SolveForRho(Lindblad, Rho0, 2);
%     choiPart = kron(Rho, Rho0);
% end
