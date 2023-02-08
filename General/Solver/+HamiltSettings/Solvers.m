classdef Solvers
    properties
        solver function_handle 
    end
    
    methods
        function con = Solvers(solver)
            con.solver = solver;
        end
    end

    enumeration
        Crank_Nicolson(@(psi,hamilt) SolveTDSEgeneral(psi,hamilt))
        Runge_Kutta(@(rho, hamilt) Runge_kutta(rho, hamilt))
    end
end