function [Gradients] = CalculateGradients(epsilon, omegaX, omegaY)
% Function that takes tre parameters and finds the gradient for the gate
% selected in MeasureDiff
h = 1e-3;

Gradients(1) = (MeasureDiff(epsilon+h, omegaX, omegaY) ...
            - MeasureDiff(epsilon-h, omegaX, omegaY))/(2*h);
       
Gradients(2) = (MeasureDiff(epsilon, omegaX+h, omegaY) ...
            - MeasureDiff(epsilon, omegaX-h, omegaY))/(2*h);

Gradients(3) = (MeasureDiff(epsilon, omegaX, omegaY+h) ...
            - MeasureDiff(epsilon, omegaX, omegaY-h))/(2*h);

            
