
% Setup time
Time = TimeOptions;

% Setup parameters
steps = 8;
N = 3*steps;
learning = 1e-3;
measure = Measure.ChoiFidelity;

% Measure treshold
treshold = 1e-1;

epsilon = 1;
omegaX = 1;
omegaY = 1;
% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = -1.6971e+00;
tresh1 = 1e-2;
tresh2 = 1e-1;
tresh3 = 1e0;

lambda1 = linspace(0, tresh1, steps);
lambda2 = linspace(tresh1, tresh2, steps);
lambda3 = linspace(tresh2, tresh3, steps);
lambda = [lambda1, lambda2, lambda3];

startvalue = [epsilon, omegaX, omegaY];

% Gate to optimize over
% HGate = Gates.TestGateOne;
HGate = Gates.GateOfOne;
HGate.gate


% create result matrices
parameters = zeros(N,3);
result = ones(N, 1);
referenceValue = ones(N,1);


% Setup for waitbar
bar = PoolWaitbar(N);
q = parallel.pool.DataQueue;
afterEach(q, @(value)bar.updateBarValue(value));

parfor n=1:N
    Hamilt = Hamiltonians.LindbladOne(Time=Time, Parameters = startvalue, Lambda = lambda(n));
    Hamilt.Measure = measure;
    referenceValue(n) = MeasureDiffGeneral(Hamilt, Gate = HGate);
    [parameters(n,:), result(n)] = GradientDescent.GradientDescent(...
    Hamilt, ...
    HGate, ...
    learning=learning)   

    
    send(q, result(n));
end

% plot result
plot(lambda, result)
hold on
plot(lambda, referenceValue, 'r')

lambda = transpose(lambda);

% Data = [parameters lambda result, referenceValue]
naem = 'LambdaPlot_';
% name = sprintf(formatSpec);
nameFormat = regexprep(name, '[\s:]', '_');
SaveToOutput(nameFormat)

