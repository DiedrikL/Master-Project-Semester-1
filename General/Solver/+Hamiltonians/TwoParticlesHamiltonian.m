classdef TwoParticlesHamiltonian < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Gamma double
        Parameters
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = TwoParticlesHamiltonian(options)
            % A two particle hamiltonian with a simplified model of
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
                options.Parameters(1,4) double {mustBeReal} = zeros(1,4);
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
                this Hamiltonians.TwoParticlesHamiltonian
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = 1i*this.Parameters(1,3);
            gamma = this.Gamma;
            u = this.Parameters(1,4);

            % Setup parameters
            H = @(t) 1/2 * [2*epsilon+2*u (omegaX-omegaY)*sin(t) (omegaX-omegaY)*sin(t) 0; ...
                (omegaX+omegaY)*sin(t) 0 0 (omegaX-omegaY)*sin(t); ...
                (omegaX+omegaY)*sin(t) 0 0 (omegaX-omegaY)*sin(t); ...
                0 (omegaX+omegaY)*sin(t) (omegaX+omegaY)*sin(t) -2*epsilon+2*u];

        end

        function H = twoParticlePauliRotations(B1, B2, B3)
            % Creates an hamiltonian from pauli rotations with the provided
            % parameters. B1, B2, B3 must be function handles taking one
            % parameter
            arguments
               B1(1,1) function_handle;
               B2(1,1) function_handle;
               B3(1,1) function_handle;
            end
            
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];
            
            Sigma = @(t) B1(t)*PauliX + B2(t)*PauliY + B3(t)*PauliZ;
            H = @(t) (1/2)*Sigma(t);
        end
         

        % Get function for dependent variable
        function Period = get.Period(this)
            arguments
                this Hamiltonians.TwoParticlesHamiltonian
            end
            
            Period = this.Time.Tpulse;
        end
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.TwoParticlesHamiltonian
                Time TimeOptions
            end
            
            this.Time = Time;
        end
        
        function this = set.Gamma(this, Gamma)
            % Set the gamma used by this hamiltonian
            arguments
                this Hamiltonians.TwoParticlesHamiltonian
                Gamma(1,1) double {mustBeReal}
            end 
            
            this.Gamma = Gamma;
        end
        
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.TwoParticlesHamiltonian
                para(1,4) double {mustBeReal}
            end
            
            this.Parameters = para;
        end
    end
end