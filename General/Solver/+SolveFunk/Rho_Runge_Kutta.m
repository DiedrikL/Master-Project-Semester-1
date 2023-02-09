function [tVector, Solution] = Rho_Runge_Kutta(Rho, Hamiltonian)
    
    % Solves the schrödinger equation with the Runge Kutta method for a
    % specified Hamiltonian and startvalues Rho.
    
    
    % Input validation
    arguments
        Rho (:,:) double
        Hamiltonian Hamiltonians.Interfaces.LindbladInterface;
    end


    % Function for step in Runge Kutta
    function step = rk_algorithm(t, rho)
        k1 = H(t, rho); 

        rho2 = rho+dt*k1/2;
        k2 = H(t+dt/2, rho2);

        rho3 = rho+dt*k2/2;
        k3 = H(t+dt/2, rho3);

        rho4 = rho+dt*k3;
        k4 = H(t+dt, rho4);
        
        step = rho + 1/6*(k1 + 2*k2 + 2*k3 + k4)*dt;
    end
    
    % Get parameterized hamiltonian 
    H = Hamiltonian.createHamiltonian;
    
    
    % Set timelength
    dt = Hamiltonian.TimeStep;
    tVector = Hamiltonian.TimeVector;
    
    % Find sizes
    leng = length(tVector);
    psiHeight = Hamiltonian.matrixSize;

    

    Y = zeros(psiHeight, psiHeight, leng);
    
    for n = 1:leng
        Rho = rk_algorithm(tVector(n),Rho);
        Y(:,:,n) = Rho;
    end
    
    Solution = Y;
end