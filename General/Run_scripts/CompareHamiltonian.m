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
T = 2*pi/gamma;
TimePara1 = TimeOptions(Tpulse = T, Tsize = 50);
TimePara2 = TimeOptions(Tstart = -T, Tpulse = T, Tsize = 200);


% Set up the hamiltonians
H1 = Hamiltonians.SimpleHamiltonian(Gamma = gamma, Time = TimePara1, Parameters = parameters);
H2 = Hamiltonians.SmoothHamiltonian(Time = TimePara1, Parameters = parameters);

% Solve the schrödinger equation
[Time1, Psi1] = SolveTDSE(epsilon, omegaX, omegaY, psi0, gamma);

[Time2, Psi2] = SolveTDSEgeneral(psi0, H1);
[Time3, Psi3] = SolveTDSEgeneral(psi0, H2);

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

legend('STDSE','50','Smoot')

