% Script to run gradient descen on a one parameter optimization to see
% the effect of different scale parameters in a smooth hamiltonian have
% from a sharp one

clear

% Setup time
T = 0.5*pi;

Time = TimeOptions(Tpulse = T);


Beta = 0.1;
learning = 1e-4;
maxIter = 100;
psi0 = [1;0];
startScale = 5;
scaleStep = 5;
scaleEnd = 100;


% Create the hamiltonian
Hamilt = Hamiltonians.OneVariableXgate(...
    Time = Time, Parameters = T, Scale = startScale);

% set target gate
HGate = Gates.Xgate;

scaleVector = startScale:scaleStep:scaleEnd;
leng = length(scaleVector);


para = T;
result = zeros(2,leng);

% Run gradient descent
for n = 1:leng
    Hamilt.Scale = scaleVector(n);
    Hamilt.Parameters = para;
    
    [para, deviation] = GradientDescent.GradientDescent(...
        Hamilt, HGate, Beta=Beta, learning=learning, maxIter = maxIter)
    
    result(1,n) = para - T;
    result(2,n) = deviation;
end


%piPeriods = para/pi


% Plot result of gradient descent
plot(scaleVector, result(1,:))



