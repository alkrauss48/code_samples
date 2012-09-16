function plot_bridge(nodes,bars,x,max_strain)
% Usage: plot_bridge(nodes,bars,def,max_strain)
%
% Plots the unloaded bridge, as well as the loaded bridge
% 
% Arguments:
%     nodes - table of all nodes in bridge, one row for each node: 
%                [x-coord, y-coord]
%     bars  - table of bars connecting nodes, one row for each bar:
%                [node1, node2, stiffness]
%     def   - deformation vector, obtained as solution from Ax=b 
%             with A,b given by bridge_system.m
%     max_strain - percent change allowed before damage occurs
%

% get the numbers of nodes and bars from input data
[nnodes,tmp] = size(nodes);
[nbars,tmp]  = size(bars);

% Now we draw the nodes of the original and deformed figure.
lx = max(nodes(:,1))-min(nodes(:,1));   % domain length
ly = max(nodes(:,2))-min(nodes(:,2));
r = 0.005*sqrt(lx^2 + ly^2);
t = 0:.01:1;              % a reference circle
mx = r*cos(2*pi*t);       % the parametric equations for the circles
my = r*sin(2*pi*t);

% Plot the original bridge
figure(1);
for i = 1:nnodes
   plot(nodes(i,1)+mx,nodes(i,2)+my,'k-'); hold on
end
for i = 1:nbars
   % nodes connecting this bar
   n = bars(i,1);
   m = bars(i,2);
   % bar end points
   xpts = [nodes(n,1),nodes(m,1)];
   ypts = [nodes(n,2),nodes(m,2)];
   % draw bar
   plot(xpts,ypts,'k-');
end
axis equal
axis off
title('Unloaded bridge')
hold off

% Plot the loaded bridge
figure(2);
for i = 1:nnodes
   plot(x(2*i-1)+nodes(i,1)+mx,-x(2*i)+nodes(i,2)+my,'k-'); hold on
end
for i = 1:nbars
   % nodes connecting this bar
   n = bars(i,1);
   m = bars(i,2);
   % bar end points
   xpts = [nodes(n,1)+x(2*n-1), nodes(m,1)+x(2*m-1)];
   ypts = [nodes(n,2)-x(2*n),   nodes(m,2)-x(2*m)];
   % compute relative strain
   s = [x(2*m-1)-x(2*n-1), x(2*m)-x(2*n)];
   r = [nodes(m,1)-nodes(n,1), nodes(m,2)-nodes(n,2)];
   % draw bar
   if (norm(s)/norm(r) > max_strain)
      plot(xpts,ypts,'r-','LineWidth',1);
   else
      plot(xpts,ypts,'k-');
   end
end
axis equal
axis off
title('Loaded bridge')
hold off

% end program
