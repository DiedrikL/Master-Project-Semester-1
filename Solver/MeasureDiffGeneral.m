function Diff = MeasureDiffGeneral(H, gates, options)
% Function that measures the difference from a given gate for the
% Hamiltonian. 
%
% H the hamiltonian function handle
%
% gate the gate to compare to, default Hadamard
%
% rotation the rotation to be done to remove the global phase

arguments
    H function_handle
    gates function_handle = @Gates.Hadamard;
    options.T(1,1) double = 2*pi;
    options.Tstart(1,1) double = 0;
    options.Tsize(1,1) double = 100;
end

% Compare distance for a gate U with a given gate

% Start positions
psi0 = [1;0];
psi1 = [0;1];

% Getting the solution for the start positions
[~, Psi1] = SolveTDSEgeneral(psi0, H, ...
    T=options.T, Tstart=options.Tstart, Tsize=options.Tsize);
[~, Psi2] = SolveTDSEgeneral(psi1, H, ...
    T=options.T, Tstart=options.Tstart, Tsize=options.Tsize);

% Creating the gate
U1 = [Psi1(1, end); Psi1(2, end)];
U2 = [Psi2(1, end); Psi2(2, end)];
U = [U1, U2];

[gate, U] = gates(U);


% Measuring distance
Diff = norm(U-gate);


