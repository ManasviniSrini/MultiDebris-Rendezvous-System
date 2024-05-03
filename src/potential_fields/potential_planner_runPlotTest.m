%function potential_planner_runPlotTest()
%Show the results of potential_planner_runPlot for each goal location in
%@boxIvory2 world.xGoal, and for different interesting combinations of @boxIvory2
%potential.repulsiveWeight, @boxIvory2 potential.shape, @boxIvory2
%plannerParameters.epsilon, and @boxIvory2 plannerParameters.NSteps. In each
%case, for the structure @boxIvory2 plannerParameters should have the field
%@boxIvory2 U set to @boxIvory2 @potential_total, and the field @boxIvory2
%control set to the negative of @boxIvory2 @potential_totalGrad.
function potential_planner_runPlotTest()

%For the @boxIvory2 plannerParameters.control argument, pass a function computing
%the negative of the gradient. Start with $ $ in the inteval $@boxIvory2
%0.01-@boxIvory2 0.1$, $ $ in the range $@boxIvory2 1e-3-@boxIvory2 1e-2$, for
%@boxIvory2 plannerParameters.NSteps, use @boxIvory2 100, and explore from there.
%Typically, adjustments in @boxIvory2 repulsiveWeight require subsequent
%adjustments in @boxIvory2 epsilon. For  every case where the planner converges,
%add a plot where you zoom in closely around the final equilibrium. Hints are
%available for this question.

%loading problem data from file
load('sphereworld.mat');

% initialize variables
U = @potential_total;
control = @(xEval, world, potential) -potential_totalGrad(xEval, world, potential);
repulsiveWeight = 0.02;
shape = ["conic", "quadratic"];
NSteps = 400;
epsilon = .01;
color = ["r", "g", "b", "c", "m"];
colorstring = string(color);
linewidth = 2;
set(groot, 'defaultAxesLineWidth', linewidth);

% Goal 1: create structures needed for inputs
potential = struct('xGoal', xGoal(:,1), 'repulsiveWeight', repulsiveWeight, ...
        'shape', shape(2));

plannerParameters = struct('U', U, 'control', control, ...
        'epsilon', epsilon, 'NSteps', NSteps);

% create figures
figure(1)
subplot(1,2,1)
sphereworld_plot(world, xGoal(:,1))

% added lines below!!!
[xPath, ~] = potential_planner(xStart(:,2), world, potential, plannerParameters);
plot(xPath(1,:), xPath(2,:),colorstring(1), 'LineWidth', 2)
hold on;
plot(xStart(1,2),xStart(2,2),'b*');

% for i = 1:size(xStart,2)
%     [xPath, ~] = potential_planner(xStart(:,i), world, potential, plannerParameters);
%     hold on;
%     grid on;
%     axis equal;
%     plot(xPath(1,:), xPath(2,:),colorstring(i), 'LineWidth', 2);
% end 

title('World Plot with 5 Trajectories of xGoal 1', 'FontSize', 18)
xlabel('Units', 'FontSize', 18)
ylabel('Units', 'FontSize', 18)

subplot(1,2,2)

% added lines below!
[~, UPath] = potential_planner(xStart(:,2), world, potential, plannerParameters);
hold on
grid on
semilogy(UPath, colorstring(1));

% for i = 1:size(xStart,2)
%     
%     [~, UPath] = potential_planner(xStart(:,i), world, potential,plannerParameters);
%     hold on;
%     grid on;
%     semilogy(UPath,colorstring(i));
% end 

title('Values of Potential UPath with Corresponding Colors', 'FontSize', 18)
xlabel('Units', 'FontSize', 18)
ylabel('Potential (U)', 'FontSize', 18)

% % Goal 2: create structures needed for inputs
% potential2 = struct('xGoal', xGoal(:,2), 'repulsiveWeight', repulsiveWeight, ...
%         'shape', shape(1));
% 
% figure(2)
% subplot(1,2,1)
% sphereworld_plot(world, xGoal(:,2))
% 
% for i = 1:size(xStart,2)
% 
%     [xPath,~] = potential_planner(xStart(:,i),world, potential2, plannerParameters);
%     
%     hold on;
%     grid on;
%     axis equal;
% 
%     plot(xPath(1,:), xPath(2,:),colorstring(i), 'LineWidth', 2);
% end 
% title('World Plot with 5 Trajectories of xGoal 2', 'FontSize', 18)
% xlabel('Units', 'FontSize', 18)
% ylabel('Units', 'FontSize', 18)
% 
% subplot(1,2,2)
% for i = 1:size(xStart,2)
%     
%     [~, UPath2] = potential_planner(xStart(:,i), world, potential2, plannerParameters);
%     hold on;
%     grid on;
%     semilogy(UPath2,colorstring(i));
% end  
% 
% title('Values of Potential UPath with Corresponding Colors', 'FontSize', 18)
% xlabel('Units', 'FontSize', 18)
% ylabel('Potential (U)', 'FontSize', 18)

end

