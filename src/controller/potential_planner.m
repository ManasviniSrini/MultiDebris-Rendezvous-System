%function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)
%This function uses a given control field (@boxIvory2 plannerParameters.control)
%to implement a generic potential-based planner with step size @boxIvory2
%plannerParameters.epsilon, and evaluates the cost along the returned path. The
%planner must stop when either the number of steps given by @boxIvory2
%plannerParameters.NSteps is reached, or when the norm of the vector given by
%@boxIvory2 plannerParameters.control is less than $10^-3$ (equivalently,
%@boxIvory2 1e-3).
function [xPath,UPath]=potential_planner(xStart,world,potential,plannerParameters)

% initialize variables
NSteps = plannerParameters.NSteps;
epsilon = plannerParameters.epsilon;


% initialize paths
xPath = zeros(2,NSteps); 
UPath = zeros(1,NSteps); 


% fill in first iteration of paths
xPath(:,1) = xStart; 
UPath(1) = plannerParameters.U(xStart, world, potential);


% take step < 1000 steps & mag(gradient is > 10^-3)
for iSteps = 1:NSteps - 1
    current_control = plannerParameters.control(xPath(:,iSteps), world, potential); 
    xPath(:, iSteps+1) = xPath(:,iSteps) + epsilon * current_control;
    UPath(iSteps+1) = plannerParameters.U(xPath(:, iSteps+1), world, potential);

end

% make sure to check dimensions



