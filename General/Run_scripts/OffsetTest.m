% Test function to see difference with offsets in a smoothed out
% Hamiltonian


% Parametre and start value
epsilon = 2.4210e+00;
omegaX = 0;
omegaY = 1.6971e+00;

psi0 = [1; 0];


% offsets
x = 5;
y = -3;
z = 1;

para = [epsilon, omegaX, omegaY];
offsetPara = [epsilon, omegaX, omegaY, x, y, z];



% Time options
Period = 2*pi;

SimpleTime = TimeOptions(Tpulse = Period, Tsize = 500);
DoubleTime = TimeOptions(Tpulse = Period, Tsize = 1000);





% Set up the hamiltonians
H1 = Hamiltonians.SmoothHamiltonian(Time=SimpleTime, Parameters = para);
H2 = Hamiltonians.SmoothHamiltonianOffsets(Time=SimpleTime, Parameters = offsetPara);
%H3 = Hamiltonians.SmoothHamiltonianOffsets(Time=DoubleTime, Parameters = offsetPara);


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
legend('Simpl', 'Smoot', 'Offset')

pause
clf
hold on
plot(Time1, b)
plot(Time2, d)
plot(Time3, f)
legend('STDSE', 'Smoot', 'Offset')

pause
clf
hold on
plot(Time1, norm1)
plot(Time2, norm2)
plot(Time3, norm3)

zoom yon
legend('STDSE', 'Smoot', 'Offset')
pause
zoom reset
