classdef LindbladRhoOne < Hamiltonians.Interfaces.LindbladInterface
    properties(Constant)
        matrixSize = 2;
        rhoSize = 2;
    end

    
    methods
        function this = LindbladRhoOne(options)
            % A matrix derived from the lindblad equation
            % Takes the optional name value parameters Rho, Time and Gamma
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            % Gamma is an optional parameter with default value of 0. It
            % scales how large the effect reducing the state of the system
            % towards basis state [1;0], it is the interference experienced
            % by the system.
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Gamma double {mustBeReal} = 0;
                options.Parameters(1,3) double {mustBeReal} = ones(1,3);
                options.Measure = Measure.ChoiFidelity;
                options.Solver = HamiltSettings.Solvers.Runge_Kutta_Rho;
            end
            this.Time = options.Time;
            this.Gamma = options.Gamma;
            this.Parameters = options.Parameters;
            this.Measure = options.Measure;
            this.Solver = options.Solver;
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
                this Hamiltonians.Interfaces.LindbladInterface
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            Gamma = this.Gamma;
%             rho = sparse(2,2);
%             rho(this.Rho) = 1;

            % Setup parameters
            B1 = @(t) omegaX*sin(t);
            B2 = @(t) 1i*omegaY*sin(t);
            Omega = @(t) B1(t)+B2(t);


            % Creating hamiltonian
            H = @(t) [-epsilon/2 Omega(t); conj(Omega(t)) epsilon/2];
            a = [1; 0]*[0 1];
            A = a'*a;

            % creatin components of the Lindbladian
            lindblad = @(t,rho) -1i*(H(t)*rho - rho*H(t))...
                -Gamma*(A*rho + rho*A -2.*a*rho*a');
        end


    end
end