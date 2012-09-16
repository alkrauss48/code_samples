N = 100;
p = .5; vo = 15; g = 9.8; vr = g/p;
tvals = linspace(0,4.5,N);
for i=1:N
	t = tvals(i);
	fvals(i) = ((vo+vr)/p)*(1-(exp((-1*p)*t))) - (vr*t);
end
plot(tvals,fvals)                   % plot the function f(t)
xlabel('time'), ylabel('position')  % label the plot
title('simple plot')
