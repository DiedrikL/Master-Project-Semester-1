% Static class that return a created Hamiltonian with the provided
% parameters. There are multiple Hamiltonians avaible.

classdef Hamiltonians
    methods(Static)
       
        
        function H = pauliRotations(B1,B2,B3)
            % Creates an hamiltonian from pauli rotations with the provided
            % parameters. B1, B2, B3 must be function handles taking one
            % parameter
            arguments
               B1(1,1) function_handle;
               B2(1,1) function_handle;
               B3(1,1) function_handle;
            end
            
            PauliX = [0 1; 1 0];
            PauliY = [0 -1i; 1i 0];
            PauliZ = [1 0; 0 -1];
            
            Sigma = @(t) B1(t)*PauliX + B2(t)*PauliY + B3(t)*PauliZ;
            H = @(t) (1/2)*Sigma(t);
        end
        
        function H = pauliRotationsVector(B)
            % Creates an hamiltonian from pauli rotations with the provided
            % parameters. B must be a (1,3) cell array of function handles
            % taking one parameter
            
            arguments
               B(1,3) cell 
            end

            H = pauliRotations(B{1},B{2},B{3});
        end
        
        
        
        function H = simpleHamiltonian(epsilon, omegaX, omegaY, gamma)
            % A simple hamiltonian, of the form:
            % H =   [-epsilon/2                 omega*sin(t*gamma)
            %        conj(omega)*sin(t*gamma)   epsilon/2]
            
            
            % Input validation and default values
            arguments
               epsilon(1,1) double
               omegaX(1,1) double
               omegaY(1,1) double
               gamma double {mustBeNonzero} = 1;
            end

            % Setup parameters
            %B = cell(1,3);
            B1 = @(t) 2*omegaX*sin(gamma*t);
            B2 = @(t) 2*omegaY*sin(gamma*t);
            B3 = @(t) -epsilon;

            % Creating the hamiltonian
            H = Hamiltonians.pauliRotations(B1,B2,B3);
            
        end
        

        
        
        function H = smoothedHamiltonian(epsilon, omegaX, omegaY, options)
            % A Hamiltonian that simulates the smoothness of real magnetic
            % waves from a device.
            % 
            % scale is how sharp the drop off is, must be a real double
            % default value is 5.
            %
            % Time is the time period, default is 2*pi
            
            
            % Input validation and default values
            arguments
               epsilon(1,1) double
               omegaX(1,1) double
               omegaY(1,1) double
               options.scale(1,1) double {mustBeReal} = 5;
               options.Time(1,1) double {mustBeReal} = 2*pi;
            end
            s = options.scale;
            T = options.Time;
           
            % Setup the parameters for the Hamiltonian
            B1 = @(t) 2*omegaX/(exp(s*(abs(t)-(T/2)))+1);
            B2 = @(t) 2*omegaY/(exp(s*(abs(t)-(T/2)))+1);
            B3 = @(t) -epsilon/(exp(s*(abs(t)-(T/2)))+1);
            
            % Creating the Hamiltonian
            H = Hamiltonians.pauliRotations(B1,B2,B3);
        end
    end 
end
