function [c, ceq] = constraintFunc(x,budget)

budget = budget;
c = [x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7)+x(8)+x(9)+x(10)+x(11)+x(12)-budget;...
    -x(1);...
    -x(2);...
    -x(3);...
    -x(4);...
    -x(5);...
    -x(6);...
    -x(7);...
    -x(8);...
    -x(9);...
    -x(10);...
    -x(11);...
    -x(12)];
ceq = []; 
end