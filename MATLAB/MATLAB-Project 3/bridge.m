% Script to set loading vector, set up bridge system, solve using 
% Gaussian elimination and back-substitution, and plot the load 
% and undeformed/deformed bridge.
%
% Aaron Krauss
% Math3315 / CSE3365
% Spring 2010
%

% set the bridge type and max strain
btype = 1;          % [0->steel, 1->wood, 2->rubber, 3->gummy] 
max_strain = .1;   % [.05->steel, .1->wood, .5->rubber, .8->gummy]

% set up the linear system describing the bridge deformation under this load
disp('Getting bridge matrix:')
[A,nodes,beams] = bridge_matrix(btype);

% Set up loading vector and resulting rhs
disp('Getting bridge rhs:')
force = [4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091 4.091];
force2 = [0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
force3 = [0 0 0 0 0 0 0 0 0 0 0 400000/1000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
force4 = [0 0 0 0 0 0 0 0 0 0 0 700000/1000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
force5 = [0 0 0 0 0 0 0 0 0 0 0 1000000/1000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
b = bridge_rhs(force,btype);
b2 = bridge_rhs(force2,btype);
b3 = bridge_rhs(force3,btype);
b4 = bridge_rhs(force4,btype);
b5 = bridge_rhs(force5,btype);

B = b;
B2 = b2;
B3 = b3;
B4 = b4;
B5 = b5;

% Solve for x using built-in backslash command
disp('Solving bridge system with Gaussian elimination:')
tic;
[U,c] = gauss_elim(A,b);
x = upper_solve(U,c);
%force 2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[U,c] = gauss_elim(A,b2);
x2 = upper_solve(U,c);

%force 3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[U,c] = gauss_elim(A,b3);
x3 = upper_solve(U,c);

%force 4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[U,c] = gauss_elim(A,b4);
x4 = upper_solve(U,c);

%force 5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[U,c] = gauss_elim(A,b5);
x5 = upper_solve(U,c);
t = toc;
disp(sprintf('All 5 systems took %g seconds with Gaussian Elimination',t));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%LU Factorization begin
disp('Solving bridge system with LU Decomposition:')
%force1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[L,U] = lu_decomp(A);
tic;
c = lower_solve(L,B);
y = upper_solve(U,c);

%force2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = lower_solve(L,B2);
y = upper_solve(U,c);

%force3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = lower_solve(L,B3);
y = upper_solve(U,c);

%force4%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = lower_solve(L,B4);
y = upper_solve(U,c);

%force5%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = lower_solve(L,B5);
y = upper_solve(U,c);
t2 = toc;
disp(sprintf('All 5 systems took %g seconds with LU Decomposition',t2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% plot the original and loaded bridges
disp('Displaying result:')
plot_bridge(nodes,beams,x,max_strain) %only displaying first plot right now

% end program
