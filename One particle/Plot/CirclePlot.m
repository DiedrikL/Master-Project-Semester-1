% Plots a circle with the difference from a given gate with a given
% distance and epsilon

% Parameters
distance = 9.1875;
epsilon = 5.5621;

% Find the difference
[x, y] = CircleAtDistance(distance, epsilon);

% plot
figure
plot(x,y)
