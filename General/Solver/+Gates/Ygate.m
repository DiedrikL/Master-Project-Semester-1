classdef Ygate < Gates.GateInterface
    % The gate and rotation for the Y gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,2));
            rotate = exp(-1i*phi-1i*pi/2)*U;
        end
    end
    
    properties(Constant)
        gate = [0 -1i;1i 0];
    end
end