classdef LindbladOne < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Gamma double
        Parameters
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = LindbladOne(options)
            % The lindblad equation
            % Takes the optional name value parameters Time and Gamma
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            % Gamma is the gamma used by this hamiltonian
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Gamma double {mustBeNonzero} = 1;
                options.Parameters(1,3) double {mustBeReal} = ones(1,3);
            end
            
            this.Time = options.Time;
            this.Gamma = options.Gamma;
            this.Parameters = options.Parameters;
        end
        
        function lindblad = createHamiltonian(this)
            % Creates a Hamiltonian with the parameters provided and the
            % values stored in this instance of the class
            %
            % parameters must be in the form of a (1,3) double vector, with
            % real numbers. It contain epsilon, omegaX and omegaY.
            %


            % Input validation
            arguments
                this Hamiltonians.LindbladOne
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            gamma = this.Gamma;
            syms rho_00 rho_01 rho_10 rho_11;
            rho = [rho_00 rho_01; rho_10 rho_11];

            % Setup parameters
            B1 = @(t) omegaX*sin(gamma*t);
            B2 = @(t) 1i*omegaY*sin(gamma*t);
            V = @(t) B1(t)+B2(t);

            % Creating hamiltonian
            H = @(t) [-epsilon/2 V; V epsilon/2];
            a = [1; 0]*[0 1];
            A = a'*a;

            % creatin components of the Lindbladian
            lindblad = @(t) H(t)*rho - rho*H(t) - ...
                1i*gamma*(A*rho + rho*A - 2*a*rho*a')

            % creatin components of the Lindbladian


        end
         

        % Get function for dependent variable
        function Period = get.Period(this)
            arguments
                this Hamiltonians.LindbladOne
            end
            
            Period = this.Time.Tpulse;
        end
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.LindbladOne
                Time TimeOptions
            end
            
            this.Time = Time;
        end
        
        function this = set.Gamma(this, Gamma)
            % Set the gamma used by this hamiltonian
            arguments
                this Hamiltonians.LindbladOne
                Gamma(1,1) double {mustBeReal}
            end 
            
            this.Gamma = Gamma;
        end
        
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.LindbladOne
                para(1,3) double {mustBeReal}
            end
            
            this.Parameters = para;
        end
    end
end