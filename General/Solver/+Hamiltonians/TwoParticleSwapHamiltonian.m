classdef TwoParticleSwapHamiltonian < Hamiltonians.Interfaces.HamiltonianInterface
    properties
        Gamma double
    end
    
    properties(Constant)
        matrixSize = 4;
    end

    
    methods
        function this = TwoParticleSwapHamiltonian(options)
            % A two particle hamiltonian with parameters for the
            % interaction
            % Takes the optional name value parameters Time and Gamma
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            % Gamma is the gamma used by this hamiltonian
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Gamma double {mustBeNonzero} = 1;
                options.Parameters(1,1) double {mustBeReal} = zeros(1,1);
            end
            
            this.Time = options.Time;
            this.Gamma = options.Gamma;
            this.Parameters = options.Parameters;
        end
        
        function H = createHamiltonian(this)
            % Creates a Hamiltonian with the parameters provided and the
            % values stored in this instance of the class
            % parameters must be in the form of a (1,4) double vector, with
            % real numbers. It contain epsilon, omegaX,, omegaY and the
            % interaction u.
            %


            % Input validation
            arguments
                this Hamiltonians.TwoParticleSwapHamiltonian
            end
            
            % Interaction
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];

            u = this.Parameters(1,1);

            
            H = @(t) u.*kron(PauliX, PauliX) + u.*kron(PauliY, PauliY) ...
                + u.*kron(PauliZ, PauliZ);

        end
    end

    methods(Access = protected)

        
        function valid = parameterValidate(this, para)
            
            arguments
                this Hamiltonians.TwoParticleSwapHamiltonian
                para(1,1) double {mustBeReal}
            end
            
            valid = para;
        end
    end
end