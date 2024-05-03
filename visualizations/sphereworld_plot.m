%function sphereworld_plot(world,xGoal)
%Uses sphere_draw to draw the spherical obstacles together with a  * marker at
%the goal location.
function sphereworld_plot(world,xGoal)

nbSpheres = numel(world);

for iSphere=1:nbSpheres
    sphere_plot(world(iSphere),'b');
    hold on
end

if exist('xGoal','var')
    plot(xGoal(1,:),xGoal(2,:),'r*');
end
axis equal
