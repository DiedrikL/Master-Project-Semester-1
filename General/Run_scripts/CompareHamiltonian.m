% Solves the schrödinger equation with Crank Nicolson 
% and compares different hamiltonians effect on the solution

% Clear memory and set format for output to screen
clear
format short e
zoom reset


% Parametre and start value
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;
gamma = 1;
psi0 = [1; 0];
parameters = [epsilon, omegaX, omegaY];


% Set timelength
T = 2*pi;
TimePara1 = TimeOptions(Tpulse = T, Tsize = 50);
TimePara2 = TimeOptions(Tstart = -T, Tpulse = T, Tsize = 200);


% Set up the hamiltonians
H1 = Hamiltonians.SimpleHamiltonian(Time = TimePara1, Parameters = parameters);
H2 = Hamiltonians.SmoothHamiltonian(Time = TimePara1, Parameters = parameters);
Time1 = H1.TimeVector;
Time2 = H2.TimeVector;
H1.Solver = HamiltSettings.Solvers.Crank_Nicolson_with_steps;
H2.Solver = HamiltSettings.Solvers.Crank_Nicolson_with_steps;

% Solve the schrödinger equation

Psi1 = UseSolver(psi0, H1);
Psi2 = UseSolver(psi0, H2);

% Extracting values
a = abs(Psi1(1,:)).^2;
b = abs(Psi1(2,:)).^2;
c = abs(Psi2(1,:)).^2;
d = abs(Psi2(2,:)).^2;

norm1 = a+b;
norm2 = c+d;

% Plot the result from the different methods
figure
hold on
plot(Time1, a)
plot(Time2, c)
legend('50', 'Smoot')

pause
figure
hold on
plot(Time1, b)
plot(Time2, d)
legend('50', 'Smoot')

pause
figure
hold on
plot(Time1, norm1)
plot(Time2, norm2)

legend('50','Smoot')

