% Static class that return a created Hamiltonian with the provided
% parameters. There are multiple Hamiltonians avaible.

classdef Hamiltonians
    methods(Static)
        
        function H = simpleHamiltonian(epsilon, omegaX, omegaY, gamma)
            % A simple hamiltonian.
            
            
            % Input validation and default values
            arguments
               epsilon(1,1) double
               omegaX(1,1) double
               omegaY(1,1) double
               gamma double {mustBeNonzero} = 1;
            end

            % Setup parameters
            omega = omegaX - 1i*omegaY;

            % Formula for hamilton operator
            H = @(t)[-epsilon/2                omega*sin(gamma*t);...
                     conj(omega)*sin(gamma*t)  epsilon/2];
            
        end
        
        
        function H = createOneHamiltonian(B1,B2,B3)
            % Creates an hamiltonian from pauli rotations with the provided
            % parameters.
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
        
        
        
        
        function H = simpleHamiltonianRotation(epsilon, omegaX, omegaY, gamma)
            % A simple hamiltonian.
            
            
            % Input validation and default values
            arguments
               epsilon(1,1) double = 1;
               omegaX(1,1) double = 0;
               omegaY(1,1) double = 1;
               gamma double {mustBeNonzero} = 1;
            end

            % Setup parameters
            %B = cell(1,3);
            B1 = @(t) 2*omegaX*sin(gamma*t);
            B2 = @(t) 2*omegaY*sin(gamma*t);
            B3 = @(t) -epsilon;

            % Creating the hamiltonian
            H = Hamiltonians.createOneHamiltonian(B1,B2,B3);
            
        end
        

        
        
        function H = smoothedHamiltonian(epsilon, omegaX, omegaY, scale, Time, gamma)
            % A Hamiltonian that simulates the smoothness of .
            
            
            % Input validation and default values
            arguments
               epsilon(1,1) double
               omegaX(1,1) double
               omegaY(1,1) double
               scale(1,1) double {mustBeReal}
               Time(1,1) double {mustBeReal}
               gamma double {mustBeNonzero} = 1;
            end
            
            B1 = @(t) t;
            B2 = @(t) t;
            B3 = @(t) t;
            
            H = @(t) createOneHamiltonian(B1,B2,B3);
        end
    end 
end
