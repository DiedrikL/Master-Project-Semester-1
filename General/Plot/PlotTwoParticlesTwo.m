% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 6;
N = 80;

% Hamiltonian
Hamilt = Hamiltonians.TwoVariableInteractionHamiltonian;
Gate = Gates.SquareRootSwap;

% Setup space
parameter = linspace(-L/2,L/2,N);    

Room = zeros(N,N);

for m = 1:N
    m
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