classdef (Abstract) GateInterface
   methods(Abstract, Static)
       rotate = rotation(U)
   end
   
   properties(Abstract, Constant)
       gate
       Psi0
   end
end