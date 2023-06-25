
% Setup time
T = 2*pi;

%Time = TimeOptions(Tstart = -T, Tpulse = T);
Time = TimeOptions;
% Setup parameters
% epsilon = rand*5;
% omegaX = rand*5;
% omegaY = rand*5;


epsilon = 1;
omegaX = 1;
omegaY = 1;

Beta = 0.1;
learning = 1e-2;

% offsets
x = 0;
y = 0;
z = 0;

parameters = [epsilon, omegaX, omegaY];
scale = 200;

% Create the hamiltonian
Hamilt = Hamiltonians.SmoothHamiltonianTime(...
    Time = Time, Scale=scale);

% set target gate
HGate = Gates.GateOfOneConstant;




% Run gradient descent
[para, result] = GradientDescent.GradientDescent(...
    Hamilt, HGate);

disp('Gradient done')

% Plot result of gradient descent

% Set result of gradient descent as parameters
Hamilt.Parameters = para;
psi0 = HGate.Psi0(1,:);

Hamilt.Solver = HamiltSettings.Solvers.Crank_Nicolson_with_steps;

Psi1 = UseSolver(psi0, Hamilt);
Time1 = Hamilt.TimeVector;


a = abs(Psi1(1,:)).^2;
b = abs(Psi1(2,:)).^2;

norm1 = a+b;

% Plot the result
figure
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

