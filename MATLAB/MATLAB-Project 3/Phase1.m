function [xsol,ysol] = Phase1(A, b)   
% Usage:  [U,c] = gauss_elim(A, b)
%
% This performs 2 different types of solution methods. 1 is gauss elim +
% upper solve, 2 is LU decomp + lower solve + upper solve. They both equal
% the same solution and have a 0 matrix as their difference
%
% Inputs:   A  matrix
%           b  right-hand side vector
% Outputs:  xsol  solution 1
%           ysol  solution 2
%
% Aaron Krauss
% Math3315 / CSE3365
% Spring 2010
%

% check input arguments for correct size
normA = A;
normB = b;
[n,m] = size(b);
[Arows,Acols] = size(A);
if ((Arows ~= n) || (Acols ~= n))
   disp('gauss_elim error: A and b are mis-matched');
   return;
end

% loop over diagonals
for k = 1:n-1
   % perform elimination below this subdiagonal
   for i = k+1:n
      if (A(k,k) == 0) 
	 disp(sprintf('gauss_elim failure: singular matrix (row %i)!',k));
	 return;
      end
      m = A(i,k)/A(k,k);
      A(i,k:n) = A(i,k:n) - A(k,k:n)*m;
      b(i) = b(i) - b(k)*m;
   end
end
disp('After Gaussian Elimination');
disp('A = ');
disp(A);
disp('b = ');
disp(b);


%end Gauss_elim
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin upper solve
U = A;
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

xsol = x;

disp('After Upper Solve, the solution is');
disp('x = ');
disp(xsol);
%end upper solve
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
%begin LU_decomp
A = normA;
b = normB;

[Arows,Acols] = size(A);
[n,n] = size(A);
U = size(A);
L = size(A);
if ((Arows ~= n) || (Acols ~= n))
   disp('lu_decomp error: A is mis-matched');
   return;
end

for x = 1:n
    for y = 1:n
        L(x,y) = 0; %sets all of L to zero
        %U(x,y) = 0; %sets all of U to zero
    end
end

U = A;

% loop over diagonals
for k = 1:n-1
   % perform elimination below this subdiagonal
   L(k,k) = 1;
   L(k+1,k+1) = 1;
   for i = k+1:n
      if (A(k,k) == 0) 
	 disp(sprintf('lu_decomp failure: singular matrix (row %i)!',k));
	 return;
      end
      m = U(i,k)/U(k,k);
      L(i,k) = m;
      U(i,k:n) = U(i,k:n) - U(k,k:n)*m;
   end
end

disp('After LU decomposition');
disp('L = ');
disp(L);
disp('U = ');
disp(U);
%end lu_decomp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin lower solve
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


disp('After lower solve, the temp solution is c = ');
disp(x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = x;
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
ysol = x;
disp('After the final upper solve, the solution x = ');
disp(ysol);

disp('Differences between the solution (x-y) is');
disp(xsol - ysol);
