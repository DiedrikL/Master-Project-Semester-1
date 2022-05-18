classdef OneVariableXgate < Hamiltonians.HamiltonianInterface
    properties
       Time TimeOptions
       Parameters
       Scale(1,1) double {mustBeReal}
    end
    
    properties(Dependent)
       Period
    end
    
    
    
    methods
        function this = OneVariableXgate(options)
            % A Hamiltonian that simulates the smoothness of real magnetic
            % waves from a device. The field is constant with a ramp on and
            % ramp off value. This only 
            %            
            % parameters must be of the form of a (1,1) double vector, with
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
                options.Parameters(1,1) double {mustBeReal} = 2*pi;
            end
            
            this.Time = options.Time;
            this.Scale = options.Scale;
            this.Parameters = options.Parameters;
            this.Time.Tpulse = this.Parameters;
        end
        
        
        function H = createHamiltonian(this)
            % creates the Hamiltonian with the parameters provided and
            % values in the properties in this instance of the class.
            
            
            % Input validation and default values
            arguments
                this Hamiltonians.OneVariableXgate
            end
            
            %this.Time.Tpulse = this.Parameters;
            
            s = this.Scale;
            T = this.Time.Tpulse/2;
            midpoint = this.Time.Tstart + (this.Period/2);
           
            % Setup the parameters for the Hamiltonian
            B1 = @(t) 2/(exp(s*(abs(t-midpoint)-abs(T)))+1);
            B2 = @(t) 0;
            B3 = @(t) 0;
            
            % Creating the Hamiltonian
            H = this.pauliRotations(B1,B2,B3);
        
        end
        
        
        
        function Period = get.Period(this)
            arguments
                this Hamiltonians.OneVariableXgate
            end
            
            Period =  2*this.Time.Tpulse;
        end
        
        
        % Custom set functions with validation
        function this = set.Parameters(this, para)
            
            arguments
                this Hamiltonians.OneVariableXgate
                para(1,1) double {mustBeReal}
            end
            
            this.Parameters = para;
            this.Time.Tpulse = para;
        end
        
        
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.OneVariableXgate
                Time TimeOptions
            end
            
            this.Time = Time;
            
        end
        
        function this = set.Scale(this, Scale)
            % Set the Scale used by this hamiltonian
            arguments
                this Hamiltonians.OneVariableXgate
                Scale(1,1) double {mustBeReal}
            end 
            
            this.Scale = Scale;
        end
    end
end