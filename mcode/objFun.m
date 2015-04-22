function [ y ] = objFun( x , method )

    % assumes as input a column vector of decision variables, where the
    % dimension of the vector is equal to twice the number of matches

    % grab variables from base workspace, required for function
    n = evalin('base','numMatches');
    pmean = evalin('base','expectations');
    w = evalin('base','bettingPools');
    winners = evalin('base','winProbs');
    y = 0;
    
    % evaluating deterministic objective function (known winners, known wagers)
    if method == 0
        for i = 1:n
            r1 = getReturn(1,[x(2*i-1) x(2*i)],w(i,:));
            r2 = getReturn(2,[x(2*i-1) x(2*i)],w(i,:));
            y = y + winners(i,1)*r1 + winners(i,2)*r2;
        end
    % max expected value, keep risk under target
    elseif method == 1
        for i = 1:n
            r1 = getReturn(1,[x(2*i-1) x(2*i)],w(i,:));
            r2 = getReturn(2,[x(2*i-1) x(2*i)],w(i,:));
            y = y + pmean(i,1)*r1 + pmean(i,2)*r2;
        end
        y = -y; %equivalent to maximizing
    % mean markovitz
    else
        disp('MM')
    end

end

