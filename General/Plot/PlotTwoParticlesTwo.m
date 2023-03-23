% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 6;
N = 80;

% Measure and Gate
measure = Measure.ChoiFidelity;
% Gate = Gates.Hadamard;
Gate = Gates.GateOfOneTwoParticles;

% Static parameters
% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = 1.6971e+00;
epsilon = 1;
omegaX = 1;
omegaY = 1;
u = 1;
Gamma = 0.003;
parameters = ones(4,1);
noise = HamiltSettings.TwoParticleNoises.Generated;

% Setup space
parameter = linspace(-L/2,L/2,N);  

Room = zeros(N,N);

parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.LindbladRhoTwo(Gamma = Gamma, Noise = noise);
    Hamilt.Measure = measure;

    for n = 1:N
        para = [parameter(n), parameter(m), omegaY, u];
        Hamilt.Parameters = para;

        Room(m,n) = MeasureDiffGeneral(Hamilt, Gate = Gate);

    end
end

% Plot room
figure
pcolor(parameter, parameter, Room)
xlabel('Epsilon')
ylabel('U')
colorbar

figure
surf(parameter, parameter, Room)
xlabel('Epsilon')
ylabel('U')

% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row)
LowestPara2 = parameter(col)

LowestValue = Room(row, col)
data = [parameter; Room];
SaveMatrixToOutput(data, 'Epsilon_U')
