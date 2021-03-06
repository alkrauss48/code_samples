N = 25;                               % number of recursions
y = 2*exp(1) - 2;                                % set y0
disp(sprintf('\n'))                   % print a blank line
disp(sprintf('  n         y'))        % table headers
disp(sprintf('--------------------'))
disp(sprintf('  0  %14f',y))          % display first table row
for i=1:N                             % loop over recursion levels
   y = 2*(exp(1)) - (i*y);                     % generate next value of y
   disp(sprintf(' %2i  %14e',i,y))    % display this table row
end                                   % end the loop
disp(sprintf('--------------------\n'))
