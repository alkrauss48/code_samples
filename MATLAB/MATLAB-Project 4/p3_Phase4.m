%Aaron Krauss

%Question 1 - Dallas Avg. Monthly Temperatures

load dallas.txt;
n = length(dallas);
for i = 1:n
    x1(i) = dallas(i,1);
    fx1(i) = dallas(i,2);
end


p1 = polyval_lagrange(x1, fx1, 8-(2/31));
s1 = spline(x1,fx1, 8-(2/31));

%%%%%% Question 2 - Avg. Global Temp at Caesar's Death , -44 BC %%%%%%

load historical.txt;
n = length(historical);

for i = 1:n
    x2(i) = historical(i,1);
    fx2(i) = historical(i,2);
end

p2 = polyval_lagrange(x2, fx2, -44);
s2 = spline(x2, fx2, -44);

%%%%% Question 3 - Avg. Global Temp at Mastadon's Extinction - 10,000 years ago %%%%%%

p3 = polyval_lagrange(x2, fx2, -8010);
s3 = spline(x2, fx2, -8010);

%%%%%% Question 4  - Using Extrapolation for global temps in 2015, 2025, and 2050 %%%%%%

load gglobal.txt;
n = length(gglobal);

for i = 1:n
    x4(i) = gglobal(i,1);
    fx4(i) = gglobal(i,2);
end

p4_1 = polyval_lagrange(x4, fx4, 2015);
s4_1 = spline(x4, fx4, 2015);

p4_2 = polyval_lagrange(x4, fx4, 2025);
s4_2 = spline(x4, fx4, 2025);

p4_3 = polyval_lagrange(x4, fx4, 2050);
s4_3 = spline(x4, fx4, 2050);

