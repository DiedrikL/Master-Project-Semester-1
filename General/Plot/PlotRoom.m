% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 8;
N = 120;

% Measure and Gate
measure = Measure.AvgFidelity;
Gate = Gates.GateOfOne;

% Static parameters
% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = 1.6971e+00;
lambda = 0.0;

epsilon = 1;
omegaX = 1;
omegaY = 1;

% Setup space
parameter = linspace(-L/2,L/2,N);  

Room = zeros(N,N);

parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.SimpleHamiltonian;
    Hamilt.Measure = measure;

    for n = 1:N
        para = [parameter(n), parameter(m), omegaY];
        Hamilt.Parameters = para;

        Room(m,n) = MeasureDiffGeneral(Hamilt, Gate = Gate);

    end
end

% Plot room
figure
pcolor(parameter, parameter, Room)
xlabel('Epsilon')
ylabel('Omega X')
colorbar

figure
surf(parameter, parameter, Room)
xlabel('Epsilon')
ylabel('Omega X')

% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row)
LowestPara2 = parameter(col)

LowestValue = Room(row, col)
