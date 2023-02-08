classdef SignalDetection
    properties
        hits
        misses
        falseAlarms
        correctRejections
    end
    properties (Access = private)
        H
        FA
    end
    properties (SetAccess = private)
        d_prime
        criterion
    end
    methods
        function obj = SignalDetection(hits,misses, FAs, CR)
            obj.hits = hits;
            obj.misses = misses;
            obj.falseAlarms = FAs;
            obj.correctRejections = CR;
        end
        function obj = set.hits(obj,val)
            obj.hits = val;
            obj = HitRate(obj);
        end
        function obj = set.misses(obj,val)
            obj.misses = val;
            obj = HitRate(obj);
        end
        function obj = set.falseAlarms(obj,val)
            obj.falseAlarms = val;
            obj = FalseAlarm(obj);
        end
        function obj = set.correctRejections(obj,val)
            obj.correctRejections = val;
            obj = FalseAlarm(obj);
        end
        function obj = HitRate(obj)
            obj.H = obj.hits ./ (obj.hits + obj.misses);
            obj = D_Prime(obj);
            obj = Criterion(obj);
        end
        function obj = FalseAlarm(obj)
            obj.FA = obj.falseAlarms ./ (obj.falseAlarms + obj.correctRejections);
            obj = D_Prime(obj);
            obj = Criterion(obj);
        end
        function obj = D_Prime(obj)
            obj.d_prime = norminv(obj.H) - norminv(obj.FA);
        end
        function obj = Criterion(obj)
            obj.criterion = -.5 .* (norminv(obj.H) + norminv(obj.FA));
        end
    end
end
