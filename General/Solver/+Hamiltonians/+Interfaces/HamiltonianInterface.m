classdef (Abstract) HamiltonianInterface

    properties(Abstract, Constant, GetAccess=public)
       matrixSize int8 {mustBePositive}
    end

    properties(Access=protected)
    end

    properties(Access=public)
        Parameters double {mustBeReal}
        Measure Measure = Measure.AvgFidelity;
        Solver HamiltSettings.Solvers = HamiltSettings.Solvers.Crank_Nicolson;
        Time TimeOptions
    end
    
    properties(Dependent)
        TimeStep double 
        TimeVector(1,:) double
        Period double
    end

    
    methods(Abstract)
        createHamiltonian(this)
    end
    
    methods
        
        % Get functions for dependent variabels
        function TimeStep = get.TimeStep(this)
            arguments
                this Hamiltonians.Interfaces.HamiltonianInterface
            end
            
            TimeStep = this.Period/this.Time.Tsize;
        end
        
        function TimeVector = get.TimeVector(this)
            arguments
                this Hamiltonians.Interfaces.HamiltonianInterface
            end
            
            TimeStart = this.Time.Tstart;
            TimeEnd = this.Period + this.Time.Tstart;
            
            
            TimeVector = (TimeStart):this.TimeStep:(TimeEnd);
            TimeVector(end) = [];
        end

        
        
        function this = set.Time(this, Time)
            % Set the TimeOptions used by this hamiltonian
            arguments
                this Hamiltonians.Interfaces.HamiltonianInterface
                Time TimeOptions
            end
            
            this.Time = Time;
            
        end

        % Get function for dependent variable linking to protected function
        function Period = get.Period(this)
            Period = this.periodGet;
        end

        % set function that links to custom validation that can be
        % overridden
        function this = set.Parameters(this, para)
            arguments
                this Hamiltonians.Interfaces.HamiltonianInterface
                para
            end
            test = this.parameterValidate(para);

            this.Parameters = test;            
        end
    end

    methods(Access=protected)
        % Default parameter validation for set function
        function valid = parameterValidate(this,para)
            arguments
                this
                para(1,3) double {mustBeReal}
            end
            valid = para;
        end


        % Default get function for period
        function Period = periodGet(this)
            arguments
                this Hamiltonians.Interfaces.HamiltonianInterface
            end
            
            Period = this.Time.Tpulse;
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