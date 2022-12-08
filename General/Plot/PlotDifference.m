% parameters, should give 0 for the given gate
epsilon = 5;
omegaX = 4;
omegaY = 2;
parameters = [epsilon, omegaX, omegaY];


% The gate to target
Gate = Gates.TestGateOne;

% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = 1.6971e+00;

% variables
N = 1e2;
goal = 0.2;

deltaGamma = goal/N;
gamma = 0:deltaGamma:goal;
gamma(end) = [];
Choi = ones(1,N);


% Setting up the hamiltonians
Lindbladian = Hamiltonians.LindbladOne(Parameters = parameters);
SimpleHam = Hamiltonians.SimpleHamiltonian(Parameters = parameters);

% Finding the reference
Avg = MeasureDiffGeneral(SimpleHam, Gate = Gate);

for n = 1:N
    Lindbladian.Gamma = gamma(n);
    Choi(n) = MeasureDiffGeneral(Lindbladian, Gate = Gate);
end

figure
hold on

plot(gamma, Choi);
refline([0,Avg]);

hold off