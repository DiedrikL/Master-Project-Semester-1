classdef LindbladNoise
    % Class with methods to construct a two particle noise for a noise
    % source specified during construction
    properties(SetAccess = immutable)
        L (4,4,4) double
        D (4,4) double
        Gamma (4,1) double
    end


    methods(Access = public)
        function this = LindbladNoise(NoiseType)
            % Constructor that takes the noise from the noise class and
            % saves the calculated output
            arguments
                NoiseType LindbladNoise.TwoParticleNoiseInterface
            end
            this.L = NoiseType.getL;
            this.D = NoiseType.getD;
            this.Gamma = NoiseType.getGamma;
        end
        
        function noise = getNoise(this, rho)
            %Returns the noise for a given rho

            arguments
                this LindbladNoise.LindbladNoise
                rho(4,4) double
            end

            L_sum = zeros(4,4);

            for n = 1:4
                L_n = this.L(:,:,n);
                gamma_n = this.Gamma(n);
                L_sum = L_sum + gamma_n .* L_n * rho * L_n';

            end
            
            noise = this.D*rho+rho*this.D - 2*L_sum;
        end
    end

end

