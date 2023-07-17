% Script to run gradient descen on a one parameter optimization to see
% the effect of different scale parameters in a smooth hamiltonian have
% from a sharp one

clear

% Setup time
T = 0.5*pi;

Time = TimeOptions(Tpulse = T);



% Magnetic field strength
epsilon = 0;
omegaX = 1;
omegaY = 0;



% set target gate
HGate = Gates.Xgate;


% Scale of ramp
startScale = 1;
scaleStep = 1;
scaleEnd = 5;
scaleVector = startScale:scaleStep:scaleEnd;
leng = length(scaleVector);


para = 0;
resParameter = zeros(1,leng);
resDeviation = zeros(1,leng);



% Run gradient descent
parfor n = 1:leng
    scale = scaleVector(n);
    Hamilt = Hamiltonians.SmoothHamiltonianTime(...
    Time = Time, Parameters = 0, Scale = startScale);

    
    [para, deviation] = GradientDescent.GradientDescent(...
        Hamilt, HGate)
    
    resParameter(n) = para;
    resDeviation(n) = deviation;
end


%piPeriods = para/pi


% Plot result of gradient descent
plot(scaleVector, resParameter)
title('Difference from pi/2 with different values of scale')
yline(0);
