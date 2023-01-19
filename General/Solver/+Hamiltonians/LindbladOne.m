classdef LindbladOne < Hamiltonians.HamiltonianInterface
    properties
        Time TimeOptions
        Lambda double {mustBeNonnegative}
        Parameters
%         Rho (1,1) {mustBeInteger, mustBeInRange(Rho, 1,4)} = 1;
    end
    
    properties(Dependent)
        Period
    end

    
    methods
        function this = LindbladOne(options)
            % A matrix derived from the lindblad equation
            % Takes the optional name value parameters Rho, Time and Lambda
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            % Lambda is an optional parameter with default value of 0. It
            % scales how large the effect reducing the state of the system
            % towards basis state [1;0], it is the interference experienced
            % by the system.
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Lambda double {mustBeReal} = 0;
                options.Parameters(1,3) double {mustBeReal} = ones(1,3);
                options.Measure = Measure.ChoiFidelity;
            end
            this.Time = options.Time;
            this.Lambda = options.Lambda;
            this.Parameters = options.Parameters;
            this.Measure = options.Measure;
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
            lambda = this.Lambda;
%             rho = sparse(2,2);
%             rho(this.Rho) = 1;

            % Setup parameters
            B1 = @(t) omegaX*sin(t);
            B2 = @(t) 1i*omegaY*sin(t);
            Omega = @(t) B1(t)+B2(t);


            % Create the lindblad matrix
            lindblad = @(t) ...
                    [0      conj(-Omega(t))         Omega(t)    2i*lambda;...
                    -Omega(t)   -epsilon-1i*lambda   0       Omega(t);...
                    conj(Omega(t))   0     epsilon-1i*lambda  -conj(Omega(t));...
                    0       conj(Omega(t))          -Omega(t)   -2i*lambda];


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
        
        function this = set.Lambda(this, Lambda)
            % Set the lambda used by this hamiltonian
            arguments
                this Hamiltonians.LindbladOne
                Lambda(1,1) double {mustBeReal}
            end 
            
            this.Lambda = Lambda;
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