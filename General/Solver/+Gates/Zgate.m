classdef Zgate < Gates.GateInterface
    % The gate and rotation for the Z gate
    
    methods(Access = public, Static)
        function roate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            roate = exp(-1i*phi)*U;        
        end
    end
    
    properties(Constant)
        gate = [1 0;0 -1];
    end
end