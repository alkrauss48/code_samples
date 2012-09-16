function [L,U] = lu_decomp(A)
% Usage:  [L,U] = lu_decomp(A)
%
% This routine splits teh matrix A up into the L and U decompositions of
% itself, which are respectively lower and upper triangular matrices.
%
% Inputs:   A  matrix
%           
% Outputs:  U  upper-triangular matrix
%           L  lower-triangular matrix
%
% Aaron Krauss
% Math3315 / CSE3365
% Spring 2010
%

% check input arguments for correct size
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
