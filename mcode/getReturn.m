function [ money ] = getReturn( winner , x , w )

    poolSize = sum(x) + sum(w);

    if winner == 1
        fraction = x(1)/(x(1)+w(1));
    else
        fraction = x(2)/(x(2)+w(2));
    end
    
    money = fraction*poolSize;

end

