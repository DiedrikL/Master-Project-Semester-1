classdef Hadamard < GateInterface
    % The gate and rotation for the Hadamard gate
    
    methods
        function rotation = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            rotation = exp(-1i*phi)*U;
        end

        function gate = gate

            gate = 1/sqrt(2)*[1 1 ; 1 -1];

        end
    end
end