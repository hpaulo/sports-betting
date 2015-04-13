function f = objfun(x)

w1 = 1000; w2 = 1100;

f = -1*(x(1)+w1+x(2)+w2)*(x(1)/(x(1)+w1));
end


