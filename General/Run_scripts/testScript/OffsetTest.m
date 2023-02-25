% Test function to see difference with offsets in a smoothed out
% Hamiltonian


% Parametre and start value
% epsilon = 2.4210e+00;
% omegaX = 0;
% omegaY = 1.6971e+00;

epsilon = 1;
omegaX = 1;
omegaY = 1;

scale = 5;

psi0 = [1; 0];


% offsets
x = -5;
y = 5;
z = 150;

para = [epsilon, omegaX, omegaY];
offsetPara = [epsilon, omegaX, omegaY, x, y, z];



% Time options
Period = 2*pi;

SimpleTime = TimeOptions(Tpulse = Period, Tsize = 500);
DoubleTime = TimeOptions(Tpulse = Period, Tsize = 1000);



% Set up the hamiltonians
H1 = Hamiltonians.SimpleHamiltonian(Time=SimpleTime, Parameters = para);
H2 = Hamiltonians.SmoothHamiltonian(Time=SimpleTime, Parameters = para, Scale = scale);
H3 = Hamiltonians.SmoothHamiltonianOffsets(Time=SimpleTime, Parameters = offsetPara);
% H3 = Hamiltonians.SmoothHamiltonianOffsets(Time=DoubleTime, Parameters = offsetPara);

% Set solver to one that preserves the steps
H1.Solver = HamiltSettings.Solvers.Crank_Nicolson_with_steps;
H2.Solver = 'Crank_Nicolson_with_steps';
H3.Solver = HamiltSettings.Solvers.Crank_Nicolson_with_steps;

% Extract the time steps
Time1 = H1.TimeVector;
Time2 = H2.TimeVector;
Time3 = H2.TimeVector;


% Solve the schrödinger equation
Psi1 = UseSolver(psi0, H1);
Psi2 = UseSolver(psi0, H2);
Psi3 = UseSolver(psi0, H3);

Solution1 = Psi1(:,end)
Solution2 = Psi2(:,end)
Solution3 = Psi3(:,end)

up1 = a(end)
up2 = c(end)
up3 = e(end)


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
legend('STDSE', 'Smoot', 'Offset')

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
legend('STDSE', 'Smoot', 'Offset')


% Testing end result
H1.Solver = HamiltSettings.Solvers.Crank_Nicolson;
H2.Solver = 'Crank_Nicolson';
H3.Solver = HamiltSettings.Solvers.Crank_Nicolson;

Gate = Gates.GateOfOne;
test1 = MeasureDiffGeneral(H1, Gate = Gate)
test2 = MeasureDiffGeneral(H2, Gate = Gate)
test3 = MeasureDiffGeneral(H3, Gate = Gate)
