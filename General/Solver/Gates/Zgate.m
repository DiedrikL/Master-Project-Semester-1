classdef Zgate < GateInterface
    % The gate and rotation for the Z gate
    
    methods
        function rotation = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            rotation = exp(-1i*phi)*U;        
        end
    end
    
    methods(Static)
        function gate = gate
            gate = [1 0;0 -1];
        end
    end
end