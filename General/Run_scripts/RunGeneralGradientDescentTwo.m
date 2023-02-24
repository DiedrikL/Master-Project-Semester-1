
% Setup time
Time = TimeOptions(Tsize = 5e2);

% Setup parameters
% epsilon = 9.7661;
% omegaX = 9.8733;
% % omegaY = 2.1526;
% % u = 0.3129;
%  epsilon = 2.0163e+00   
%  omegaX = 4.1951e+00;
%  omegaY = 9.3115e+00;
%  uz = 2.5358e+00;
%  ux = 3.3929e+00;
%  uy = 6.8453e-01;
epsilon = 0.9994;
omegaX = 0.9994;
omegaY = 0.9994;
u = 0.9994;
gamma = 1e-1;
               
% Beta = 0.1;
learning = 1e-3;
Iterations = 500;

% offsets
x = 0;
y = 0;
z = 0;

parameters = [epsilon, omegaX, omegaY, u];
% parameters = (rand(1,6) - 0.5)*0.5 + 1;
% Create the hamiltonian
% Hamilt = Hamiltonians.TwoParticleInteractionHamiltonian(Time=Time, Parameters = parameters);
Hamilt = Hamiltonians.LindbladRhoTwo(...
    Gamma = gamma,...
    Time=Time, ...
    Parameters = parameters);

% set target gate
HGate = Gates.GateOfOneTwoParticles;




% Run gradient descent
[para, result] = GradientDescent.GradientDescent(...
    Hamilt, ...
    HGate, ...
    learning=learning, ...
    maxIter = Iterations)


% Plot result of gradient descent

% Set result of gradient descent as parameters
Hamilt.Parameters = para;
% psi0 = HGate.Psi0(:,1);

% [Psi1] = SolveTDSEgeneral(psi0, Hamilt);

% a = abs(Psi1(1,:)).^2;
% b = abs(Psi1(2,:)).^2;
% c = abs(Psi1(3,:)).^2;
% d = abs(Psi1(4,:)).^2;

% norm1 = a+b+c+d;

% Plot the result
% hold on
% plot(Time1, a)
% 
% pause
% clf
% hold on
% plot(Time1, b)
% plot(Time1, c)
% plot(Time1, d)
% 
% pause
% clf
% hold on
% plot(Time1, norm1)

