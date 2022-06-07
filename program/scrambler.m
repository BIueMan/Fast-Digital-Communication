% all input need to a vector of 0 and 1 only!
% S - input of cluster of bit (vector)
function [T] = scrambler(S)
    seed=[1,0,1,1,0,0,0];
    % S - signal
    % T - transmit
    % D - delay
    D = seed;
    T = [];
    for i = 1:length(S)
        tmp = xor(D(4),D(7));
        T(end+1) = xor(tmp, S(i));
        
        % shift T to the data
        D = circshift(D,1);
        %D(1) = T(end);
    end
end