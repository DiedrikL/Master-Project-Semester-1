%% Plots the difference with respect to a gate for one parameter

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 2;
N = 400;

% Measure and Gate
measure = Measure.AvgFidelity;
Gate = Gates.SGate;
GateTwo = Gates.TGate;

% Parameter names
paraName = '$\epsilon$';
firstGate = '$S gate$';
secondGate = '$T gate$';

%% Known gate parameters

% zero initialization values
epsilon = 0;
omegaX = 0;
omegaY = 0;

% Hadamard values
% epsilon = 2.4210e+00;
% omegaX = 0;
% omegaY = -1.6971e+00;

% X gate values
% epsilon = 2.460987392298953;
% omegaX = 0.000091166808424;
% omegaY = 5.017927547094168;
lambda = 0.0;

% Tautological 1 gate values
% epsilon = 1;
% omegaX = 1;
% omegaY = 1;

% Two particle multiple interactions Hadamard
% epsilon = 4.0668+00;
% omegaX = 1.3276e+00;
% omegaY = 9.9269e+00;
% u_z = 2.2013e-01;
% u_x = 1.2581e+00;
% u_y = 3.5352e-01;

% Two particles interaction Hadamard
% epsilon = 4.108533266720993;
% omegaX = 0.559805913967558;
% omegaY = 9.093423892887524;
% u = 0.5002029547671575;



%% Setup space
parameter = linspace(-L/2,L/2,N);  

LineOne = zeros(1,N);
LineTwo = zeros(1,N);

parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.SimpleHamiltonian;
    Hamilt.Measure = measure;
    para = [parameter(m), omegaX, omegaY];
    Hamilt.Parameters = para;

    LineOne(m) = MeasureDiffGeneral(Hamilt, Gate = Gate);
    LineTwo(m) = MeasureDiffGeneral(Hamilt, Gate = GateTwo);
end



%% Plot Line

baseString = 'Plot of %s for the gates %s and %s';
titleText = sprintf(baseString, paraName, firstGate, secondGate);

fig = figure
plot(parameter, LineOne, parameter, LineTwo, LineWidth=1)

legend(firstGate, secondGate, 'Interpreter','latex')
xlabel(paraName,'Interpreter','latex')
ylabel('Infidelity','Interpreter','latex')
title(titleText, 'Interpreter','latex')

% Scale text size
fontsize(fig, scale=2.5);

% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
% [row, col] = ind2sub(N,I);
% LowestPara1 = parameter(row) %#ok<NOPTS> 
% LowestPara2 = parameter(col) %#ok<NOPTS> 
% 
% LowestValue = Room(row, col) %#ok<NOPTS> 
