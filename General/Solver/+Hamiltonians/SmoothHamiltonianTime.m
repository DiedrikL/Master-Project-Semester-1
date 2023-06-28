classdef SmoothHamiltonianTime < Hamiltonians.Interfaces.HamiltonianInterface
    properties
       Scale(1,1) double {mustBeReal}
       Epsilon(1,1) double {mustBeReal}
       OmegaX(1,1) double {mustBeReal}
       OmegaY(1,1) double {mustBeReal}
    end
    
    properties(Constant)
       matrixSize = 2;
    end
    
    
    
    methods
        function this = SmoothHamiltonianTime(options)
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
                options.Epsion(1,1) double {mustBeReal} = 1;
                options.OmegaX(1,1) double {mustBeReal} = 1;
                options.OmegaY(1,1) double {mustBeReal} = 1;
                options.Parameters(1,3) double {mustBeReal} = zeros(1,1);
            end
            
            this.Time = options.Time;
            this.Scale = options.Scale;
            this.Epsilon = options.Epsion;
            this.OmegaX = options.OmegaX;
            this.OmegaY = options.OmegaY;
            this.Parameters = 0;
        end
        
        
        function H = createHamiltonian(this)
            % creates the Hamiltonian with the parameters provided and
            % values in the properties in this instance of the class.
            
            
            % Input validation and default values
            arguments
                this Hamiltonians.SmoothHamiltonianTime
            end
            
            epsilon = this.Epsilon;
            omegaX = this.OmegaX;
            omegaY = this.OmegaY;
            
            s = this.Scale;
            T = this.Time.Tpulse/2;
            midpoint = this.Time.Tstart + (this.Period/2);
           
            % Setup the parameters for the Hamiltonian
%             B1 = @(t) 1*omegaX/(exp(s*(abs(t-midpoint)-abs(T)))+1);
%             B2 = @(t) -1*omegaY/(exp(s*(abs(t-midpoint)-abs(T)))+1);
%             B3 = @(t) -1/2*epsilon/(exp(s*(abs(t-midpoint)-abs(T)))+1);
%             
%             % Creating the Hamiltonian
%             H = this.pauliRotations(B1,B2,B3);
            H = @(t)1/(exp(s*(abs(t-midpoint)-abs(T)))+1)*...
                [-epsilon/2 omegaX+1i*omegaY;
                omegaX-1i*omegaY epsilon/2];
        
        end
        

        
        function this = set.Scale(this, scale)
            % Set the Scale used by this hamiltonian
            arguments
                this Hamiltonians.SmoothHamiltonianTime
                scale(1,1) double {mustBeReal}
            end 
            
            this.Scale = scale;
        end
        
    end

    methods(Access=protected)
        function Period = periodGet(this)
            arguments
                this Hamiltonians.SmoothHamiltonianTime
            end
            
            Period =  2*this.Time.Tpulse;
        end
        
        function valid = parameterValidate(this,para)
            arguments
                this
                para(1,1) double {mustBeReal}
            end
            this.setTime(para)
            valid = para;
        end

        function setTime(this, timeOff)
            this.Time.Tpulse = 2*pi + timeOff;
        end
    end
end