% Solves the schrödinger equation with Crank Nicolson 
% and compares it with ode45 

% Clear memory and set format for output to screen
clear vars
format short e
zoom reset


% Parametre and start value
epsilon = 1;
omega = 0.6;
gamma = 1.1;
psi0 = [1; 0];


% Set timelength
T = 4*pi/gamma;

% Solve the schrödinger equation
[Time1, Psi1] = ode45(@(t,y)odefun(t,y,epsilon,omega,gamma), [0 T], psi0);
[Time2, Psi2] = SolveTDSE(epsilon, omega, psi0, gamma);

% Extracting values
a = abs(Psi1(:,1)).^2;
b = abs(Psi1(:,2)).^2;
c = abs(Psi2(1,:)).^2;
d = abs(Psi2(2,:)).^2;
norm1 = a+b;
norm2 = c+d;

% Plot the result from the different methods
figure
hold on
plot(Time1, a)
plot(Time2, c)
legend('ode45','STDSE')

pause
clf
hold on
plot(Time1,b)
plot(Time2,d)
legend('ode45','STDSE')

pause
clf
hold on
plot(Time1,norm1)
plot(Time2,norm2)
zoom yon
legend('ode45','STDSE')


% Function for the derivate
function dydt = odefun(t,y,epsilon,omega,gamma)
H = [-epsilon/2                omega*sin(gamma*t);...
         conj(omega)*sin(gamma*t)  epsilon/2];
dydt = (-1i)*H*y;
dydt = dydt(:);
end