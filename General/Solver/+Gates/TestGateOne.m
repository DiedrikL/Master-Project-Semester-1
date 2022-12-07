classdef TestGateOne < Gates.GateInterface
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
        gate = [     0.974295643352509 - 0.208276190241046i  0.076780351251113 + 0.038390175625542i;
 -0.076780351251099 + 0.038390175625565i  0.974295643352568 + 0.208276190241064i]
        Psi0 = [1, 0; 0 , 1]

    end
end

