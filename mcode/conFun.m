function [ c , ceq ] = conFun( x , method )

    % assumes as input a column vector of decision variables, where the
    % dimension of the vector is equal to twice the number of matches    

    % No equality constraints
    ceq = [];
    
    % Grab variables from workspace
    n = evalin('base','numMatches');
    
    % max expected value, keep risk under target
    if method == 1
        pvar = evalin('base','variances');
        tvar = evalin('base','targetVariances');
        w = evalin('base','bettingPools');
        c = zeros(n,1);
        for i = 1:n
            r1 = getReturn(1,[x(2*i-1) x(2*i)],w(i,:));
            r2 = getReturn(2,[x(2*i-1) x(2*i)],w(i,:));
            c(i,:) = (r1.^2)*pvar(i,1) + (r2.^2)*pvar(i,2) -2*r1*r2*sqrt(pvar(i,1))*sqrt(pvar(i,2)) - tvar(i,:);
        end
    end

end

