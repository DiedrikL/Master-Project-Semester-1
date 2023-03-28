classdef TwoParticleNoises
    % Enum for all possible two particle noise
    properties
        NoiseClass LindbladNoise.LindbladNoise
    end

    methods
        function con = TwoParticleNoises(Noises)
            con.NoiseClass = Noises;
        end
    end

    enumeration
        Tomography(LindbladNoise.LindbladNoise(LindbladNoise.TomographyNoise))
        Generated(LindbladNoise.LindbladNoise(LindbladNoise.GeneratedNoise))
        GeneratedTraceless(LindbladNoise.LindbladNoise(LindbladNoise.GeneratedNoiseTraceless))
    end
end