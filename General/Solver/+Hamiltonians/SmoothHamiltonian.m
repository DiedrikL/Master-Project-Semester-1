classdef SmoothHamiltonian < Hamiltonians.HamiltonianInterface
    
    methods(Static)
        function H = createHamiltonian(parameters, Time, options)
            % A Hamiltonian that simulates the smoothness of real magnetic
            % waves from a device. The field is constant with a ramp on and
            % ramp off value.
            %            
            % parameters must be of the form of a (1,3) double vector, with
            % real numbers. They contain epsilon, omegaX and omegaY.
            %
            % Time is a parameter of class TimeOptions, and says how the
            % hamiltonian should 
            %
            % options are a name value argument it has several possible
            % optional parameters.
            %
            % scale is how sharp the drop off is, must be a real double
            % default value is 5.



            % Input validation and default values
            arguments
                parameters(1,3) double {mustBeReal}
                Time TimeOptions
                options.scale(1,1) double {mustBeReal} = 5;
            end
            
            epsilon = parameters(1,1);
            omegaX = parameters(1,2);
            omegaY = parameters(1,3);
            
            s = options.scale;
            T = (Time.Tend - Time.Tstart)/4;
            midpoint = (Time.Tstart + Time.Tend)/2;
           
            % Setup the parameters for the Hamiltonian
            B1 = @(t) omegaX/(exp(s*(abs(t-midpoint)-abs(T)))+1);
            B2 = @(t) omegaY/(exp(s*(abs(t-midpoint)-abs(T)))+1);
            B3 = @(t) epsilon/(exp(s*(abs(t-midpoint)-abs(T)))+1);
            
            % Creating the Hamiltonian
            H = Hamiltonians.HamiltonianInterface.pauliRotations(B1,B2,B3);
        
        end
    end
end