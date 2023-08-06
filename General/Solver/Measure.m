classdef Measure
    properties
        cutoff double
        number {isinteger}
    end

    methods
        function con = Measure(cutoff)
            con.cutoff = cutoff;

        end
    end
    enumeration
        NormDistance(0.5)
        AvgFidelity(0.5)
        ChoiFidelity(0.5)
    end
end