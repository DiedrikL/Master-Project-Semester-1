classdef Measure
    properties
        cutoff double
        number {isinteger}
    end

    methods
        function con = Measure(cutoff, number)
            con.cutoff = cutoff;
            con.number = number;

        end
    end
    enumeration
        NormDistance(1,0)
        AvgFidelity(0.5,1)
    end
end