classdef TwoParticleInteractionHamiltonian < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Parameters
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = TwoParticleInteractionHamiltonian(options)
            % A two particle hamiltonian wit hinteraction
            % Takes the optional name value parameters Time and Gamma
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Parameters(1,4) double {mustBeReal} = zeros(1,4);
            end
            
            this.Time = options.Time;
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
                this Hamiltonians.TwoParticleInteractionHamiltonian
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = 1i*this.Parameters(1,3);

            % Interaction
            inter = Interaction(this);

            % Setup parameters
            H = @(t) 1/2 * [2*epsilon (omegaX-omegaY)*sin(t) (omegaX-omegaY)*sin(t) 0; ...
                (omegaX+omegaY)*sin(t) 0 0 (omegaX-omegaY)*sin(t); ...
                (omegaX+omegaY)*sin(t) 0 0 (omegaX-omegaY)*sin(t); ...
                0 (omegaX+omegaY)*sin(t) (omegaX+omegaY)*sin(t) -2*epsilon] + inter;

        end

        function Sigma = Interaction(this)
            % Creates the interactions between particles with kron function

            arguments
                this Hamiltonians.TwoParticleInteractionHamiltonian
            end
            
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];

            u = this.Parameters(1,4);

            
            Sigma = u.*kron(PauliX, PauliX) + u.*kron(PauliY, PauliY) ...
                + u.*kron(PauliZ, PauliZ);
        end
         

        % Get function for dependent variable
        function Period = get.Period(this)
            arguments
                this Hamiltonians.TwoParticleInteractionHamiltonian
            end
            
            Period = this.Time.Tpulse;
        end
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.TwoParticleInteractionHamiltonian
                Time TimeOptions
            end
            
            this.Time = Time;
        end
        
        
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.TwoParticleInteractionHamiltonian
                para(1,4) double {mustBeReal}
            end
            
            this.Parameters = para;
        end
    end
end