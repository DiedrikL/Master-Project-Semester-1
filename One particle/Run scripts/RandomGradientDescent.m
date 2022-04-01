% Runs the gradient descent function, several times with random parameters
% each time before displaying the lowest.

% Clear memory and set format for output to screen
clear
format short e
format compact

% Parameters
iters = 5;
learning = 1e-3;
range = 12;

% Determines if momentum is used, and how much.
% Must be 0 =< Beta < 1
Beta = 0.5;


Results = zeros(iters,4);

% Runs gradient descent iters times
for n = 1:iters
    % Initialize the random variables
    epsilon = range*rand-range/2;
    omegaX = range*rand-range/2;
    omegaY = range*rand-range/2;
    
    % Finds a local minima
    [epsilon, omegaX, omegaY] = GradientDescent(epsilon, omegaX, omegaY, learning, Beta)
    difference = MeasureDiff(epsilon, omegaX, omegaY)
    disp('')
    
    Results(n,1) = epsilon;
    Results(n,2) = omegaX;
    Results(n,3) = omegaY;
    Results(n,4) = difference;
end

[minres,minpos] = min(Results(:,4));

disp('\nLowest result is:')
epsilon = Results(minpos,1)
omegaX = Results(minpos,2)
omegaY = Results(minpos,3)
difference = Results(minpos,4)



