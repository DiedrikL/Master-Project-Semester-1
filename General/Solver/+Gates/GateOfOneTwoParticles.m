classdef GateOfOneTwoParticles < Gates.GateInterface
    % The gate and rotation for 6 parameters with values of 1
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(4,4) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.GateOfOneTwoParticles.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        gate = [
    0.136666453817809 + 0.504785808220076i -0.495127510989115 + 0.065679718110849i -0.495127510989115 + 0.065679718110849i  0.000206366412032 - 0.476957396944250i;
    0.065687496597786 + 0.495186149226107i  0.523003627629685 - 0.001060002371042i -0.476993881512651 + 0.001171971895699i -0.066120588829379 + 0.495040547745091i;
    0.065687496597785 + 0.495186149226108i -0.476993881512650 + 0.001171971895698i  0.523003627629686 - 0.001060002371040i -0.066120588829379 + 0.495040547745091i;
     -0.000206399000111 + 0.477032715037433i  0.495060091162563 + 0.066123199165597i  0.495060091162565 + 0.066123199165595i  0.136952315386334 - 0.504802824452323i]
        Psi0 = eye(4);
        Parameters = ones(6,1);

    end
end
