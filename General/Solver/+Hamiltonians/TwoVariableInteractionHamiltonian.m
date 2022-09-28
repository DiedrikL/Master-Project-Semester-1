classdef TwoVariableInteractionHamiltonian < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Parameters
        Epsilon
        OmegaX
        OmegaY
        U
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = TwoVariableInteractionHamiltonian(options)
            % A two particle hamiltonian with interaction.
            %
            % Takes the optional name value parameters Time and Gamma
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            % Gamma is the gamma used by this hamiltonian
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Parameters(1,2) double {mustBeReal} = zeros(1,2);
            end
            
            this.Time = options.Time;
            this.Parameters = options.Parameters;
            this.Epsilon = this.Parameters(1);
            this.OmegaX = 0;
            this.OmegaY = 0;
            this.U = this.Parameters(2);
%             this.U = 0.0625;
        end
        
        function H = createHamiltonian(this)
            % Creates a Hamiltonian with the parameters provided and the
            % values stored in this instance of the class
            % parameters must be in the form of a (1,2) double vector, with
            % real numbers. It the two parameters being changed
            % interaction u.
            %


            % Input validation
            arguments
                this Hamiltonians.TwoVariableInteractionHamiltonian
            end
            
            epsilon = this.Epsilon;
            omegaX = this.OmegaX;
            omegaY = 1i*this.OmegaY;

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
                this Hamiltonians.TwoVariableInteractionHamiltonian
            end
            
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];

            u = this.U;
            
            Sigma = u.*kron(PauliX, PauliX) + u.*kron(PauliY, PauliY) ...
                + u.*kron(PauliZ, PauliZ);
        end
         

        % Get function for dependent variable
        function Period = get.Period(this)
            arguments
                this Hamiltonians.TwoVariableInteractionHamiltonian
            end
            
            Period = this.Time.Tpulse;
        end
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.TwoVariableInteractionHamiltonian
                Time TimeOptions
            end
            
            this.Time = Time;
        end
        

        
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.TwoVariableInteractionHamiltonian
                para(1,2) double {mustBeReal}
            end
            
            this.Parameters = para;
            this.Epsilon = this.Parameters(1);
            this.U = this.Parameters(2);
        end
    end
end