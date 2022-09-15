classdef TwoParticleSwapHamiltonian < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Gamma double
        Parameters
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = TwoParticleSwapHamiltonian(options)
            % A simple two particle hamiltonian, of the form:
            % H =   [-epsilon/2                 omega*sin(t*gamma)
            %        conj(omega)*sin(t*gamma)   epsilon/2]
            %
            % Takes the optional name value parameters Time and Gamma
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            % Gamma is the gamma used by this hamiltonian
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Gamma double {mustBeNonzero} = 1;
                options.Parameters(1,3) double {mustBeReal} = zeros(1,3);
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
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = 1i*this.Parameters(1,3);
            %gamma = this.Gamma;

            % Interaction
            inter = Interaction(this);

            % Setup parameters
            H = @(t) inter;

        end

        function Sigma = Interaction(this)
            % Creates the interactions between particles with kron function

            arguments
                this Hamiltonians.TwoParticleSwapHamiltonian
            end
            
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];

            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = 1i*this.Parameters(1,3);

            
            Sigma = omegaX.*kron(PauliX, PauliX) + omegaY.*kron(PauliY, PauliY) ...
                + epsilon.*kron(PauliZ, PauliZ);
        end
         

        % Get function for dependent variable
        function Period = get.Period(this)
            arguments
                this Hamiltonians.TwoParticleSwapHamiltonian
            end
            
            Period = this.Time.Tpulse;
        end
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.TwoParticleSwapHamiltonian
                Time TimeOptions
            end
            
            this.Time = Time;
        end
        
        function this = set.Gamma(this, Gamma)
            % Set the gamma used by this hamiltonian
            arguments
                this Hamiltonians.TwoParticleSwapHamiltonian
                Gamma(1,1) double {mustBeReal}
            end 
            
            this.Gamma = Gamma;
        end
        
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.TwoParticleSwapHamiltonian
                para(1,3) double {mustBeReal}
            end
            
            this.Parameters = para;
        end
    end
end