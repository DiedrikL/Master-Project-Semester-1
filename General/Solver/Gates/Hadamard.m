classdef Hadamard < GateInterface
    % The gate and rotation for the Hadamard gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            rotate = exp(-1i*phi)*U;
        end
    end
    
    properties(Constant)
        gate = 1/sqrt(2)*[1 1 ; 1 -1];
    end
end