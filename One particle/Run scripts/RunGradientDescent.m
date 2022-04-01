% Runs the gradient descent function, with preset parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameters
epsilon = 5.5621;
omegaX = 0.53043;
omegaY = 9.1722;
learning = 1e-5;

% Determines if momentum is used, and how much.
% Must be 0 =< Beta < 1
Beta = 0.1;

[epsilon, omegaX, omegaY] = GradientDescent(epsilon, omegaX, omegaY, learning, Beta)
difference = MeasureDiff(epsilon, omegaX, omegaY)
