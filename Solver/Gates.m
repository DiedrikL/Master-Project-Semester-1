classdef  Gates
    methods(Static)
        % Possible one q-bit gates
        
        function [gate, rotated] = Hadamard(U)
            arguments
               U(2,2) double 
            end
            
            gate = 1/sqrt(2)*[1 1 ; 1 -1];
            phi = angle(U(1,1));
            rotated = exp(-1i*phi)*U;
        end

        function [gate, rotated] = Xgate(U)
            arguments
               U(2,2) double 
            end
            
            gate = [0 1;1 0];
            phi = angle(U(1,1));
            rotated= exp(-1i*phi)*U;
            
        end

        function [gate, rotated] = Ygate(U)
            arguments
               U(2,2) double 
            end
            
            gate = [0 -1i;1i 0];
            phi = angle(U(1,2));
            rotated = exp(-1i*phi-1i*pi/2)*U;
        end

        function [gate, rotated] = Zgate(U)
            arguments
               U(2,2) double 
            end
            
            gate = [1 0;0 -1];
            phi = angle(U(1,1));
            rotated = exp(-1i*phi)*U;

        end

        function [gate, rotated] = Identity(U)
            arguments
               U(2,2) double 
            end
            
            gate = eye(2);
            phi = angle(U(1,1));
            rotated = exp(-1i*phi)*U;
        end
        
    end
end