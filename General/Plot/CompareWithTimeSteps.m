% Script that compares a high definition 

format long

% Solution matrices with large number of timesteps
lindbladSolution = ...
  [0.519454622371311 + 0.000000000000010i -0.049356818983445 - 0.497177455306254i;
 -0.049356818983437 + 0.497177455306253i  0.480545377628576 - 0.000000000000010i]

hamiltSolution = ...
  [0.636246541797243 + 0.338592616958537i  0.384525833032538 + 0.576788749548769i;
 -0.384525833032496 + 0.576788749548762i  0.636246541797214 - 0.338592616958464i]


Rho = sparse(1, 1, 1, 2, 2);
RhoVector = reshape(Rho,[],1);


% targetChoi = kron(lindbladSolution, Rho)
lindbladRootMatrix = sqrtm(lindbladSolution);
hamiltRootMatrix = sqrtm(hamiltSolution);

% parameters
epsilon = 1;
omegaX = 2;
omegaY = 3;
gamma = 0;
parameters = [epsilon, omegaX, omegaY];


% Starting timestep, and number of repetitions
N = 100;

% Regular stepsizes
% startSteps = 100;
% stepSize = 100;
% endStep = (N-1)*stepSize+startSteps;
% Timesteps = startSteps:stepSize:endStep;

% logarithmic step sizes
startExponent = 2;
endExponent = 4;
Timesteps = logspace(startExponent, endExponent, N);
Timesteps = round(Timesteps);

% creating the lindbladian
Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters, Gamma = gamma);

% Setting up matrices
lindbladMatrices = zeros(N, 2,2);
lindbladResult = ones(N,1);

% Solving the lindbladian for one posibility with different number of time
% steps
% for n = 1:N
%     step = Timesteps(n);
%     Lindbladian.Time.Tsize = step;
% 
%     [~, solutionMatrix] = UseSolver(RhoVector, Lindbladian);
%     lindbladMatrix = reshape(solutionMatrix(:,end), 2, 2);
%     lindbladMatrix = transpose(lindbladMatrix);
%     lindbladMatrices(n,:,:) = lindbladMatrix;
%     content = sqrtm(lindbladRootMatrix*lindbladMatrix*lindbladRootMatrix);
% %     result = 1-trace(content)^2;
% %     result = norm(lindbladMatrix-lindbladSolution);
%     lindbladResult(n) = result;
% end

% Creating the hamiltonian
Hamiltonian = Hamiltonians.SimpleHamiltonian(Parameters = parameters);
Hamiltonian.Measure = Measure.AvgFidelity;
Psi0 = [1;0];

% setting up result matrices
hamiltMatrices = zeros(N, 2,2);
hamiltResult = ones(N,1);
hTarget = kron(hamiltSolution*Rho*hamiltSolution', Rho);
hRoot = sqrtm(full(hTarget));


% solving with different number of time steps
for n = 1:N
    step = Timesteps(n);
    Hamiltonian.Time.Tsize = step;
    hMatrix = FindU(Hamiltonian);
    hamiltMatrices(n,:,:) = hMatrix;
%     result = MeasureDiffGeneral(Hamiltonian, Gate = Gates.HighStepNumberGate);
%     hRedRes = hMatrix(:,1);
%     result = norm(hRedRes-hReduced);
    hTemp = kron(hMatrix*Rho*hMatrix', Rho);

    content = sqrtm(hRoot*hTemp*hRoot);
    result = 1-trace(content)^2;


    hamiltResult(n) = result;
end

figure
loglog(Timesteps, abs(hamiltResult))
title('Hamiltonian error')

% figure
% loglog(Timesteps, abs(lindbladResult))
% title('Lindblad error')

