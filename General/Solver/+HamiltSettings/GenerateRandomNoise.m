function noise = GenerateRandomNoise(options)
% Function to generate random traceless noise with optional random seed and
% size of the noise
arguments
    options.Seed = 42;
    options.MatrixSize = 4;
end

% initialize variables
seed = options.Seed;
matrixSize = options.MatrixSize;

% set the random number generator
s = rng(seed);

% Create random noise
L = randn(matrixSize) + 1i*randn(matrixSize);

% Make the noise traceless and return it
noise = L - trace(L)*eye(matrixSize)/matrixSize;
