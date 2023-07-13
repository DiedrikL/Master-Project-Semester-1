% Plots the difference with respect to a gate for different parameters

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 8;
N = 400;

% Measure and Gate
measure = Measure.AvgFidelity;
Gate = Gates.Xgate;



% Setup space
parameter = linspace(-L/2,L/2,N);  

Line = zeros(1,N);

for m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.SimpleHamiltonian;
    Hamilt.Measure = measure;
    para = [0, parameter(m), 0];
    Hamilt.Parameters = para;

    Line(m) = MeasureDiffGeneral(Hamilt, Gate = Gate);
end


% Plot room

figure
plot(parameter, Line)

xlabel('Omega X')

% Finds and prints lowest value with parameters
[M, I] = min(Line,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row)
LowestPara2 = parameter(col)

LowestValue = Line(row, col)
