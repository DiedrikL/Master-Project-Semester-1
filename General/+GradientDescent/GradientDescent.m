function [para, distance] = GradientDescent(Hamiltonian, Gate, options)
% Gradient descent function, that takes a tree parameters and some 
% optional parameters, the function has the option of running
% gradient descent with momentum if Beta is > 0. It optimizes for the
% parameters that get it closest to the given gate.
% 
% para is the vector of parameters to be optimized with start values
%
% Hamiltonian must be asubclass of HamiltonianInterface that contains the
% hamiltonian and it's settings.
%
% Gate is the target gate, it must be a subclass of GateInterface
%
% Beta is an optional parameter and must >= 0 and <1. Values above 0
% gives the function momentum
%
% learning is an optional paramter that changes how fast the values of para
% should change with respect to the gradient
%
% maxIter is the maximum number of iterations the function should do

% Input validation and default values
arguments
   Hamiltonian Hamiltonians.HamiltonianInterface
   Gate Gates.GateInterface

   options.learning double = 1e-3;
   options.Beta1 double {mustBeInRange(options.Beta1,0,1,"exclude-upper")} = 0.9;
   options.Beta2 double {mustBeInRange(options.Beta2,0,1,"exclude-upper")} = 0.999;
   options.epsilon double {mustBePositive} = 1e-8;
   options.maxIter = 1000;
end

learning = options.learning;
Beta1 = options.Beta1;
Beta2 = options.Beta2;
epsilon = options.epsilon;

% Max intervals
maxIt = options.maxIter;

% Initialise momentum vector
para = Hamiltonian.Parameters;
leng = length(para);
V = zeros(1,leng);
U = zeros(1,leng);

for iter = 1:maxIt
    
    
    grads = CalculateGradients(Hamiltonian, Gate);
    V = Beta1*V + (1-Beta1)*grads;
    U = Beta2*U + (1-Beta2)*grads.^2;
    
    % Compute bias-corrected first and second moment estimate
    V_bias = V./(1-Beta1^iter);
    U_bias = U./(1-Beta2^iter);


    
    for n = 1:leng
       para(n) = para(n) - learning*V_bias(n)/(sqrt(U_bias(n))+epsilon);
    end
    
    Hamiltonian.Parameters = para;
    
    if mod(iter,100) == 0
        MeasureDiffGeneral(Hamiltonian, Gate=Gate) 
    end
    
    
    
end


distance = MeasureDiffGeneral(Hamiltonian, Gate=Gate);

