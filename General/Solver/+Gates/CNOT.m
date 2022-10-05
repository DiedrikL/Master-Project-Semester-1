classdef CNOT < Gates.GateInterface
    % The gate and rotation for the Hadamard gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(4,4) double
            end

            phi = angle(U(1,1));
            rotate = exp(-1i*phi)*U;
        end
    end

    properties(Constant)
        gate = [1 0 0 0; 0 1 0 0;...
            0 0 0 1; 0 0 1 0];
        Psi0 = eye(4);

    end
end
