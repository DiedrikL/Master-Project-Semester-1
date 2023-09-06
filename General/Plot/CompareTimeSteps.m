% Script that compares a high definition 

format long


% parameters
epsilon = 1;
omegaX = 1;
omegaY = 1;
gamma = 0;
parameters = [epsilon, omegaX, omegaY];
Gate = Gates.GateOfOneHigh;


%% Starting and end exponents for timesteps, and number of repetitions
N = 600;


% logarithmic step sizes
startExponent = 2;
endExponent = 6;
Timesteps = logspace(startExponent, endExponent, N);
Timesteps = round(Timesteps);

% creating the lindbladian
Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters, Gamma = gamma);
lindbladResult = ones(N,1);

% Setting up Hamiltonian
Hamiltonian = Hamiltonians.SimpleHamiltonian(Parameters = parameters);
Hamiltonian.Measure = Measure.AvgFidelity;
hamiltResult = ones(N,1);


% Solving the hamiltonian and lindbladian with different number of time
% steps
for n = 1:N
    n
    step = Timesteps(n);
    Lindbladian.Time.Tsize = step;
    Hamiltonian.Time.Tsize = step;

    hamiltResult(n) = MeasureDiffGeneral(Hamiltonian, Gate=Gate);

    
    lindbladResult(n) = MeasureDiffGeneral(Lindbladian, Gate=Gate);
end



hamFig = figure;
loglog(Timesteps, abs(hamiltResult))
title('Error for Hamiltonian with Average gate fidelity')
xlabel('Timesteps')
ylabel('Infidelity')
fontsize(hamFig, scale=2);


lindFig = figure;
loglog(Timesteps, abs(lindbladResult))
title('Error for Lindbladian with channel fidelity')
xlabel('Timesteps')
ylabel('Infidelity')
fontsize(lindFig, scale=2);

