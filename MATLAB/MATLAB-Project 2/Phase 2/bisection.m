function x = bisection(Ffun, a, b, maxit, tol)
%
% Usage:  x = bisection(Ffun, a, b, maxit, tol)
%
% This routine solves the scalar-valued nonlinear equation f(x)=0 
% using the bisection method to a residual tolerance of tol.
%
% inputs:   Ffun    nonlinear functional
%           a       REAL lower-bound on interval containing solution
%           b       REAL upper-bound on interval containing solution
%           maxit   INTEGER maximum number of Newton iterations
%           tol     REAL solution tolerance
% outputs:  x       REAL solution 
%
% Aaron Krauss - originally Dr. Reynold's program
% Math3315/CSE3365
% Spring 2010
%

% initialization
x = (a+b)/2;

% check input arguments
if (floor(maxit) < 1) 
   disp(sprintf('bisection: maxit = %i < 1. Resetting to 100',floor(maxit))); 
   maxit = 100;
end
if (a >= b)
   disp(sprintf('bisection: illegal interval [%g, %g]!',a,b))
   return;
end
if (tol < eps)
   disp(sprintf('bisection: tol = %g < %g. Resetting to %g',tol,eps,10*eps))
   tol = 10*eps;
end

% get initial function values, size
fa = feval(Ffun,a);
fb = feval(Ffun,b);
if (fa*fb > 0) 
   disp(sprintf('bisection: bad interval, f(a)=%0.5g, f(b)=%0.5g',fa,fb))
   return
end
fx = feval(Ffun,x);
if (abs(fx) < tol)
   return
end
   
disp(sprintf(' Bisection Method: initial |f(x)| = %g',abs(fx)));
% begin iteration
for i=1:maxit
   
   % update interval
   if (fa*fx < 0)
      b = x;
      fb = fx;
   else
      a = x;
      fa = fx;
   end
   
   % compute updated guess, function value
   x = (a+b)/2;
   fx = feval(Ffun,x);
   
   % check for convergence and output diagnostics
   disp(sprintf('   iter %6i, interval [%0.7f,%0.7f], |f(x)| = %g',...
       i,a,b,abs(fx)));
   if (abs(fx) < tol)
      break;
   end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
