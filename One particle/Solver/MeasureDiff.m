function Diff = MeasureDiff(epsilon, omegaX, omegaY)

% Compare distance for a gate U with a given gate

% Start positions
psi0 = [1;0];
psi1 = [0;1];

% Getting the solution for the start positions
[~, Psi1] = SolveTDSE(epsilon, omegaX, omegaY, psi0);
[~, Psi2] = SolveTDSE(epsilon, omegaX, omegaY, psi1);

% Creating the gate
U1 = [Psi1(1, end); Psi1(2, end)];
U2 = [Psi2(1, end); Psi2(2, end)];
U = [U1, U2];

% Correcting for global phase hadamard
phi = angle(U(1,1));
U = exp(-1i*phi)*U;
HAD = 1/sqrt(2)*[1 1 ; 1 -1];
gate = HAD;

% Correcting for global phase xGate
% phi = angle(U(1,1));
% U = exp(-1i*phi)*U;
% Xgate = [0 1;1 0];
% gate = Xgate;

% Correcting for global phase yGate
% phi = angle(U(1,2));
% U = exp(-1i*phi-1i*pi/2)*U;
% Ygate = [0 -1i;1i 0];
% gate = Ygate;

% Correcting for global phase zGate
% phi = angle(U(1,1));
% U = exp(-1i*phi)*U;
% Zgate = [1 0;0 -1];
% gate = Zgate;

% Test with identity
% phi = angle(U(1,1));
% U = exp(-1i*phi)*U;
% gate = eye(2);

% Measuring distance
Diff = norm(U-gate);