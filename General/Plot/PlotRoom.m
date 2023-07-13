%% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 12;
N = 160;

% Measure and Gate
measure = Measure.AvgFidelity;
Gate = Gates.Xgate;

%% Static parameters

% Hadamard values
% epsilon = 2.4210e+00;
% omegaX = 3.1426e-16;
% omegaY = -1.6971e+00;

% X gate values
epsilon = 2.460987392298953;
omegaX = 0.000091166808424;
omegaY = 5.017927547094168;
lambda = 0.0;

% Tautological 1 gate values
% epsilon = 1;
% omegaX = 1;
% omegaY = 1;

% Setup space
parameter = linspace(-L/2,L/2,N);  

Room = zeros(N,N);

%% Finding the room
parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.SimpleHamiltonian;
    Hamilt.Measure = measure;

    for n = 1:N
        para = [epsilon, parameter(n),parameter(m)]; %#ok<PFBNS> 
        Hamilt.Parameters = para;

        Room(m,n) = MeasureDiffGeneral(Hamilt, Gate = Gate);

    end
end

%% Plot room
figure
pcolor(parameter, parameter, Room)
xlabel('Omega X')
ylabel('Omega Y')
colorbar

figure
surf(parameter, parameter, Room)
xlabel('Omega X')
ylabel('Omega Y')

% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row)
LowestPara2 = parameter(col)

LowestValue = Room(row, col)
