% Runs the gradient descent function, with preset parameters
% 

% Parameters
epsilon = 0.54;
omega = 3.5+9.85i;
learning = 1e-2;

% Determines if momentum is used, and how much.
% Must be 0 =< Beta < 1
Beta = 1.4;

[epsilon, omega] = GradientDescent(epsilon, omega, learning)
difference = MeasureDiff(epsilon, omega)