classdef HighStepNumberGate < Gates.GateInterface
    % The gate and rotation for a gate created with parameter values of
    % epsilon = 1, omegaX = 2, omegaY = 3
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.OnesGate.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [0.636246541797243 + 0.338592616958537i  0.384525833032538 + 0.576788749548769i;
 -0.384525833032496 + 0.576788749548762i  0.636246541797214 - 0.338592616958464i]
        Psi0 = [1, 0; 0 , 1]

    end
end

