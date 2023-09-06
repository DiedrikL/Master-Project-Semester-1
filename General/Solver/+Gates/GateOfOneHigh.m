classdef GateOfOneHigh < Gates.GateInterface
    % The gate and rotation for one particle parameters values of 1
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.GateOfOneHigh.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [0.658492352052115 + 0.747231741830378i -0.063374073458469 - 0.063374073458459i;
            0.063374073458432 - 0.063374073458495i  0.658492352052048 - 0.747231741830290i];
        Psi0 = eye(2);
        Parameters = ones(3,1);

    end
end
