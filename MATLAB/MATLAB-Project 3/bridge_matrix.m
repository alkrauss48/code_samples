function [S,nodes,beams] = bridge_matrix(btype)
% Usage: [A,nodes,beams] = bridge_matrix(btype)
%
% Constructs the matrix A to the linear system Ax=b, that describes the 
% deformation of a bridge under a given load.
% 
% Inputs:   btype - type of bridge to build:
%                 0 -> steel
%                 1 -> wood
%                 2 -> rubber
%                 3 -> gummy
% Outputs:  A - linear system matrix
%           nodes - data structure containing node information for bridge
%           beams - data structure containing beam information for bridge
%
% Daniel R. Reynolds
% SMU Mathematics
% Spring 2010


% bridge properties
%    E = elastic modulus [GPa] 
if (btype == 0)      % steel bridge
   E = 200;
elseif (btype == 1)  % wooden bridge (pine)
   E = 11;
elseif (btype == 2)  % rubber bridge (tire rubber)
   E = 0.1;
else                 % gummy bridge
   E = 0.00001;
end
A0 = 0.01;  % cross-sectional area of a beam [m^2]

% load bridge structure
%   nodes: coordinates of the nodes (meters)
%     one row for each node: [x-coordinate, y-coordinate]
nodes = load('nodes.txt');
%   bdry nodes
%     list of the nodes that are affixed to the rock
bdry = load('bdry.txt');
%   beams: end nodes and beam stiffness (relative strength) 
%     one row for each beam:  [n1 n2 k]
beams = load('beams.txt');

% get the numbers of nodes and beams from input data
[nnodes,tmp] = size(nodes);
[nbeams,tmp] = size(beams);

% Now we initialize the stretch matrix: one row per bar, two columns per node.
A = zeros(nbeams,nnodes*2);
for j=1:nbeams
   % Extract relevant data for beam j from table
   m = beams(j,1);    % node1 for beam
   n = beams(j,2);    % node2 for beam

   % unit vector connecting m to n
   mn = [nodes(n,1)-nodes(m,1), nodes(n,2)-nodes(m,2)];
   mn = mn;
   
   % insert each bar stretch
   A(j,2*n-1) = -mn(1);
   A(j,2*m-1) =  mn(1);
   A(j,2*n)   =  mn(2);
   A(j,2*m)   = -mn(2);
end


% Set up the K matrix as the spring constant of each beam
%     k = E*A0/l*1e6, which converts from MPa to N/m
K = zeros(nbeams);
for i=1:nbeams
   l = sqrt((nodes(beams(i,1),1) - nodes(beams(i,2),1))^2 ...
           +(nodes(beams(i,1),2) - nodes(beams(i,2),2))^2);
   K(i,i) = E*A0/l*1e6;
end

% Compute the system matrix A'KA, here denoted as S.
S = A'*K*A;

% Adjust the matrix to keep all bdry nodes fixed
for i=1:length(bdry)
   % get bdry index
   n = bdry(i);
   % set row/col for x-deformation at node to identity
   S(2*n-1,:) = zeros(1,nnodes*2);
   S(:,2*n-1) = zeros(nnodes*2,1);
   S(2*n-1,2*n-1) = 1;
   % set row/col for y-deformation at node to identity
   S(2*n,:) = zeros(1,nnodes*2);
   S(:,2*n) = zeros(nnodes*2,1);
   S(2*n,2*n) = 1;
end

% end function
