classdef GeneratedGateTwo < Gates.GateInterface
    % The gate and rotation for a generated gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(4,4) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.GeneratedGate.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        Psi0 = eye(4);
        gate =  [...
   0.1971 - 0.0149i  -0.5819 - 0.1964i  -0.5819 - 0.1964i  -0.4386 + 0.1193i;
  -0.6478 - 0.1217i   0.2905 - 0.4880i  -0.3166 + 0.3066i  -0.1207 + 0.1850i;
  -0.6478 - 0.1217i  -0.3166 + 0.3066i   0.2905 - 0.4880i  -0.1207 + 0.1850i;
  -0.2270 + 0.2014i  -0.0330 + 0.3240i  -0.0330 + 0.3240i  -0.4943 - 0.6719i];
    end

end
