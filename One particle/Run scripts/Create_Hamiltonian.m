% Solves the schrödinger equation with ode45 for a created 
% Hamiltonian

% Clear memory and set format for output to screen
clear vars
format short e

% Parametre and start value
epsilon = 1;
omega = 0.6;
gamma = 1.1;
Psi = [0 1];


% Set timelength
dt = 0.01;
T = 100;

[X, Y] = ode45(@(t,y)odefun(t,y,epsilon,omega,gamma), [0 T], Psi);

figure
hold on
a = abs(Y(:,1)).^2;
b = abs(Y(:,2)).^2;
norm = a+b;
plot(X, a)
pause
plot(X,b)
pause
plot(X,norm)

% Function for the derivate, with the construction of the hamiltonian
function dydt = odefun(t,y,epsilon,omega,gamma)
B = [2*real(omega)*sin(gamma*t), 2*imag(omega)*sin(gamma*t), -epsilon];
PauliX = [0 1; 1 0];
PauliY = [0 -1i; 1i 0];
PauliZ = [1 0; 0 -1];

Sigma = B(1)*PauliX + B(2)*PauliY + B(3)*PauliZ;
H = 1/2*Sigma;
dydt = (-1i) * H*y;
dydt = dydt(:);
end