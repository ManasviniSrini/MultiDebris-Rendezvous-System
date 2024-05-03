function [runtimeVector] = potential_planner_runPlotTest2(totalSortedTargets)

%loading problem data from file
load('sphereworld1.mat');

% initialize variables
U = @potential_total;
control = @(xEval, world, potential) -potential_totalGrad(xEval, world, potential);
repulsiveWeight = 0.02;
shape = ["conic", "quadratic"];
NSteps = 400;
epsilon = .01;
color = ["r", "r", "r", "r", "r", "r", "r", "r", "r", "r"];
colorstring = string(color);
linewidth = 2;
set(groot, 'defaultAxesLineWidth', linewidth);
totalRunTime = 0;
runtimeVector = 0;

% Adjust the size of the box
boxSize = 2; 

for i = 1:length(totalSortedTargets(1,:))-1
    figure;

    potential = struct('xGoal', xGoal1(:,i), 'repulsiveWeight', repulsiveWeight, ...
           'shape', shape(2));

    plannerParameters = struct('U', U, 'control', control, ...
            'epsilon', epsilon, 'NSteps', NSteps);
    tic;
    [xPath, ~] = potential_planner(xStart1(:,i), world, potential, plannerParameters);
    runtime = toc;

    totalRunTime = totalRunTime + runtime;
    runtimeVector = [runtimeVector runtime];
    sphereworld_plot(world, totalSortedTargets)
   
    hold on;
    
    % Plot all targets
    plot(totalSortedTargets(1,:), totalSortedTargets(2,:), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

    plot(xPath(1,:), xPath(2,:),colorstring(1), 'LineWidth', 2)
    hold on;
    rectangle('Position', [totalSortedTargets(1, end)-boxSize/2, totalSortedTargets(2, end)-boxSize/2, boxSize, boxSize], 'EdgeColor', 'm', 'LineWidth', 2);
    plot(xStart1(1,i),xStart1(2,i), 'go', 'MarkerFaceColor', 'green');
    
    % Display runtime on the plot
    text(0.95, 0.95, sprintf('Runtime: %.4f sec', runtime), 'Units', 'normalized', 'FontSize', 12, 'HorizontalAlignment', 'right');

    title('APF-Based Path from Start to Goal Target', 'FontSize', 18)
    xlabel('Units', 'FontSize', 18)
    ylabel('Units', 'FontSize', 18)
    grid on;

end 

% Plot the whole path at once
boxSize = 2; 
figure;

sphereworld_plot(world, totalSortedTargets)

hold on
plot(xStart1(1,1), xStart1(2,1), 'go', 'MarkerFaceColor', 'green');
rectangle('Position', [totalSortedTargets(1, end)-boxSize/2, totalSortedTargets(2, end)-boxSize/2, boxSize, boxSize], 'EdgeColor', 'm', 'LineWidth', 2);

% Preallocate xPath to store all trajectories
xPath = cell(1, length(totalSortedTargets(1,:))-1);

for i = 1:length(totalSortedTargets(1,:))-1

    potential = struct('xGoal', xGoal1(:,i), 'repulsiveWeight', repulsiveWeight, ...
           'shape', shape(2));
     plannerParameters = struct('U', U, 'control', control, ...
            'epsilon', epsilon, 'NSteps', NSteps);
    [xPath{i}, ~] = potential_planner(xStart1(:,i), world, potential, plannerParameters);

    % Plot each trajectory on the same subplot
    plot(xPath{i}(1,:), xPath{i}(2,:), colorstring(1), 'LineWidth', 2);
end

hold on;

scatter(totalSortedTargets(1, :), totalSortedTargets(2, :), 'filled', 'ob', 'DisplayName', 'Targets');
title('APF-Based Path to All Targets', 'FontSize', 18)
xlabel('Units', 'FontSize', 18)
ylabel('Units', 'FontSize', 18)
grid on

% Display runtime on the plot
text(0.95, 0.95, sprintf('Total Runtime: %.4f sec',totalRunTime), 'Units', 'normalized', 'FontSize', 12, 'HorizontalAlignment', 'right');

hold off;

% Save xPath to a .mat file
save('xPathData.mat', 'xPath');

end
