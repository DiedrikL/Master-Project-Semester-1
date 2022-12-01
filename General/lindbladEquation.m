            syms rho_00 rho_01 rho_10 rho_11;
            syms epsilon omegaX omegaY gamma V Vd
            rho = [rho_00 rho_01; rho_10 rho_11];

            % Setup parameters
            B1 = @(t) omegaX*sin(gamma*t);
            B2 = @(t) 1i*omegaY*sin(gamma*t);
%             V = @(t) B1(t)+B2(t);

            % Creating hamiltonian
            H = @(t) [-epsilon/2 omegaX+1i*omegaY; omegaX-1i*omegaY epsilon/2]
            a = [1; 0]*[0 1]
            A = a'*a;

            % creatin components of the Lindbladian
            lindblad = @(t) H(t)*rho - rho*H(t) - 1i*gamma*(A*rho + rho*A -2.*a*rho*a')

            lindblad(0)
%             lindblad(pi/2)
