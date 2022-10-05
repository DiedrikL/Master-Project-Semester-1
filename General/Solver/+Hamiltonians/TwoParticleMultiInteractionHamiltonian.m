classdef TwoParticleMultiInteractionHamiltonian < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Parameters
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = TwoParticleMultiInteractionHamiltonian(options)
            % A two particle hamiltonian with multiple interaction
            % Takes the optional name value parameters Time
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Parameters(1,6) double {mustBeReal} = zeros(1,6);
            end
            
            this.Time = options.Time;
            this.Parameters = options.Parameters;
        end
        
        function H = createHamiltonian(this)
            % Creates a Hamiltonian with the parameters provided and the
            % values stored in this instance of the class
            % parameters must be in the form of a (16) double vector, with
            % real numbers. It contain epsilon, omegaX, omegaY and the
            % interaction u for each direction.
            %


            % Input validation
            arguments
                this Hamiltonians.TwoParticleMultiInteractionHamiltonian
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
                this Hamiltonians.TwoParticleMultiInteractionHamiltonian
            end
            
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];

            uz = this.Parameters(1,4);
            ux = this.Parameters(1,5);
            uy = this.Parameters(1,6);

            
            Sigma = ux.*kron(PauliX, PauliX) + uy.*kron(PauliY, PauliY) ...
                + uz.*kron(PauliZ, PauliZ);
        end
         

        % Get function for dependent variable
        function Period = get.Period(this)
            arguments
                this Hamiltonians.TwoParticleMultiInteractionHamiltonian
            end
            
            Period = this.Time.Tpulse;
        end
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.TwoParticleMultiInteractionHamiltonian
                Time TimeOptions
            end
            
            this.Time = Time;
        end
        
        
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.TwoParticleMultiInteractionHamiltonian
                para(1,6) double {mustBeReal}
            end
            
            this.Parameters = para;
        end
    end
end