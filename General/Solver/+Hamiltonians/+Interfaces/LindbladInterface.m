classdef (Abstract) LindbladInterface < Hamiltonians.Interfaces.HamiltonianInterface
    
    properties(Abstract, Constant, GetAccess=public)
       rhoSize int8 {mustBePositive}
    end

    properties(Access=public)
        Gamma double {mustBeReal} = 0;
    end

    methods
        function this = LindbladInterface(options)
            arguments
                options.Measure Measure = Measure.ChoiFidelity;
                options.Gamma double = 0;

            end

            this.Measure = options.Measure;
            this.Gamma = options.Gamma;
        end


        function this = set.Gamma(this, Gamma)
            % Set the lambda used by this hamiltonian
            arguments
                this Hamiltonians.Interfaces.LindbladInterface
                Gamma(1,1) double {mustBeReal}
            end 
            
            this.Gamma = Gamma;
        end
    end
end