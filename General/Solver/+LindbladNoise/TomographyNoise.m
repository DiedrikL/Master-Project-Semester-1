classdef TomographyNoise < LindbladNoise.TwoParticleNoiseInterface
    % Class for noise levels from Lindblad Tomography of a Superconducting Quantum Processor
    properties(Constant)
        L1 = [ 0.501+0.001i 0.000+0.001i -0.0002+0.002i -0.002+0.000i;
0.000-0.001i 0.499-0.001i -0.001+0.001i -0.002+0.002i;
-0.001-0.001i 0.001-0.001i -0.499+0.000i 0.000+0.001i;
0.002+0.000i -0.001-0.001i 0.000+0.000i -0.501+0.000i];
        L2 = [0.448-0.001i 0.109+0.246i 0.001-0.002i 0.002-0.002i;
0.061-0.125i -0.451+0.002i -0.001+0.002i 0.002+0.005i;
-0.003-0.002i -0.003+0.001i 0.454+0.001i 0.109+0.249i;
-0.004+0.001i 0.000+0.002i 0.064-0.131i -0.451-0.002i];
        L3 = [ -0.072+0.161i 0.639-0.031i -0.003-0.001i 0.007+0.00i;
0.114+0.039i 0.072-0.161i -0.001+0.001i -0.005-0.001i;
0.002+0.003i 0.001+0.002i -0.071+0.162i 0.655-0.044i;
0.002-0.003i -0.001-0.002i 0.134+0.035i 0.071-0.163i]
        L4 = [ 0.004+0.000i -0.001-0.003i 0.000-0.703i -0.003+0.00i;
0.000-0.001i 0.000-0.002i -0.004-0.002i 0.000-0.703i;
0.001+0.078i 0.002+0.001i 0.000+0.002i -0.002-0.003i;
0.000-0.001i -0.001+0.079i 0.000-0.001i -0.004+0.000i];
        gamma1 = 0.071;
        gamma2 = 0.097;
        gamma3 = 0.042;
        gamma4 = 0.055;
    end

    methods(Static)
        function L = getL
            L = cat(3, LindbladNoise.TomographyNoise.L1,...
                LindbladNoise.TomographyNoise.L2,...
                LindbladNoise.TomographyNoise.L3,... 
                LindbladNoise.TomographyNoise.L4);
        end

        function D = getD
            D = LindbladNoise.TomographyNoise.gamma1*LindbladNoise.TomographyNoise.L1'*LindbladNoise.TomographyNoise.L1 +...
                LindbladNoise.TomographyNoise.gamma2*LindbladNoise.TomographyNoise.L2'*LindbladNoise.TomographyNoise.L2 +...
                LindbladNoise.TomographyNoise.gamma3*LindbladNoise.TomographyNoise.L3'*LindbladNoise.TomographyNoise.L3 +...
                LindbladNoise.TomographyNoise.gamma4*LindbladNoise.TomographyNoise.L4'*LindbladNoise.TomographyNoise.L4;
        end

        function Gamma = getGamma
            Gamma = [LindbladNoise.TomographyNoise.gamma1,...
                LindbladNoise.TomographyNoise.gamma2,...
                LindbladNoise.TomographyNoise.gamma3,...
                LindbladNoise.TomographyNoise.gamma4];
        end
    end
end