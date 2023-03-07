
% Setup time
Time = TimeOptions(Tsize = 1000);

% Setup parameters
N = 60;
startpoint = -5;
endpoint = 0;
learning = 1e-3;
measure = Measure.ChoiFidelity;

paraUsed = 4;
maxIter = 500;


gamma = logspace(startpoint, endpoint, N);

startvalue = ones(paraUsed,1);

% Gate to optimize over
HGate = Gates.GateOfOneTwoParticles;
HGate.gate


% create result matrices
parameters = zeros(N,paraUsed);
result = ones(N, 1);
referenceValue = ones(N,1);


% Setup for waitbar
bar = PoolWaitbar(N);
q = parallel.pool.DataQueue;
afterEach(q, @(value)bar.updateBarValue(value));

parfor n=1:N
    Hamilt = Hamiltonians.LindbladRhoTwo(Time=Time, Parameters = startvalue, Gamma = gamma(n));
    Hamilt.Measure = measure;
    referenceValue(n) = MeasureDiffGeneral(Hamilt, Gate = HGate);
    [parameters(n,:), result(n)] = GradientDescent.GradientDescent(...
    Hamilt, ...
    HGate, ...
    learning=learning, ...
    maxIter=maxIter)   
    
    send(q, result(n));
end

% plot result
plot(gamma, result)
hold on
plot(gamma, referenceValue, 'r')

gamma = transpose(gamma);

% Data = [parameters lambda result, referenceValue]
name = 'LambdaPlot_';
% name = sprintf(formatSpec);
nameFormat = regexprep(name, '[\s:]', '_');
data = [parameters, gamma, result, referenceValue];
SaveMatrixToOutput(data, name)
% SaveToOutput(nameFormat)
% Save(nameFormat)

