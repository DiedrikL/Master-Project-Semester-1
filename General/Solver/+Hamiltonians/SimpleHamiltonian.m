classdef SimpleHamiltonian < Hamiltonians.HamiltonianInterface
    methods(Static)
        function H = createHamiltonian(parameters, options)
            % A simple hamiltonian, of the form:
            % H =   [-epsilon/2                 omega*sin(t*gamma)
            %        conj(omega)*sin(t*gamma)   epsilon/2]
            %
            % parameters must be of the form of a (1,3) double vector, with
            % real numbers. They contain epsilon, omegaX and omegaY.
            %
            % options are a name value argument, it only takes values for
            % gamma.
            %


            % Input validation and default values
            arguments
                parameters(1,3) double {mustBeReal}
                options.gamma double {mustBeNonzero} = 1;
            end
            
            epsilon = parameters(1,1);
            omegaX = parameters(1,2);
            omegaY = parameters(1,3);
            gamma = options.gamma;

            % Setup parameters
            B1 = @(t) 2*omegaX*sin(gamma*t);
            B2 = @(t) 2*omegaY*sin(gamma*t);
            B3 = @(t) -epsilon;

            % Creating the hamiltonian
            H = Hamiltonians.HamiltonianInterface.pauliRotations(B1,B2,B3); 

        end
    end
end