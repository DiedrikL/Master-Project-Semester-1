% Solves the schrödinger equation with Crank Nicolson 
% and compares it with ode45 

% Clear memory and set format for output to screen
clear
format short e
zoom reset


% Parametre and start value
epsilon = 1;
omegaX = 0.6;
omegaY = 0;
gamma = 1;
psi0 = [1; 0];


% Set timelength
T = 2*pi/gamma;

% Solve the schrödinger equation

[Time1, Psi1] = SolveTDSE(epsilon, omegaX, omegaY, psi0, gamma);

Hamiltonian1 = Hamiltonians.simpleHamiltonian(epsilon, omegaX, omegaY, gamma);
Hamiltonian2 = Hamiltonians.smoothedHamiltonian(epsilon, omegaX, omegaY);


[Time2, Psi2] = SolveTDSEgeneral(psi0, Hamiltonian1, T=T, Tsize=50);
[Time3, Psi3] = SolveTDSEgeneral(psi0, Hamiltonian2, T=(T), Tstart=(-T), Tsize=200);

% Extracting values
a = abs(Psi1(1,:)).^2;
b = abs(Psi1(2,:)).^2;
c = abs(Psi2(1,:)).^2;
d = abs(Psi2(2,:)).^2;
e = abs(Psi3(1,:)).^2;
f = abs(Psi3(2,:)).^2;

norm1 = a+b;
norm2 = c+d;
norm3 = e+f;

% Plot the result from the different methods
figure
hold on
plot(Time1, a)
plot(Time2, c)
plot(Time3, e)
legend('STDSE', '50', 'Smoot')

pause
clf
hold on
plot(Time1, b)
plot(Time2, d)
plot(Time3, f)
legend('STDSE', '50', 'Smoot')

pause
clf
hold on
plot(Time1, norm1)
plot(Time2, norm2)
plot(Time3, norm3)

zoom yon
legend('STDSE','50','Smoot')

