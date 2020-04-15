function [val] = quadgk_a01(f,a,b)
%% (1) IMPROVED QUADGK WITH SINGULARITY DETECTION

%% (2) VERSION 0.0.1 [CHANGELOG]
% Initial assumptions and proof of concept. 

%% (3) THE CUSTOM FUNCTION:
% Scans f(x) in the given interval (a,b) relying on the step by
% step increments of f(x) to detect singularites. The function
% works with 2 different step increments to somewhat improve
% the efficiency of the scan:
    % MODE 1: General scan. Step size = 0.01
    % MODE 2: Accurate scan. Step size = 0.0001
        % Activated when f(x) between the current step and the 
        % previous one is doubled. If this happens again while
        % in MODE 2, it is considered that a singularity has 
        % been found. Otherwise, the function will revert to 
        % MODE 1 to speed up the scan (*).
    % MODE 3: Singularity. Step size = 0.0001
        % Saves the point when the function switched to MODE 3.
        % Saves up another point when f(x) between two steps is
        % no longer being doubled (or more). The function will
        % then take both points and perform an arithmetic median
        % (we suppose the singularity is symetric). Finally, the
        % function will revert to MODE 2.

cP = SD(f); % Evaluation of f to determine the singularities.
int = [a cP b]; % First point, critical points and end point.
l = length(int); % (l-1) is the number of partitions.
for m = 1:(l-1)
    part = quadgk(f,int(m),int(m+1));
    val = part + val;
end        
        
%% SD FUNCTION
function cP = SD(f)
% Initialized variables:
step = 0.01; MODE = 1; u = 1;
for i = a:step:b    
    d = abs((f(i)-f(i-step))./f(i-step)); % Step increment.
    switch MODE    
        case 1
            if d >= 1 % Doubling growth rate.
                MODE = 2; % Switch to accurate scan.
                icm2 = 0; % Internal counter for MODE 2 (*).
            end
        case 2
            if icm2 < 2e4 % Int. counter below threshold.
                if d >= 1 % Doubling growth rate.
                    MODE = 3; % Examine the singularity.
                    pt1 = i; % Starting point of singularity.
                else
                    icm2 = icm2 + 1;
                end
            else
                MODE = 1; % Int. counter surpassed threshold.
            end
        case 3
            if d < 1 % Growth below doubling rate.
                MODE = 2; % Switch back to accurate scan.
                icm2 = 0; % Reset MODE 2 counter.
                pt2 = i; % End point of the singularity.
                cP(u) = (pt1+pt2)./2; % THE point of singularity.
                u = u + 1; % Counter of singularities.
            end
    end
end
end
end