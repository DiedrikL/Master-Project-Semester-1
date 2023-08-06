%% Plots the difference in measurement with respect to a gate


% Clear memory and set format for output to screen
clear
format short e

% Parameter size and resolution
L = 8;
N = 400;

startValue1 = -L/2;
endValue1 = L/2;

% Measure and Gate
measure1 = Measure.NormDistance;
measure2 = Measure.AvgFidelity;

Gate = Gates.GateOfOne;

% Setup space
parameter = linspace(startValue1, endValue1,N);  

Room1 = zeros(N,N);

%% Known parameters for gates

% Hadamard values
% epsilon = 2.4210e+00;
% omegaX = 0;
% omegaY = -1.6971e+00;

% X gate values
% epsilon = 2.460987392298953;
% omegaX = 0.000091166808424;
% omegaY = 5.017927547094168;
% lambda = 0.0;

% Tautological 1 gate values
epsilon = 1;
omegaX = 1;
omegaY = 1;

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




%% Finding the room
parfor m = 1:N
    m
    % Hamiltonian
    Hamilt1 = Hamiltonians.SimpleHamiltonian;
    Hamilt1.Measure = measure1;

    Hamilt2 = Hamiltonians.SimpleHamiltonian;
    Hamilt2.Measure = measure2;

    for n = 1:N
        para = [parameter(n), parameter(m), omegaY]; %#ok<PFBNS> 

        Hamilt1.Parameters = para;
        Room1(m,n) = MeasureDiffGeneral(Hamilt1, Gate = Gate);

        Hamilt2.Parameters = para;
        Room2(m,n) = MeasureDiffGeneral(Hamilt2, Gate = Gate);
    end
end

%% Plot room
firstPara = '$\epsilon$';
secondPara = '$\Omega_x$';

% figure
% pcolor(parameter, parameter, Room1)
% xlabel(firstPara,'Interpreter','latex')
% ylabel(secondPara,'Interpreter','latex')
% colorbar

fig = figure;
tiledlayout(1,2)
axNorm = nexttile;
surf(parameter+epsilon, parameter+omegaY, Room1)
xlabel(firstPara,'Interpreter','latex')
ylabel(secondPara,'Interpreter','latex')
title('Norm measure')
shading interp

axAVG = nexttile;
surf(parameter+epsilon, parameter+omegaY, Room2)
xlabel(firstPara,'Interpreter','latex')
ylabel(secondPara,'Interpreter','latex')
title('AVG measure')
shading interp

% Scale text size
fontsize(fig, scale=2);

% Link rotation of figures
Link = linkprop([axNorm, axAVG],{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim', 'ZLim'});
setappdata(gcf, 'StoreTheLink', Link);

%% Plot 2-D plot

figPC = figure;
tiledlayout(1,2)
axNorm = nexttile;
pcolor(parameter, parameter, Room1)
colorbar
xlabel(firstPara,'Interpreter','latex')
ylabel(secondPara,'Interpreter','latex')
title('Norm measure')
shading interp

axAVG = nexttile;
pcolor(parameter, parameter, Room2)
colorbar
xlabel(firstPara,'Interpreter','latex')
ylabel(secondPara,'Interpreter','latex')
title('AVG measure')
shading interp

% Scale text size
fontsize(figPC, scale=2);


