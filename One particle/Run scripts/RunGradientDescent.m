% Runs the gradient descent function, with preset parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameters
epsilon = 5.5621;
omega = 0.53043-9.1722i;
learning = 1e-5;

% Determines if momentum is used, and how much.
% Must be 0 =< Beta < 1
Beta = 0;

[epsilon, omega] = GradientDescent(epsilon, omega, learning, Beta)
difference = MeasureDiff(epsilon, omega)