classdef TimeOptions
    properties
       Tstart;
       Tend;
       Tsize;
    end
    
    
    methods
        function Time = TimeOptions(options)
            arguments
               options.Tstart(1,1) double = 0;
               options.Tend(1,1) double = 2*pi;
               options.Tsize(1,1) double = 500;
            end
            
            Time.Tstart = options.Tstart;
            Time.Tend = options.Tend;
            Time.Tsize = options.Tsize;
            
        end
    end
end