classdef GateOfOneConstant < Gates.GateInterface
    % The gate and rotation for one particle parameters values of 1
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.GateOfOneConstant.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [...
             -0.999999997566526 + 0.000023254397652i  0.000046508795304 - 0.000046508795304i
 -0.000046508795304 - 0.000046508795304i -0.999999997566526 - 0.000023254397652i]
        Psi0 = eye(2);
        Parameters = ones(3,1);

    end
end
