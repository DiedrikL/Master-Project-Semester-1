function [tVector, Solution] = Runge_Kutta(Rho, Hamiltonian)
    
    % Solves the schrödinger equation with the Runge Kutta method for a
    % specified Hamiltonian and startvalues Rho.
    
    
    % Input validation
    arguments
        Rho (:,:) double
        Hamiltonian Hamiltonians.HamiltonianInterface;
    end
    
    % Get parameterized hamiltonian 
    H = Hamiltonian.createHamiltonian;
    
    
    % Set timelength
    dt = Hamiltonian.TimeStep;
    tVector = Hamiltonian.TimeVector;
    %tVector(end) = [];
    
    % Find sizes
    leng = length(tVector);
    psiHeight = Hamiltonian.matrixSize;
    
    function step = rk_algorithm(t, rho)
        k1 = expm(-1i*H(t)*dt)*rho; 
        k2 = expm(-1i*H(t+dt/2)*dt)*(rho+dt*k1/2);
        k3 = expm(-1i*H(t+dt/2)*dt)*(rho+dt*k2/2);
        k4 = expm(-1i*H(t+dt)*dt)*(rho+dt*k3);

        step = rho+ + 1/6*(k1 + 2*k2 + 2*k3 + k4)*dt;
    
    end
    

    Y = zeros(psiHeight, leng);
    
    for n = 1:leng
        Rho = rk_algorithm(tVector(n),Rho);
        Y(:,n) = Rho;
    end
    
    Solution = Y;
end