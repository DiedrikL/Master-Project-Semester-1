classdef SmoothHamiltonianOffsets < Hamiltonians.SmoothHamiltonian

    methods
        function H = createHamiltonian(this, parameters)
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
                parameters(1,6) double {mustBeReal}
            end
            
            epsilon = parameters(1,1);
            omegaX = parameters(1,2);
            omegaY = parameters(1,3);
            x = parameters(1,4);
            y = parameters(1,5);
            z = parameters(1,6);
            
            s = this.Scale;
            T = (this.Time.Tend - this.Time.Tstart)/4;
            

           
            % Setup the parameters for the Hamiltonian
            B1 = @(t) omegaX/(exp(s*(abs(t-x)-abs(T)))+1);
            B2 = @(t) omegaY/(exp(s*(abs(t-y)-abs(T)))+1);
            B3 = @(t) epsilon/(exp(s*(abs(t-z)-abs(T)))+1);
            
            % Creating the Hamiltonian
            H = this.pauliRotations(B1,B2,B3);
        
        end
    end
end