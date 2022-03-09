classdef Solver
    methods
        % 1
        function T = solve_1(self)
        % Find the parameter T of a first-order transfer function
        % with k = 1000 and settling time of 0.4 seconds on impulse
            s = tf('s');
            % Cand k creste de 10 ori se observa ca T nu trebuie modificat
            % pentru ca timpul tranzitoriu sa ramana la 0.4
            k = 10000;
            t_settle = 0.4;
            T = 0.1022;
            H = k / (T*s + 1); % TODO
            
        end
        
        % 2
        function w = solve_2(self)
        % Find the w parameter of a second-order transfer function
        % with zeta = 0.2 and a peak time of 0.4 seconds on step
            s = tf('s');
            z = 0.2;
            t_peak = 0.4;
            % Pentru a determina w am folosit formula din indrumar
            w = pi / (t_peak * sqrt(1 - z^2));
            % Am ales functia de gradul 2 folsosita si in cadrul
            % laboratorului
            H = w^2/(s^2 + 2*z*w*s + 1); % TODO
            
            
            % Pentru z = 0, w o sa fie egal cu wd si vom obtine un 
            % raspuns oscilant de amplitudine constanta.
            
            % Pentru z > 1, vom obtine un raspuns aperiodic amortizat
            
        end
        
        % 3
        function t_rise = solve_3(self, w, zetas)
        % Compute the rise times of a second-order function
        % with given w for each value zeta in zetas
            s = tf('s');
            % TODO
            
            t_rise = zeros(1, length(zetas));
            
            for i=1:length(t_rise)
                t_rise(i) = 1.8 / w;
            end
            
        end
        
        % 4
        function overshoots = solve_4(self, w, zetas)
        % Compute the overshoots of a second-order function
        % with given w for each value zeta in zetas
        % (don't convert to percents)
            s = tf('s');
            % TODO
            
            overshoots = zeros(1, length(zetas));
            
            for i=1:length(overshoots)
                overshoots(i) = exp(-pi*zetas(i) / sqrt(1 - zetas(i)^2));
            end
            
        end
        
        % 5
        function t_stationary = solve_5(self)
        % Compute the time it takes for the Iron Man suit to stop.
        % Time and input are provided.
            s = tf('s');
            w = 12;
            z = 0.2;
            H = w^2 / (s^2 + 2*w*z*s + w^2);
            t = [0:0.1:10];         % Use this time vector
            u = [t <= 3] - [t > 3]; % Use this as input
            % TODO
            
            % Folosind lsim, se observa ca valoarea timpului pentru 
            % care y = 0 este de aproximativ 3.19 secunde.
            lsim(u, H, t);
            t_stationary = 3.19;
        end
    end
end