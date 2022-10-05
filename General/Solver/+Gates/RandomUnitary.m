classdef RandomUnitary < Gates.GateInterface
    % The gate and rotation for the Hadamard gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(2,2) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.RandomUnitary.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        Psi0 = eye(2);
        gate = Gates.RandomUnitary.getRandom();
    end


    methods(Access = public, Static)
        function Unitary = getRandom()
            phi = 2*pi*rand(); % Z
            theta = 2*pi*rand(); % X
            omega = 2*pi*rand(); % Y

            Unitary = [exp(-1i*(phi+omega)/2)*cos(theta) -exp(1i*(phi-omega)/2)*sin(theta);...
                exp(-1i*(phi-omega)/2)*sin(theta) exp(1i*(phi+omega)/2)*cos(theta)];
    

        end

        function Reset()
            clear RandomUnitary
        end
    end
end
