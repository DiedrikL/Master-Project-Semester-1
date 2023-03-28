
% Setup time
Time = TimeOptions(Tsize = 2000);

% Setup parameters
N = 30;

% Log distance
% exponentStart = -5;
% exponentEnd = 0;
% gamma = logspace(exponentStart, exponentEnd, N);

% Linear distance
startPoint = 0;
endPoint = 0.1;
gamma = linspace(startPoint, endPoint, N);

learning = 1e-3;

% Hamiltonian settings
measure = Measure.ChoiFidelity;
noise = HamiltSettings.TwoParticleNoises.GeneratedTraceless;

paraUsed = 4;
maxIter = 1000;

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
    Hamilt = Hamiltonians.LindbladRhoTwo(...
        Time=Time,...
        Parameters = startvalue,...
        Gamma = gamma(n),...
        Noise = noise);
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
plot(gamma, referenceValue, 'r--')

gamma = transpose(gamma);

% Data = [parameters lambda result, referenceValue]
name = 'LambdaPlot_' + string(noise);
% name = sprintf(formatSpec);
nameFormat = regexprep(name, '[\s:]', '_');
data = [parameters, gamma, result, referenceValue];
SaveMatrixToOutput(data, name)
% SaveToOutput(nameFormat)
% Save(nameFormat)

