classdef (Abstract) HamiltonianInterface
    properties(Abstract)
       Time TimeOptions
       Parameters double {mustBeReal}
    end

    properties(Access=public)
        Measure {mustBeMember(Measure,[0, 1])} = 0;
    end
    
    properties(Dependent)
       TimeStep double 
       TimeVector(1,:) double
    end
    
    properties(Abstract, Dependent)
        Period double
    end
    
    methods(Abstract)
        createHamiltonian(this)
    end
    
    methods
        
        % Get functions for dependent variabels
        function TimeStep = get.TimeStep(this)
            arguments
                this Hamiltonians.HamiltonianInterface
            end
            
            TimeStep = this.Period/this.Time.Tsize;
        end
        
        function TimeVector = get.TimeVector(this)
            arguments
                this Hamiltonians.HamiltonianInterface
            end
            
            TimeStart = this.Time.Tstart;
            TimeEnd = this.Period + this.Time.Tstart;
            
            
            TimeVector = (TimeStart):this.TimeStep:(TimeEnd);
            TimeVector(end) = [];
        end

        function measure = get.Measure(this)
            arguments
                this Hamiltonians.HamiltonianInterface
            end

            measure = this.Measure;
        end        
        
        function this = set.Measure(this, value)
            arguments
                this Hamiltonians.HamiltonianInterface
                value {mustBeInteger}
            end

            this.Measure = value;
        end
        
        
    end
    

    
    methods(Static, Sealed)
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
    end
end