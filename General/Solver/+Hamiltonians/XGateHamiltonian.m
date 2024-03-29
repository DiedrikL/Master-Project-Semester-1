classdef XGateHamiltonian < Hamiltonians.Interfaces.HamiltonianInterface
    properties
        Gamma double
    end
    
    properties(Constant)
        matrixSize = 2;
    end

    
    methods
        function this = XGateHamiltonian(options)
            % A simple hamiltonian, of the form:
            % H =   [0 1
            %        1 0]
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
                this Hamiltonians.XGateHamiltonian
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            gamma = this.Gamma;
            omega = omegaX + 1i*omegaY;

%             % Setup parameters
%             B1 = @(t) 2*omegaX*sin(gamma*t);
%             B2 = @(t) -2*omegaY*sin(gamma*t);
%             B3 = @(t) -epsilon;
% 
%             % Creating the hamiltonian
%             H = Hamiltonians.HamiltonianInterface.pauliRotations(B1,B2,B3); 
            H = @(t)  [0 1; 1 0];

        end
         

        
        function this = set.Gamma(this, Gamma)
            % Set the gamma used by this hamiltonian
            arguments
                this Hamiltonians.XGateHamiltonian
                Gamma(1,1) double {mustBeReal}
            end 
            
            this.Gamma = Gamma;
        end
        
    end
end