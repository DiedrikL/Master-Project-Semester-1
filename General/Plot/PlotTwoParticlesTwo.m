% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 6;
N = 100;
measure = Measure.AvgFidelity

Gate = Gates.Hadamard_Two;

% Setup space
parameter = linspace(-L/2,L/2,N);  

Room = zeros(N,N);

parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.TwoVariableInteractionHamiltonian;
    Hamilt.Measure = measure;

    for n = 1:N
        para = [parameter(n), parameter(m)];
        Hamilt.Parameters = para;

        Room(n,m) = MeasureDiffGeneral(Hamilt, Gate = Gate);

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
xlabel('First variable')
ylabel('Second variable')

% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row)
LowestPara2 = parameter(col)

LowestValue = Room(row, col)
