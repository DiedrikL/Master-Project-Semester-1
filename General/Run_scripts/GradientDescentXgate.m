clear

% Setup time
T = 0.5*pi;

Time = TimeOptions;


Beta = 0.1;
learning = 1e-4;
maxIter = 100;
psi0 = [1;0];
Scale = 1000;


% Create the hamiltonian
Hamilt1 = Hamiltonians.OneVariableXgate(...
    Time = Time, Parameters = T, Scale = Scale);

Hamilt2 = Hamiltonians.OneVariableXgate(...
    Time = Time, Parameters = T, Scale = 5);

% set target gate
HGate = Gates.Xgate;




% Run gradient descent
[para, result] = GradientDescent.GradientDescent(...
    Hamilt1, HGate, Beta=Beta, learning=learning, maxIter = maxIter)

piPeriods = para/pi


% Plot result of gradient descent

% Set result of gradient descent as parameters
Hamilt1.Parameters = para;
Hamilt2.Parameters = para;
%Hamilt.Time.Tpulse = para;

period = Hamilt1.TimeVector;



[Time1, Psi1] = SolveTDSEgeneral(psi0, Hamilt1);
[~, Psi2] = SolveTDSEgeneral(psi0, Hamilt2);

leng = length(period);
Y1 = zeros(1, leng);
Y2 = zeros(1, leng);

H1 = Hamilt1.createHamiltonian;
H2 = Hamilt2.createHamiltonian;


for n = 1:leng
    tmp1 = H1(period(n));
    Y1(n) = tmp1(1,2);
    
    tmp2 = H2(period(n));
    Y2(n) = tmp2(1,2);
end


a = abs(Psi1(1,:)).^2;
b = abs(Psi1(2,:)).^2;
c = abs(Psi2(1,:)).^2;
d = abs(Psi2(2,:)).^2;


norm1 = a+b;
norm2 = c+d;

% Plot the result
hold off
plot(Time1, a)
hold on
plot(Time1, c)
plot(period, Y1)
plot(period, Y2)
legend('psi 1', 'psi 2', 'field 1', 'field 2')

pause
clf
hold on
plot(Time1, b)
plot(Time1, d)
plot(period, Y1)
plot(period, Y2)
legend('psi 1', 'psi 2', 'field 1', 'field 2')


pause
clf
hold on
plot(Time1, norm1)
plot(Time1, norm2)


