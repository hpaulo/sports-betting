function [c, ceq] = confun(x)
% c = [;-x(1)*x(2)-10];

% c = [1.5+x(1)*x(2)-x(1)-x(2);-x(1)*x(2)-10];
B = 100;
w1 = 100; 
w2 = 100;
w3 = 100;
w4 = 100;
w5 = 100;
w6 = 100;
% R = R;

% R = evalin('base','R');
% 
% return1 = R(1)*(x(1)+w1+x(2)+w2)*(x(1)/(x(1)+w1));
% return2 = R(2)*(x(1)+w1+x(3)+w3)*(x(1)/(x(1)+w1));
% return3 = R(3)*(x(1)+w1+x(4)+w4)*(x(1)/(x(1)+w1));
% return4 = R(4)*(x(1)+w1+x(5)+w5)*(x(1)/(x(1)+w1));
% return5 = R(5)*(x(1)+w1+x(6)+w6)*(x(1)/(x(1)+w1));

c = [x(1)+x(2)+x(3)+x(4)+x(5)+x(6)-B;...
%     x(1)+x(3)-B-return1;...
%     x(1)+x(4)-B-return1-return2;...
%     x(1)+x(5)-B-return1-return2-return3;...
%     x(1)+x(6)-B-return1-return2-return3-return4;...
    -x(1);...
    -x(2);...
    -x(3);...
    -x(4);...
    -x(5);...
    -x(6)];
ceq = []; 
end