%% Artifical Potential Field (APF) Method
% This function calculates all of the paths from a target to the next and
% displays the path, and saves the xPaths to xPathData.mat to use with the
% MPC

function [runtimeVector] = APF_all(totalSortedTargets)

% sphere_plot(sphere,color) done
sphere = struct('xCenter', [0;0], 'radius', 1, 'distInfluence', 1);
color = 'r';

% [dPointsSphere] = sphere_distance(sphere,points) done
points = [0;1];
[dPointsSphere] = sphere_distance(sphere,points);

% [gradDPointsSphere] = sphere_distanceGrad(sphere, points) done
[gradDPointsSphere] = sphere_distanceGrad(sphere, points);

% grid_plotThreshold(fHandle, threshold,grid)
 potential = struct('shape','quadratic','xGoal',[0;0],'repulsiveWeight',10);

% [URep] = potential_repulsiveSphere(xEval, sphere) ok
xEval = [2;1];
[URep] = potential_repulsiveSphere(xEval, sphere);

sphereworld = load('sphereworld.mat');

% [UAttr] = potential_attractive(xEval,potential)
[UAttr] = potential_attractive(xEval,potential);

% [gradUAttr] = potentioal_attractiveGrad(xEval, potential)
gradUAttr = potential_attractiveGrad(xEval, potential);

% Set Obstacles
world(1).xCenter = [0; 0];
world(1).radius = [-20];
world(1).distInfluence = 1;
world(2).xCenter = [-10;-7];
world(2).radius = [1];
world(2).distInfluence = 1;
world(3).xCenter = [5;-11];
world(3).radius = [2];
world(3).distInfluence = 1;
world(4).xCenter = [2;-2];
world(4).radius = [3];
world(4).distInfluence = 1;
world(5).xCenter = [-7;7];
world(5).radius = 2;
world(5).distInfluence = 1;
world(6).xCenter = [-10;4];
world(6).radius = 1;
world(6).distInfluence = 1;
world(7).xCenter = [-3;1];
world(7).radius = 2;
world(7).distInfluence = 1;

% Create goal and start vectors from the totalSortedTargets
xGoal1 = totalSortedTargets(:,2:end);
xStart1 = totalSortedTargets(:, 1:end-1);

% save sphereworld1.mat with the new xGoal, xStart values
save('sphereWorld1.mat', 'world', 'xGoal1', 'xStart1')

runtimeVector = potential_planner_runPlotTest2(totalSortedTargets);
 end