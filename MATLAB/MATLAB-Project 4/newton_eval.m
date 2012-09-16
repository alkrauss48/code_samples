%Aaron Krauss


function q = newton_eval(b,x,l,z)
q = b(l);
for i=l-1:-1:1
    q = b(i) + (z - x(i))*q;
end
end

    