classdef RandomUGate < Gates.GateInterface
    % The gate and rotation for the Hadamard gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(4,4) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.RandomUGate.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [0.0790 + 0.9964i  -0.0011 + 0.0131i  -0.0011 + 0.0131i  -0.0255 + 0.0032i;
  -0.0008 + 0.0174i   0.2497 - 0.9499i   0.0338 + 0.0265i   0.1798 - 0.0298i;
  -0.0008 + 0.0174i   0.0338 + 0.0265i   0.2497 - 0.9499i   0.1798 - 0.0298i;
  -0.0198 + 0.0036i  -0.1745 - 0.0532i  -0.1745 - 0.0532i   0.1596 + 0.9526i];
        Psi0 = eye(4);

    end
end
