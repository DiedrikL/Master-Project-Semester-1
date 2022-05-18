
% Setup time
T = 2*pi;

%Time = TimeOptions(Tstart = -T, Tpulse = T);
Time = TimeOptions;

% Setup parameters
epsilon = 1;
omegaX = 0.6;
omegaY = 0;

Beta = 0.1;
learning = 1e-2;

% offsets
x = 0;
y = 0;
z = 0;

parameters = [epsilon, omegaX, omegaY, x, y, z];

% Create the hamiltonian
Hamilt = Hamiltonians.SmoothHamiltonianOffsets(...
    Time = Time, Parameters = parameters);

% set target gate
HGate = Gates.Hadamard;




% Run gradient descent
[para, result] = GradientDescent.GradientDescent(...
    Hamilt, HGate, Beta=Beta, learning=learning)


% Plot result of gradient descent

% Set result of gradient descent as parameters
Hamilt.Parameters = para;

[Time1, Psi1] = SolveTDSEgeneral(psi0, H1);

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

