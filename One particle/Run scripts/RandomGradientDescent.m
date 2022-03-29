% Runs the gradient descent function, several times with random parameters
% each time before displaying the lowest.

% Clear memory and set format for output to screen
clear
format short e

% Parameters
iters = 5;
learning = 1e-2;

% Determines if momentum is used, and how much.
% Must be 0 =< Beta < 1
Beta = 0.5;


Results = zeros(iters,3);

% Runs gradient descent iters times
for n = 1:iters
    % Initialize the random variables
    epsilon = 12*rand;
    omega = 12*rand+12i*rand;
    learning = 1e-2;
    
    [epsilon, omega] = GradientDescent(epsilon, omega, learning, Beta)
    difference = MeasureDiff(epsilon, omega)
    
    Results(n,1) = epsilon;
    Results(n,2) = omega;
    Results(n,3) = difference;
end

[minres,minpos] = min(Results(:,3));

disp('\nLowest result is:')
epsilon = Results(minpos,1)
omega = Results(minpos,2)
difference = Results(minpos,3)



