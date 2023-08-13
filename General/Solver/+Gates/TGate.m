classdef TGate < Gates.GateInterface
    % The gate and rotation for one qubit T gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.TGate.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [1 0;...
                0 exp(1i*pi/4)];
        Psi0 = eye(2);

    end
end
