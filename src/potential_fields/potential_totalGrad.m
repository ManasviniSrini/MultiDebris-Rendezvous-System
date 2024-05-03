%function [gradU]=potential_totalGrad(xEval,world,potential)
%Compute the gradient of the total potential, $ U= U_ attr+  @ @ _i U_ rep,i$,
%where $ $ is given by the variable  @x   potential.repulsiveWeight
function [gradU]=potential_totalGrad(xEval,world,potential)

% xEval = [2;1];
% sphereworld = load('sphereworld.mat');
% world = sphereworld.world;
% potential = struct('shape','conic','xGoal',[0;4],'repulsiveWeight',10); % Change conic to quadratic later
% % 
% Initialize Variables
[~,NSpheres] = size(world);
alpha = potential.repulsiveWeight;
gradU = potential_attractiveGrad(xEval, potential);

%gradU = Uattr;
for i = 1:NSpheres
    gradU = gradU + alpha * potential_repulsiveSphereGrad(xEval, world(i));
end

end