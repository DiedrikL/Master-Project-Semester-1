classdef LindbladRhoTwo < Hamiltonians.Interfaces.LindbladInterface
    properties(Constant)
        matrixSize = 4;
        rhoSize = 4;
    end

    properties(Access = protected)
        Noise LindbladNoise.LindbladNoise;
    end

    
    methods
        function this = LindbladRhoTwo(options)
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
                options.Parameters(1,4) double {mustBeReal} = ones(1,4);
                options.Measure = Measure.ChoiFidelity;
                options.Solver = HamiltSettings.Solvers.Runge_Kutta_Rho;
                options.Noise = HamiltSettings.TwoParticleNoises.Tomography;
            end
            this.Time = options.Time;
            this.Gamma = options.Gamma;
            this.Parameters = options.Parameters;
            this.Measure = options.Measure;
            this.Solver = options.Solver;
            noise = options.Noise;
            this.Noise = noise.NoiseClass;
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
                this Hamiltonians.LindbladRhoTwo
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            U = this.Parameters(1,4);
            gamma = this.Gamma;

            % Setup parameters
            B1 = @(t) omegaX*sin(t);
            B2 = @(t) 1i*omegaY*sin(t);
            Omega = @(t) B1(t)+B2(t);

            % Get interaction
            inter = Interaction(this);


            % Creating hamiltonian
            H = @(t) 1/2 * [2*epsilon conj(Omega(t)) conj(Omega(t)) 0; ...
                Omega(t) 0 0 conj(Omega(t));...
                Omega(t) 0 0 conj(Omega(t));...
                0 Omega(t) Omega(t) -2*epsilon] + inter;

                        

            % creatin components of the Lindbladian
            lindblad = @(t,rho) -1i*(H(t)*rho - rho*H(t)) ...
                - gamma*this.Noise.NoiseClass.getNoise(rho);
        end

        function Sigma = Interaction(this)
            % Creates the interactions between particles with kron function

            arguments
                this Hamiltonians.LindbladRhoTwo
            end
            
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];

            u = this.Parameters(1,4);

            
            Sigma = u.*kron(PauliX, PauliX) + u.*kron(PauliY, PauliY) ...
                + u.*kron(PauliZ, PauliZ);
        end 

        function this = setNoise(this, noise)
            arguments
                this Hamiltonians.LindbladRhoTwo
                noise HamiltSettings.TwoParticleNoises
            end
            this.Noise = noise.NoiseClass;
        end
    end

    methods(Access=protected)
        function valid = parameterValidate(this, para)
            
            arguments
                this Hamiltonians.LindbladRhoTwo
                para(1,4) double {mustBeReal}
            end
            
            valid = para;
        end
    end
end