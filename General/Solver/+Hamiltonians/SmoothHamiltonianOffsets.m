classdef SmoothHamiltonianOffsets < Hamiltonians.Interfaces.HamiltonianInterface
    properties
       Scale(1,1) double {mustBeReal}
    end
    
    properties(Constant)
       matrixSize = 2;
    end
    
    
    
    methods
        function this = SmoothHamiltonianOffsets(options)
            % A Hamiltonian that simulates the smoothness of real magnetic
            % waves from a device. The field is constant with a ramp on and
            % ramp off value.
            %            
            % parameters must be of the form of a (1,6) double vector, with
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
                options.Parameters(1,6) double {mustBeReal} = zeros(1,6);
            end
            
            this.Time = options.Time;
            this.Scale = options.Scale;
            this.Parameters = options.Parameters;
        end
        
        
        function H = createHamiltonian(this)
            % A Hamiltonian that simulates the smoothness of real magnetic
            % waves from a device. The field is constant with a ramp on and
            % ramp off value. The function uses properites of it's
            % superclass SmoothHamiltonian
            %            
            % parameters must be of the form of a (1,6) double vector, with
            % real numbers. They contain the tree parameters epsilon,
            % omegaX and omegaY. With the last three being offsets.
            % 
            % xOffset, yOffset and zOffset makes it possible to move the
            % effect of the different fields in time



            % Input validation and default values
            arguments
                this Hamiltonians.SmoothHamiltonianOffsets
            end
            
            epsilon = this.Parameters(1,1);
            omegaX = this.Parameters(1,2);
            omegaY = this.Parameters(1,3);
            x = this.Parameters(1,4);
            y = this.Parameters(1,5);
            z = this.Parameters(1,6);
            
            s = this.Scale;
            T = (this.Time.Tpulse)/2;
            

            midpoint = this.Time.Tstart + ((this.Period + this.minOffset - this.maxOffset)/2);
           
            % Setup the parameters for the Hamiltonian
            B1 = @(t) 2*omegaX/(exp(s*(abs(t-midpoint-x)-abs(T)))+1);
            B2 = @(t) 2*omegaY/(exp(s*(abs(t-midpoint-y)-abs(T)))+1);
            B3 = @(t) 2*epsilon/(exp(s*(abs(t-midpoint-z)-abs(T)))+1);
                        
            
            % Creating the Hamiltonian
            H = this.pauliRotations(B1,B2,B3);
        
        end
        


        
        function offset = minOffset(this)
            arguments
                this Hamiltonians.SmoothHamiltonianOffsets
            end     
            
            offset = min(this.Parameters(4:6));

            if(offset < 0)
               offset = abs(offset); 
            else
                offset = 0;
            end
        end
        
        function offset = maxOffset(this)
            arguments
                this Hamiltonians.SmoothHamiltonianOffsets
            end     
            
            offset = max(this.Parameters(4:6));

            if(offset > 0)
               offset = abs(offset);
            else
                offset = 0;
            end        
        end
        

        
        function this = set.Scale(this, Scale)
            % Set the Scale used by this hamiltonian
            arguments
                this Hamiltonians.SmoothHamiltonianOffsets
                Scale(1,1) double {mustBeReal}
            end 
            
            this.Scale = Scale;
        end
    end

    methods(Access=protected)
        % Custom function to get the period
        function Period = periodGet(this)
            arguments
                this Hamiltonians.SmoothHamiltonianOffsets
            end
            
            offset = this.minOffset + this.maxOffset;
                        
            Period =  3*this.Time.Tpulse + offset;
        end


        % Custom validation for parameters
        function valid = parameterValidate(this, para)
            
            arguments
                this Hamiltonians.SmoothHamiltonianOffsets
                para(1,6) double {mustBeReal}
            end
            valid = para;
        end    
    end
end