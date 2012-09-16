function x = lower_solve(L,b)
% Usage: x = Lower_solve(L,b)
%
% This routine solves the lower-triangular system Lx=b using column-oriented
% forwards Substitution.
% Inputs:   L  lower-triangular matrix
%           b  right-hand side vector
% Output:   x  solution vector
%
% Aaron Krauss
% Math3315 / CSE3365
% Spring 2010
%

% check input arguments for correct size
[n,m] = size(b);
[Lrows,Lcols] = size(L);
if ((Lrows ~= n) || (Lcols ~= n))
   disp('lower_solve error: L and b are mis-matched');
   return;
end

% allocate the solution vector
x = zeros(size(b));

% check for singular matrix
if (any(diag(L)==0))
   disp(sprintf('lower_solve error: singular matrix, abort!'));
   return
end

% row-oriented backwards substitution algorithm
for j=1:n
   % solve for this row of solution
   x(j) = b(j)/L(j,j);

   % update all subsequent rhs
   for i=n:-1:j+1
      b(i) = b(i) - L(i,j)*x(j);
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
