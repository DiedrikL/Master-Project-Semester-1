
% Setup time
Time = TimeOptions;

% Setup parameters
epsilon = 1;
omegaX = 0.6;
omegaY = 1;
u = 0.5;

Beta = 0.1;
learning = 1e-2;

% offsets
x = 0;
y = 0;
z = 0;

parameters = [epsilon, omegaX, omegaY, u];

% Create the hamiltonian
Hamilt = Hamiltonians.TwoParticlesHamiltonian(Time=Time, Parameters = parameters);

% set target gate
HGate = Gates.SquareRootSwap;




% Run gradient descent
[para, result] = GradientDescent.GradientDescent(...
    Hamilt, HGate, learning=learning)


% Plot result of gradient descent

% Set result of gradient descent as parameters
Hamilt.Parameters = para;
psi0 = HGate.Psi0(:,1);

[Time1, Psi1] = SolveTDSEgeneral(psi0, Hamilt);

a = abs(Psi1(1,:)).^2;
b = abs(Psi1(2,:)).^2;

norm1 = a+b;

% Plot the result
hold on
plot(Time1, a)

pause
clf
hold on
plot(Time1, b)

pause
clf
hold on
plot(Time1, norm1)

