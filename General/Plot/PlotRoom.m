%% Plots the difference with respect to a gate for different parameters
% Plots a 3-d plot and a 2-d plot with a colorbar in one figure, within a
% default domain of (-L/2, L/2). There are N points in each direction
% making it N^2 points in the room.

% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 10;
N = 200;

% Measure and Gate
measure = Measure.AvgFidelity;
Gate = Gates.Hadamard_Two;

%% Known parameters for gates

% zero initialization values
% epsilon = 0;
% omegaX = 0;
% omegaY = 0;

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
epsilon = 4.108533266720993;
omegaX = 0.559805913967558;
omegaY = 9.093423892887524;
u = 0.5002029547671575;


% Setup space
parameter = linspace(-L/2,L/2,N);  

Room = zeros(N,N);

%% Names of parameter used
firstPara = '$\epsilon$';
secondPara = '$\u$';


%% Measuring the room
parfor m = 1:N
    m
    % Hamiltonian
    Hamilt = Hamiltonians.TwoParticleInteractionHamiltonian;
    Hamilt.Measure = measure;

    for n = 1:N
%         para = [parameter(n), omegaX, omegaY, parameter(m)]; %#ok<PFBNS> 
        para = [parameter(n), omegaX, omegaY, parameter(m)]; %#ok<PFBNS> 
        Hamilt.Parameters = para;

        Room(m,n) = MeasureDiffGeneral(Hamilt, Gate = Gate)/2;

    end
end

%% Plot room

fig = figure;
tiledlayout(1,2)
axSurf = nexttile;
surf(parameter, parameter, Room)
xlabel(firstPara,'Interpreter','latex')
ylabel(secondPara,'Interpreter','latex')
title('3D-Plot')
shading interp

axPcol = nexttile;
pcolor(parameter, parameter, Room)
colorbar
xlabel(firstPara,'Interpreter','latex')
ylabel(secondPara,'Interpreter','latex')
title('2D-Plot')
shading interp

% Scale text size
fontsize(fig, scale=2.5);


% Finds and prints lowest value with parameters
[M, I] = min(Room,[],'all','linear');
[row, col] = ind2sub(N,I);
LowestPara1 = parameter(row) %#ok<NOPTS> 
LowestPara2 = parameter(col) %#ok<NOPTS> 

LowestValue = Room(row, col) %#ok<NOPTS> 
