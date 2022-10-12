% Script for waitbar
classdef PoolWaitbar < handle
    properties (Access = private)
        N
        p
        formatSpec 
        h
        value
    end

    methods(Access = public)
        function this = PoolWaitbar(maxIter)
            arguments
                maxIter double
            end
            this.N = maxIter;

            % initilize values
            this.value = 2;
            this.p = 1;
            disp(this.p)

            this.formatSpec = 'Lowest value is: %d';
        
            str = sprintf(this.formatSpec, this.value);
            this.h = waitbar(0, str);
        end


        function updateBar(this)
            waitbar(this.p/this.N, this.h);
            this.p = this.p+1;
        end
        

        function updateBarValue(this, newValue)
            disp(this.p);
            if(newValue<this.value)
                this.value = newValue;
                str = sprintf(this.formatSpec, this.value);
                waitbar(this.p/this.N, this.h, str)

            else
                waitbar(this.p/this.N, this.h);
            end
            this.p = this.p+1;

        end

    end
end


