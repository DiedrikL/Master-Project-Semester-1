% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 4;
N = 50;

% Measure and Gate
measure = Measure.ChoiFidelity
Gate = Gates.Hadamard;

% Static parameters
epsilon = 2.4210e+00;
omegaX = 3.1426e-16;
omegaY = 1.6971e+00;
lambda = 0.1;

% Setup space
parameter = linspace(-L/2,L/2,N);  

Room = zeros(N,N);

parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.LindbladOne(Lambda = lambda);
    Hamilt.Measure = measure;

    for n = 1:N
        para = [parameter(n), omegaX, parameter(m)];
        Hamilt.Parameters = para;

        Room(m,n) = MeasureDiffGeneral(Hamilt, Gate = Gate);

    end
end

% Plot room
figure
pcolor(parameter, parameter, Room)
xlabel('First variable')
ylabel('Second variable')
colorbar

figure
surf(parameter, parameter, Room)
xlabel('Epsilon')
ylabel('Omega Y')

% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row)
LowestPara2 = parameter(col)

LowestValue = Room(row, col)
