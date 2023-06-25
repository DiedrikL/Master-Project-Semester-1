

N = 10000;
epsilon = 1;
omegaX = 1;
omegaY = 1;
scale = 2;

time = TimeOptions(Tsize = 2*pi);
timeTotal = zeros(1,N);
diff = zeros(1,N);


parameters = [epsilon, omegaX, omegaY];
gate = Gates.GateOfOne;


Hamilt = Hamiltonians.ConstantHamiltonian(Parameters = parameters, Time = time);
defaultValue = MeasureDiffGeneral(Hamilt, Gate = gate);
Smooth = Hamiltonians.SmoothHamiltonianTime(Time = time, Scale = scale, ...
    Epsion = epsilon, OmegaX = omegaX, OmegaY = omegaY, Parameters = 0);

for n = 1:N
    timeTotal(n) = 1e-3*n;
    Smooth.Time.Tpulse = timeTotal(n);
    value = MeasureDiffGeneral(Smooth, Gate = gate);
    diff(n) = defaultValue - value;
end

figure
plot(timeTotal, abs(diff))

