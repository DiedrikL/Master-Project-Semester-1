RhoFunk = @(rho, hamilt) HamiltSettings.Solvers.Runge_Kutta_Rho.solver (rho, hamilt);
Lsteps = 1e2;
Hsteps = 1e3;
timeL = TimeOptions(Tsize = Lsteps);
timeH = TimeOptions(Tsize = Hsteps);
parameters = [1,1,1,1];
gamma = 0;

Lindb = Hamiltonians.LindbladRhoTwo(...
    Parameters = parameters,...
    Gamma = gamma, ...
    Time = timeL);
Hamilt = Hamiltonians.TwoParticleInteractionHamiltonian(...
    Parameters = parameters,...
    Time = timeH);


Rho0 = zeros(4);
Rho0(1) = 1;

Ltest = RhoFunk(Rho0, Lindb);
Htest = SolveForStartValue(Hamilt, [1;0;0;0]);
LindbladA = Ltest(1)
HamiltA = Htest(1)
Difference = abs(Ltest(1) - abs(Htest(1))^2)
H = Htest*Htest';
normDiff = norm(H-Ltest)


return


% Setup values 
index = Hamilt.matrixSize;
matrixSize = index^2;
scale = 1/double(index);

% Extract gate
targetGate = hValue;

% initialize matrix
targetPart = zeros(index, index, matrixSize, matrixSize);

for n = 1:index
    for m = 1:index
        Rho = sparse(m, n, 1, index, index);
        targetPart(m,n,:,:) = kron(targetGate*Rho*targetGate', Rho);

    end
end
TargetChoi = sum(targetPart,[1, 2]);
TargetChoi = squeeze(TargetChoi);
TargetChoi = TargetChoi.*scale