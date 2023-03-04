classdef LindbladOneConstant < Hamiltonians.Interfaces.LindbladInterface
    properties(Constant)
        matrixSize = 4;
        rhoSize = 2;
    end

    
    methods
        function this = LindbladOneConstant(options)
            % A matrix derived from the lindblad equation
            % Takes the optional name value parameters Time and Lambda
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
                options.Gamma double {mustBeReal} = 0;
                options.Parameters(1,3) double {mustBeReal} = ones(1,3);
                options.Measure = Measure.ChoiFidelity;
                options.Solver = HamiltSettings.Solvers.Crank_Nicolson;
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
                this Hamiltonians.LindbladOneConstant
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            gamma = this.Gamma;

            % Setup parameters
            B1 = omegaX;
            B2 = 1i*omegaY;
            Omega = B1+B2;


            % Create the lindblad matrix
            lindblad = @(t) ...
                    [0      conj(-Omega)         Omega    2i*gamma;...
                    -Omega   -epsilon-1i*gamma   0       Omega;...
                    conj(Omega)   0     epsilon-1i*gamma  -conj(Omega);...
                    0       conj(Omega)          -Omega   -2i*gamma];


        end
         

    end
end