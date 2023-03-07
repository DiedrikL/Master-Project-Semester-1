classdef GeneratedNoise < LindbladNoise.TwoParticleNoiseInterface
    % A noise generated in python, gives four identical jump operators
    % generated from the constant
    properties(Constant)
        L = [1.2598-0.4755i -0.1383+0.3142i  0.6477-0.908i   1.523-1.4123i;...
         -0.2342+1.4656i  0.529+0.3115i  1.5792+0.0675i  0.7674-1.4247i;...
         -0.4695-0.5444i  0.5426+0.1109i  0.2997-0.6137i -0.4657+0.3757i;...
         0.242-0.6006i -1.9133-0.2917i -1.7249-0.6017i  0.2008+2.3896i]
        Gamma = 1;
    end

    methods(Static)
        function L = getL
            % The jump operators, using repmat to replicate the L to return
            % a 4x4x4 matrix to simulate four independent noises
            L = repmat(LindbladNoise.GeneratedNoise.L,1,1,4);
        end

        function D = getD
            % Pre calculates the state independent noise, multiplies the D
            % value to get same effect as four independents noises
            tmp = LindbladNoise.GeneratedNoise.Gamma...
                *LindbladNoise.GeneratedNoise.L'...
                *LindbladNoise.GeneratedNoise.L;
            D = tmp*4;
        end

        function Gamma = getGamma
            Gamma = repmat(LindbladNoise.GeneratedNoise.Gamma, 4,1);
        end
    end

end
