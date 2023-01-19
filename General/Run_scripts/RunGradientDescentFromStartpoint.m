
% Setup time
Time = TimeOptions;

% Setup parameters
range = 1;
minimum = 0;
repeats = 20;
learning = 1e-3;
measure = Measure.ChoiFidelity;

% Measure treshold
treshold = 1e-1;

% epsilon = 5;
% omegaX = 4;
% omegaY = 2;
epsilon = 2.4210e+00;
omegaX = 3.1426e-16;
omegaY = -1.6971e+00;
lambda = 5e-2;

startvalue = [epsilon, omegaX, omegaY];

% Gate to optimize over
% HGate = Gates.TestGateOne;
HGate = Gates.Hadamard;
HGate.gate


% create result matrices
parameters = rand(repeats,3).*range+startvalue;
result = ones(repeats, 1);

% Setup for waitbar
bar = PoolWaitbar(repeats);
q = parallel.pool.DataQueue;
afterEach(q, @(value)bar.updateBarValue(value));

parfor n=1:repeats
    para = parameters(n,:);
    Hamilt = Hamiltonians.LindbladOne(Time=Time, Parameters = para);
    Hamilt.Measure = measure;
    [para, result(n)] = GradientDescent.GradientDescent(...
    Hamilt, ...
    HGate, ...
    learning=learning)   
    
    parameters(n,:) = para;
    send(q, result(n));
end

% show best result with parameters
[m, Index] = min(result);
result(Index)
parameters(Index,:)
lowValues = sum(result<treshold)
