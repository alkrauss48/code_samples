%Aaron Krauss
%inputs: x - vectors of x values
        %f - solutions to f(x) evaluated at x values

function b = newton_construct(x,f)
    m = length(f);
    b(1) = f(1);
    for k = 2:m
        b(k) = f(k) - newton_eval(b,x,k-1,x(k));
        for j = 1:k-1
            b(k) = b(k)/(x(k) - x(j));
        end
    end
end
