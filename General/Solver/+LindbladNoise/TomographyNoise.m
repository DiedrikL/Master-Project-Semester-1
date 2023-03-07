classdef Noise
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
            import HamiltSettings.Noise.*
            L = cat(3, gamma1*L1, gamma2*L2, gamma3*L3, gamma4*L4);
%             L = cat(3, HamiltSettings.Noise.gamma1*HamiltSettings.Noise.L1,...
%                 HamiltSettings.Noise.gamma2*HamiltSettings.Noise.L2,...
%                 HamiltSettings.Noise.gamma3*HamiltSettings.Noise.L3,... 
%                 HamiltSettings.Noise.gamma4*HamiltSettings.Noise.L4);
        end

        function D = getD
            D = HamiltSettings.Noise.gamma1*HamiltSettings.Noise.L1'*HamiltSettings.Noise.L1 +...
                HamiltSettings.Noise.gamma2*HamiltSettings.Noise.L2'*HamiltSettings.Noise.L2 +...
                HamiltSettings.Noise.gamma3*HamiltSettings.Noise.L3'*HamiltSettings.Noise.L3 +...
                HamiltSettings.Noise.gamma4*HamiltSettings.Noise.L4'*HamiltSettings.Noise.L4;
        end   

        function L_n = getL_n(n)
            switch n
                case 1
                    L_n = HamiltSettings.Noise.L1;
                case 2
                    L_n = HamiltSettings.Noise.L2;
                case 3
                    L_n = HamiltSettings.Noise.L3;
                case 4
                    L_n = HamiltSettings.Noise.L4;
                otherwise
                    error('No such noise')
            end
        end

        function gamma_n = getGamma_n(n)
            import HamiltSettings.Noise
            switch n
                case 1
                    gamma_n = HamiltSettings.Noise.gamma1;
                case 2
                    gamma_n = HamiltSettings.Noise.gamma2;
                case 3
                    gamma_n = HamiltSettings.Noise.gamma3;
                case 4
                    gamma_n = HamiltSettings.Noise.gamma4;
                otherwise
                    error('No such gamma')
            end
        end
    end
end