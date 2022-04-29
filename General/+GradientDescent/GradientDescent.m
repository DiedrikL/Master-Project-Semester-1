function [epsilon, omegaX, omegaY] = GradientDescent(epsilon, omegaX, omegaY, learning, Beta)
% Gradient descent function, that takes two parameters. There are two 
% optional parameters to determine learning rate and the option of running
% gradient descent with momentum if Beta is > 0. 
% Optimizes for epsilon and omega
% Beta must >= 0 and <1

% Input validation and default values
arguments
   epsilon(1,:) double
   omegaX(1,:) double
   omegaY(1,:) double
   learning double = 1e-3;
   Beta double {mustBeInRange(Beta,0,1,"exclude-upper")} = 0;
end

% Max intervals
maxIt = 100;

% Initialise momentum vector
V = zeros(1,3);

for iter = 1:maxIt
    
    V = Beta*V + (1-Beta)*CalculateGradients(epsilon, omegaX, omegaY);

    epsilon = epsilon-learning*V(1);
    omegaX = omegaX-learning*V(2);
    omegaY = omegaY-learning*V(3);
    
    if mod(iter,100) == 0
       MeasureDiff(epsilon, omegaX, omegaY) 
    end
    
%     if(MeasureDiff(newEpsilon, newOmega) < MeasureDiff(epsilon,omega))
%         epsilon = newEpsilon;
%         omega = newOmega;
%     elseif(learning > 1e-8)
%         learning = learning/2;
%     else
%         disp("Number of iterations:")
%         iter
%         break;
%     end
    
    
end
