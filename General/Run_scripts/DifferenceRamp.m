

N = 1000;
epsilon = 0;
omegaX = 1;
omegaY = 0;
scale = 1;

pulseLength = 0.5*pi;
timeLine = linspace(-pulseLength+1e-10,pulseLength, N);

time = TimeOptions(Tpulse = pulseLength);
diff = zeros(1,N);


parameters = [epsilon, omegaX, omegaY];
gate = Gates.Xgate;


Hamilt = Hamiltonians.ConstantHamiltonian(Parameters = parameters, Time = time);
ConstantPulseValue = MeasureDiffGeneral(Hamilt, Gate = gate) %#ok<NOPTS> 

Smooth = Hamiltonians.SmoothHamiltonianTime(...
    Time = time,...
    Scale = scale,...
    Epsilon = epsilon,...
    OmegaX = omegaX,...
    OmegaY = omegaY,...
    Parameters = 0);

for n = 1:N
    Smooth.Parameters = timeLine(n);
    value = MeasureDiffGeneral(Smooth, Gate = gate);
    diff(n) = value;
end

figure
plot(timeLine, abs(diff))

