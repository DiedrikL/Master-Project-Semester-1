classdef OnesGate < Gates.GateInterface
    % The gate and rotation for 6 parameters with values of 1
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(4,4) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.OnesGate.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [1.3667e-01 + 5.0479e-01i  -4.9513e-01 + 6.5680e-02i  -4.9513e-01 + 6.5680e-02i   2.0637e-04 - 4.7696e-01i;...
        6.5687e-02 + 4.9519e-01i   5.2300e-01 - 1.0600e-03i  -4.7699e-01 + 1.1720e-03i  -6.6121e-02 + 4.9504e-01i;...
        6.5687e-02 + 4.9519e-01i  -4.7699e-01 + 1.1720e-03i   5.2300e-01 - 1.0600e-03i  -6.6121e-02 + 4.9504e-01i;...
        -2.0640e-04 + 4.7703e-01i   4.9506e-01 + 6.6123e-02i   4.9506e-01 + 6.6123e-02i   1.3695e-01 - 5.0480e-01i];
        Psi0 = eye(4);
        Parameters = ones(6,1);

    end
end
