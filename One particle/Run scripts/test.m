
L=500;
Epsilon = 5.5621;
xVector = linspace(0,2*pi,L);
Omega = 9.1875*(cos(xVector) - 1i*sin(xVector));
Y=zeros(L);

for n=1:length(xVector)
   Y(n) = MeasureDiff(Epsilon, Omega(n));
end

plot(xVector, Y)
