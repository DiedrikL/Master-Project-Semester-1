classdef RandomGate < Gates.GateInterface
    % The gate and rotation for the Hadamard gate
    
    methods(Access = public, Static)
        function rotate = rotation(U)
            arguments
                U(4,4) double
            end

            phi = angle(U(1,1));
            theta = angle(Gates.RandomGate.gate(1,1));
            rotate = exp(-1i*phi+1i*theta)*U;
        end
    end

    properties(Constant)
        Psi0 = eye(4);
        gate = Gates.RandomGate.getRandom();
    end


    methods(Access = public, Static)
        function Unitary = getRandom()
            % Mean
            mu = 0;
    
            % Standard deviation
            sigma = 1;
    
            mSize = [4,4];   
    
            %A = normrnd(mu, sigma, mSize);
            A = rand(4,4)*10;
            %B = normrnd(mu, sigma, mSize);
            B = rand(4,4)*10;
            G = A + 1i*B;
            H = G'+G;
            H_exchanged = ... 
                [H(1,1) H(1,3) H(1,2) H(1,4);...
                H(3,1) H(3,3) H(3,2) H(3,4);...
                H(2,1) H(2,3) H(2,2) H(2,4);...
                H(4,1) H(4,3) H(4,2) H(4,4)];
            H_sym = H + H_exchanged;
            H_sym
            Unitary = expm(-1i*H_sym);

        end

        function Reset()
            clear this
        end
    end
end
