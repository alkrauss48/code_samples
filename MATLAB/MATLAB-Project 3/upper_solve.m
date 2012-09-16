function x = upper_solve(U,b)
% Usage: x = upper_solve(U,b)
%
% This routine solves the upper-triangular system Ux=b using column-oriented
% Backwards Substitution.
% Inputs:   U  upper-triangular matrix
%           b  right-hand side vector
% Output:   x  solution vector
%
% Daniel R. Reynolds
% Math3315 / CSE3365
% Spring 2010
%

% check input arguments for correct size
[n,m] = size(b);
[Urows,Ucols] = size(U);
if ((Urows ~= n) || (Ucols ~= n))
   disp('upper_solve error: U and b are mis-matched');
   return;
end

% allocate the solution vector
x = zeros(size(b));

% check for singular matrix
if (any(diag(U)==0))
   disp(sprintf('upper_solve error: singular matrix, abort!'));
   return
end

% row-oriented backwards substitution algorithm
for j=n:-1:1
   % solve for this row of solution
   x(j) = b(j)/U(j,j);

   % update all subsequent rhs
   for i=1:j-1
      b(i) = b(i) - U(i,j)*x(j);
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
