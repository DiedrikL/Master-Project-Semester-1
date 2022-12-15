classdef TimeOptions
    properties
       Tstart double;
       Tpulse double;
       Tsize double {mustBeGreaterThan(Tsize,0)};
    end

    
    methods
        function Time = TimeOptions(options)
            arguments
               options.Tstart(1,1) double = 0;
               options.Tpulse(1,1) double = 2*pi;
               options.Tsize(1,1) double = 1000;
            end
            
            Time.Tstart = options.Tstart;
            Time.Tpulse = options.Tpulse;
            Time.Tsize = options.Tsize;
        end
    end
end