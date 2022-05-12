classdef SmoothHamiltonian < Hamiltonians.HamiltonianInterface
    properties
       Time TimeOptions
       Scale(1,1) double {mustBeReal}
    end
    
    
    methods
        function this = SmoothHamiltonian(options)
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
            % Time is a parameter of class TimeOptions, and says what
            % period the hamiltonian shold be in
            %
            % scale is how sharp the drop off is, must be a real double
            % default value is 5.
            
            arguments
                options.Time TimeOptions = TimeOptions;
                options.Scale(1,1) double {mustBeReal} = 5;
            end
            
            this.Time = options.Time;
            this.Scale = options.Scale;
            
        end
        
        
        function H = createHamiltonian(this, Parameters)
            % creates the Hamiltonian with the parameters provided and
            % values in the properties in this instance of the class.
            
            
            % Input validation and default values
            arguments
                this 
                Parameters(1,3) double {mustBeReal}
            end
            
            epsilon = Parameters(1,1);
            omegaX = Parameters(1,2);
            omegaY = Parameters(1,3);
            
            s = this.Scale;
            T = (this.Time.Tend - this.Time.Tstart)/4;
            midpoint = (this.Time.Tstart + this.Time.Tend)/2;
           
            % Setup the parameters for the Hamiltonian
            B1 = @(t) omegaX/(exp(s*(abs(t-midpoint)-abs(T)))+1);
            B2 = @(t) omegaY/(exp(s*(abs(t-midpoint)-abs(T)))+1);
            B3 = @(t) epsilon/(exp(s*(abs(t-midpoint)-abs(T)))+1);
            
            % Creating the Hamiltonian
            H = this.pauliRotations(B1,B2,B3);
        
        end
        
        
        % Custom set functions with validation
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.SmoothHamiltonian
                Time TimeOptions
            end
            
            this.Time = Time;
            
        end
        
        function this = set.Scale(this, Scale)
            % Set the Scale used by this hamiltonian
            arguments
                this Hamiltonians.SmoothHamiltonian
                Scale(1,1) double {mustBeReal}
            end 
            
            this.Scale = Scale;
        end
    end
end