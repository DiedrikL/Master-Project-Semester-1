classdef GeneratedNoiseTraceless < LindbladNoise.TwoParticleNoiseInterface
    % A noise generated using the GenerateRandomNoise script using default
    % parameters
    properties(Constant)
        L = [0.0452220476344547 + 0.389719909673081i...
        	-0.996094096614954 - 0.409057845790514i...
        	0.176601628617548 + 1.00038318883897i...
        	1.81692224917996 - 2.13346755941796i;...

            0.867232157629573 - 0.0595506104590645i...
    		0.0602519096772833 - 0.906304239609380i...
    		0.755179935677488 - 0.801329298311214i...
    		-0.123833350279246 + 0.403977280549421i;...

            0.975986463472540 - 0.661011014460339i...
    		-1.29744747716739 - 0.284902829463087i...
    		-0.00803401840821616 + 0.467350598527234i...
    		-1.11060135506064 - 0.958499409348658i;...

            0.337390252379212 + 0.305950915068987i...
    		0.917388589145936 - 0.0647868558912201i...
    		1.84438963700050 + 0.273804791937703i...
    		-0.0974399389035219 + 0.0492337314090649i]
        Gamma = 1;
    end

    methods(Static)
        function L = getL
            % The jump operators, using repmat to replicate the L to return
            % a 4x4x4 matrix to simulate four independent noises
            L = repmat(LindbladNoise.GeneratedNoiseTraceless.L,1,1,4);
        end

        function D = getD
            % Pre calculates the state independent noise, multiplies the D
            % value to get same effect as four independents noises
            tmp = LindbladNoise.GeneratedNoiseTraceless.Gamma...
                *LindbladNoise.GeneratedNoiseTraceless.L'...
                *LindbladNoise.GeneratedNoiseTraceless.L;
            D = tmp*4;
        end

        function Gamma = getGamma
            Gamma = repmat(LindbladNoise.GeneratedNoiseTraceless.Gamma, 4,1);
        end
    end

end