classdef GateOfOne < Gates.GateInterface
    % The gate and rotation for one particle parameters values of 1
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.GateOfOne.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [...
            0.658508654874478 + 0.747215458632845i	-0.0633853683250244 - 0.0633853683250200i;
0.0633853683250204 - 0.0633853683250246i	0.658508654874498 - 0.747215458632866i]
        Psi0 = eye(2);
        Parameters = ones(3,1);

    end
end
