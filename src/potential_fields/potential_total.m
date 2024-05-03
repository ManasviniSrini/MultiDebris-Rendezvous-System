%function [UEval]=potential_total(xEval,world,potential)
%Compute the function $U=U_attr+aU_rep,i$, where $a$ is given by the
%variable  potential.repulsiveWeight
function [UEval]=potential_total(xEval,world,potential)

% find world size

[~,world_size] = size(world); 


% Initialization of variables

UEval = potential_attractive(xEval,potential); 

repWeight = potential.repulsiveWeight;


% each obstacle for repulsive potential

for iworld_sphere = 1:world_size 

    UEval = UEval + repWeight * potential_repulsiveSphere(xEval,world(iworld_sphere));

end
