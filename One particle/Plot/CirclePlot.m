% Plots a circle with the difference from a given gate with a given
% distance and epsilon

% Parameters
% distance = 9.1875;
% epsilon = 5.5621;

distance = 1.71859;
epsilon = 2.38191;

% Find the difference
[x, y] = CircleAtDistance(distance, epsilon);

% plot
figure
plot(x,y)
