classdef SmoothHamiltonian < Hamiltonians.HamiltonianInterface
    
    methods(Static)
        function H = createHamiltonian(parameters, options)
            % A Hamiltonian that simulates the smoothness of real magnetic
            % waves from a device. The field is constant with a ramp on and
            % ramp off value.
            %            
            % parameters must be of the form of a (1,3) double vector, with
            % real numbers. They contain epsilon, omegaX and omegaY.
            %
            % options are a name value argument it has several possible
            % optional parameters.
            %
            % xOffset, yOffset and zOffset makes it possible to move the
            % effect of the different fields in time
            % 
            % scale is how sharp the drop off is, must be a real double
            % default value is 5.
            %
            % Time is the time period, default is 2*pi


            % Input validation and default values
            arguments
                parameters(1,3) double {mustBeReal}
                options.scale(1,1) double {mustBeReal} = 5;
                options.Time(1,1) double {mustBeReal} = 2*pi;
                options.xOffset(1,1) double {mustBeReal} = 0;
                options.yOffset(1,1) double {mustBeReal} = 0;
                options.zOffset(1,1) double {mustBeReal} = 0;
            end
            
            epsilon = parameters(1,1);
            omegaX = parameters(1,2);
            omegaY = parameters(1,3);
            
            s = options.scale;
            T = options.Time;
            x = options.xOffset;
            y = options.yOffset;
            z = options.zOffset;
           
            % Setup the parameters for the Hamiltonian
            B1 = @(t) omegaX/(exp(s*(abs(t-x)-(abs(T)/2)))+1);
            B2 = @(t) omegaY/(exp(s*(abs(t-y)-(abs(T)/2)))+1);
            B3 = @(t) epsilon/(exp(s*(abs(t-z)-(abs(T)/2)))+1);
            
            % Creating the Hamiltonian
            H = Hamiltonians.HamiltonianInterface.pauliRotations(B1,B2,B3);
        
        end
    end
end