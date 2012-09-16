function p = polyval_lagrange(x,f,z)
% Usage: p = polyval_lagrange(x,f,z)
%
% This routine evaluates the polynomial p(z) defined in the Lagrange basis
% by 
%     p(z) = f(1)*l1(z) + f(2)*l2(z) + ... + f(n)*ln(z).
% Inputs:   x  data locations [array of length n]
%                 (we assume that x(i) ~= x(j) for i ~= j)
%           f  data values (array of length n]
%           z  evaluation point(s) [may be array valued]
% Outputs:  p  p(z) [same size as input z]
%
% Daniel R. Reynolds
% Math3315 / CSE3365
% Spring 2010
%

% check inputs
if (length(x) ~= length(f)) 
   disp(sprintf('polyval_lagrange error: (x,f) have different sizes!'));
   return
end
n = length(x);

% initialize output
p = zeros(size(z));

% iterate over Lagrange basis functions
for k=1:n
   
   % initialize l
   l = ones(size(z));
   
   % iterate over data to construct l(z)
   for j=1:n
      % exclude the k-th data point
      if (j ~= k)
	 l = l.*(z-x(j))/(x(k)-x(j));
      end
   end
   
   % add in contribution from this basis function into p
   p = p + f(k)*l;
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
