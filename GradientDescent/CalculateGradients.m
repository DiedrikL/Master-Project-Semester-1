function [Gradients] = CalculateGradients(epsilon, omega)
% Function that takes tre parameters and takes a step 
h = 1e-3;

Gradients(1) = (MeasureDiff(epsilon+h, omega) ...
            - MeasureDiff(epsilon-h, omega))/(2*h);
       
Gradients(2) = (MeasureDiff(epsilon, omega+h) ...
            - MeasureDiff(epsilon, omega-h))/(2*h);

Gradients(3) = 1i*(MeasureDiff(epsilon, omega+1i*h) ...
            - MeasureDiff(epsilon, omega-1i*h))/(2*h);

            
