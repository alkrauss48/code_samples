function [A,b] = gauss_elim(A, b)   
% Usage:  [U,c] = gauss_elim(A, b)
%
% This routine performs Gaussian elimination on the system Ax=b, converting 
% it to the upper-triangular system Ux=c.  This routine should be followed
% up with the routine upper_solve.m to obtain the solution x.
%
% Inputs:   A  matrix
%           b  right-hand side vector
% Outputs:  U  upper-triangular matrix
%           c  modified right-hand side vector
%
% Daniel R. Reynolds
% Math3315 / CSE3365
% Spring 2010
%

% check input arguments for correct size
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
