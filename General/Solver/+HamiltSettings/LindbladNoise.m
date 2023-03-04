classdef LindbladNoise

    properties(Constant)
        L = HamiltSettings.Noise.getL;
        D = HamiltSettings.Noise.getD;
    end


    methods(Static)
        function noise = getNoise(rho)
            %Returns the noise for a given rho

            arguments
                rho(4,4) double
            end

            L_sum = zeros(4,4);
            L = HamiltSettings.LindbladNoise.L;
            D = HamiltSettings.LindbladNoise.D;

            for n = 1:4
                L_n = L(:,:,n);
                gamma_n = HamiltSettings.Noise.getGamma_n(n);
                L_sum = L_sum + gamma_n .* L_n * rho * L_n';

            end
            
            noise = D*rho+rho*D -2*L_sum;
        end
    end

end

