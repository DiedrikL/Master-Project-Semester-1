classdef Ygate < GateInterface
    % The gate and rotation for the Y gate
    
    methods
        function rotation = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,2));
            rotation = exp(-1i*phi-1i*pi/2)*U;
        end
    end
    
    methods(Static)
        function gate = gate
            gate = [0 -1i;1i 0];
        end
    end
end