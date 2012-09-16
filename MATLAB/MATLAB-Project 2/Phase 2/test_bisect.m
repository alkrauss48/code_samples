% This script tests the function bisection.m on a nonlinear function
% contained in the file f.m.  It uses an initial interval [-5,5], and solves
% for the root to a tolerance of 1e-4.
%
% Aaron Krauss - originally Dr. Reynold's program
% Math3315/CSE3365
% Spring 2010
%

% set the initial interval, max iteration count, and the tolerance
a = 200; 
b = 400;
maxit = 1000000;
tol = 1e-9;

% call bisection to compute the root, and output result to screen
x = bisection('f',a,b,maxit,tol);
disp('  ')
disp(sprintf('The approximate root is %15.8e',x));
disp('  ')

