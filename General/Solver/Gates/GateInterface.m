classdef (Abstract) GateInterface
   methods(Abstract, Static)
       rotate = rotation(U)
   end
   
   properties(Abstract, Constant)
       gate
   end
end