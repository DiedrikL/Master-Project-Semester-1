% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 5;
N = 120;

Gate = Gates.OnesGate;

% Setup space
parameter = linspace(-L/2,L/2,N);    

Room = zeros(N,N);

parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.TwoVariableInteractionHamiltonian;
    Hamilt.Measure = 1;

    for n = 1:N
        para = [parameter(n), parameter(m)];
        Hamilt.Parameters = para;

        Room(m,n) = MeasureDiffGeneral(Hamilt, Gate = Gate);

    end
end

% Plot room
figure
pcolor(parameter, parameter, Room)
colorbar

figure
surf(parameter, parameter, Room)

% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row)
LowestPara2 = parameter(col)
% LowestValue = MeasureDiff(epsilon(row), omegaX, omegaY(col))
lowValues = sum(result<1e-1)