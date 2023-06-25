classdef ConstantHamiltonian < Hamiltonians.Interfaces.HamiltonianInterface
    properties
        Phase double {mustBeReal}
    end

    properties(Constant)
        matrixSize = 2;
    end
    
    
    methods
        function this = ConstantHamiltonian(options)
            % A simple constant hamiltonian, of the form:
            % H =   [-epsilon/2    omega
            %        conj(omega)   epsilon/2]
            %
            % Takes the optional name value parameters Time and Phase
            % 
            % Time is the TimeOptions used by this hamiltonian
            %
            
            % Input validation and default values
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Parameters(1,3) double {mustBeReal} = zeros(1,3);
            end
            
            this.Time = options.Time;
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
                this Hamiltonians.ConstantHamiltonian
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            omega = omegaX + 1i*omegaY;

%             % Setup parameters
%             B1 = @(t) 2*omegaX*sin(phase*t);
%             B2 = @(t) -2*omegaY*sin(phase*t);
%             B3 = @(t) -epsilon;
% 
%             % Creating the hamiltonian
%             H = this.pauliRotations(B1,B2,B3);
            H = @(t)  [-epsilon/2 omega;...
                   conj(omega) epsilon/2];

        end
         

        
        function this = set.Phase(this, Phase)
            % Set the Phase used by this hamiltonian
            arguments
                this Hamiltonians.ConstantHamiltonian
                Phase(1,1) double {mustBeReal}
            end 
            
            this.Phase = Phase;
        end
        
    end
end