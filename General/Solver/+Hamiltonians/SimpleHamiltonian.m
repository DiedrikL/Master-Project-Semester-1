classdef SimpleHamiltonian < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Gamma double
        Parameters
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = SimpleHamiltonian(options)
            % A simple hamiltonian, of the form:
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
            %
            % parameters must be in the form of a (1,3) double vector, with
            % real numbers. It contain epsilon, omegaX and omegaY.
            %


            % Input validation
            arguments
                this Hamiltonians.SimpleHamiltonian
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            gamma = this.Gamma;

            % Setup parameters
            B1 = @(t) 2*omegaX*sin(gamma*t);
            B2 = @(t) 2*omegaY*sin(gamma*t);
            B3 = @(t) -epsilon;

            % Creating the hamiltonian
            H = Hamiltonians.HamiltonianInterface.pauliRotations(B1,B2,B3); 

        end
         

        % Get function for dependent variable
        function Period = get.Period(this)
            arguments
                this Hamiltonians.SimpleHamiltonian
            end
            
            Period = this.Time.Tpulse;
        end
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.SimpleHamiltonian
                Time TimeOptions
            end
            
            this.Time = Time;
        end
        
        function this = set.Gamma(this, Gamma)
            % Set the gamma used by this hamiltonian
            arguments
                this Hamiltonians.SimpleHamiltonian
                Gamma(1,1) double {mustBeReal}
            end 
            
            this.Gamma = Gamma;
        end
        
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.SimpleHamiltonian
                para(1,3) double {mustBeReal}
            end
            
            this.Parameters = para;
        end
    end
end