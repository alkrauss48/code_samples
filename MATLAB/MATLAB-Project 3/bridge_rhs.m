function [b] = bridge_rhs(force,btype)
% Usage: [b] = bridge_rhs(force,btype)
%
% Constructs the rhs b to the linear system Ax=b, that describes the
% deformation of a bridge under a given load.
% 
% Inputs: force - 1D array of force values (any length, though > 50 preferred).  
%                 These will be interpolated onto the road-level of the bridge, 
%                 and added to gravitational forces.  Typically these should 
%                 all have positive values, unless a helicopter or something is
%                 pulling up on the bridge.  The forces should be in Newtons.
%         btype - type of bridge to build:
%                 0 -> steel
%                 1 -> wood
%                 2 -> rubber
%                 3 -> gummy
% Outputs: b - linear system rhs vector
%
% Daniel R. Reynolds
% SMU Mathematics
% Spring 2010


% bridge properties
%    rho = density [g/cm^3] 
if (btype == 0)      % steel
   rho = 7.8;
elseif (btype == 1)  % wood (pine)
   rho = 0.55;
elseif (btype == 2)  % rubber (tire rubber)
   rho = 1.1;
else                 % gummy worms
   rho = 5;
end
A0 = 0.01;           % cross-sectional area of a beam [m^2]
g  = 9.8;            % gravitational constant [m/s^2]
lb2kg = 0.45359237;  % conversion factor from lb to kg
rho = rho/1000;      % conversion to kg/m^3

% load bridge structure
%   nodes: coordinates of the nodes (meters)
%     one row for each node: [x-coordinate, y-coordinate]
nodes = load('nodes.txt');
%   bdry nodes
%     list of the nodes that are affixed to the rock
bdry = load('bdry.txt');
%   beams: end nodes and beam stiffness (GPa) 
%     one row for each beam:  [n1 n2 k]
beams = load('beams.txt');

% get the numbers of nodes and beams from input data
[nnodes,tmp] = size(nodes);
[nbeams,tmp] = size(beams);

% set up array of external forces acting on each node
%   one row for each node:  [f_x, f_y]
forces = zeros(length(nodes),2);
%   first compute the gravitational force on each node, ascribing 
%   each node with half the weight of the adjoining beams [nonphysical]
for i=1:nbeams
   l = sqrt((nodes(beams(i,1),1) - nodes(beams(i,2),1))^2 ...
           +(nodes(beams(i,1),2) - nodes(beams(i,2),2))^2);
   forces(beams(i,1),2) = forces(beams(i,1),2) + l*A0*g*rho/2;
   forces(beams(i,2),2) = forces(beams(i,2),2) + l*A0*g*rho/2;
end
%   assume nodes for top of bridge are consecutively numbered
height = max(nodes(:,2));
topnodes = (find(nodes(:,2)==height,1)):(find(nodes(:,2)==height,1,'last'));
%   interpolate user input forces to top of bridge (in case dims don't match)
x  = linspace(0,1,length(force));
xi = linspace(0,1,length(topnodes));
topforce = interp1(x,force,xi)';
%   add in user forces, converting from tons to Newtons
forces(topnodes,2) = forces(topnodes,2) + 2000*lb2kg*g*topforce;


% Adjust the forces so that they do not act on the bdry nodes
for i=1:length(bdry)
   n = bdry(i);
   forces(n,:) = [0, 0];
end

% set up the rhs vector, b
b = zeros(2*nnodes,1);
for i=1:nnodes
   b(2*i-1) = forces(i,1);  % x-force
   b(2*i)   = forces(i,2);  % y-force
end

% end function
