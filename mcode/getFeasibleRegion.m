function [A,b] = getFeasibleRegion(n,budget)

    % Initialize A and b
    A = zeros(2*n+1,2*n);
    b = zeros(2*n+1,1);
    
    % Non-Negativity Constraint
    for i = 1:2*n
        A(i,i) = -1;
    end
    
    % Budget Constraint
    for i = 1:2*n
        A(2*n+1,i) = 1;
    end
    b(2*n+1,1) = budget;

end