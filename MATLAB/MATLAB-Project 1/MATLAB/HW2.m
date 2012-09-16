x1 = linspace(1,10,99); % x values
y1 = cos(x1);           % y values
subplot(2,2,1)
plot(x1,y1)

x2 = linspace(-2,4,101);% x values
y2 = -1./(x2.^3 + 10);  % y values
subplot(2,2,2)
plot(x2, y2)

x3 = linspace(-1*pi,pi,200);                        % x values
y3 = (sin(x3) - sin(2*x3))./(cos(x3) + cos(3*x3));  % y values
subplot(2,2,3)
plot(x3,y3)
axis([-1 1 -200 200])

x4 = linspace(-1*pi,pi,200);                        % x values
y4 = (sin(x3) - sin(2*x3))./(cos(x3) + cos(3*x3));  % y values
subplot(2,2,4)
plot(x4,y4)
axis([-4 4 -200 200])
