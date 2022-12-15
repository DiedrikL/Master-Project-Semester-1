format long

% parameters
epsilon = 1;
omegaX = 2;
omegaY = 3;
gamma = 0;
parameters = [epsilon, omegaX, omegaY];


% Timesteps and file names
steps = 1e6;
Time = TimeOptions(Tsize = steps)
LName = "GeneratedLindblad" + steps;
HName = "GeneratedHamiltonian" + steps;


% creating the lindbladian
Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters, Gamma = gamma, Time = Time);

% Solving the lindbladian for one posibility
Rho = sparse(1, 1, 1, 2, 2);
RhoVector = reshape(Rho,[],1);
[~, solutionMatrix] = SolveTDSEgeneral(RhoVector, Lindbladian);
lindbladSolution = reshape(solutionMatrix(:,end), 2, 2);
lindbladSolution = transpose(lindbladSolution)

SaveMatrixToOutput(lindbladSolution, LName)

% Finding the unitary for the hamiltonian
Hamiltonian = Hamiltonians.SimpleHamiltonian(Parameters = parameters, Time = Time);
% hamiltSolution = FindU(Hamiltonian)
hamiltSolution = SolveTDSEgeneral([1;0], Hamiltonian)
SaveMatrixToOutput(hamiltSolution, HName)

