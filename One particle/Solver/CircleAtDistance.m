% Circles origo with a distance given as parameter, with a constant epsilon
% returning the difference from a gate for the values in the circle

function [xVector, Y] = CircleAtDistance(distance, epsilon)

arguments
   distance(1,1) double
   epsilon(1,1) double = 0;
end

% Parameters
L=500;
xVector = linspace(0,2*pi,L);
omegaX = distance*cos(xVector);
omegaY = distance*sin(xVector);
Y=zeros(1,L);

% Finding values
for n=1:length(xVector)
   Y(n) = MeasureDiff(epsilon, omegaX(n), omegaY(n));
end


