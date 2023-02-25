format long

% parameters
epsilon = 1;
omegaX = 1;
omegaY = 1;
gamma = 0;
parameters = [epsilon, omegaX, omegaY];


% Timesteps and file names
steps = 1e5;
Time = TimeOptions(Tsize = steps)
LName = "GeneratedLindblad" + steps;
HName = "GeneratedHamiltonian" + steps;


% creating the lindbladian
Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters, Gamma = gamma, Time = Time);

% Solving the lindbladian for one posibility
Rho = sparse(1, 1, 1, 2, 2);
RhoVector = reshape(Rho,[],1);
solutionMatrix = UseSolver(RhoVector, Lindbladian);
lindbladSolution = reshape(solutionMatrix(:,end), 2, 2);
lindbladSolution = transpose(lindbladSolution)

SaveMatrixToOutput(lindbladSolution, LName)

% Finding the unitary for the hamiltonian
Hamiltonian = Hamiltonians.SimpleHamiltonian(Parameters = parameters, Time = Time);
hamiltSolution = FindU(Hamiltonian)

SaveMatrixToOutput(hamiltSolution, HName)

