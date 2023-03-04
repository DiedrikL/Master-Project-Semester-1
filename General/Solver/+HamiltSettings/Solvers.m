classdef Solvers
    % Enum to hold all solvers in project
    properties
        solver function_handle 
    end
    
    methods
        function con = Solvers(solver)
            con.solver = solver;
        end
    end

    enumeration
        Crank_Nicolson(@(psi,hamilt) SolveFunk.Crank_Nicolson(psi,hamilt))
        Crank_Nicolson_with_steps(...
            @(psi,hamilt) SolveFunk.Crank_NicolsonWithSteps(psi,hamilt))
        Runge_Kutta(@(rho, hamilt) SolveFunk.Runge_Kutta(rho, hamilt))
        Runge_Kutta_Rho(@(rho, hamilt) SolveFunk.Rho_Runge_Kutta(rho, hamilt))
    end
end