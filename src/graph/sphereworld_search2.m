function [runtimeVector]= sphereworld_search2(NCell1, totalSortedTargets)

% Load the variables xStart, xGoal from sphereworld.mat
load("sphereworld1.mat");
load("graph_testData.mat");

%NCell1 = 50;
boxSize = 2;
combinedRuntime = 0;
runtimeVector = 0;

% Set the structure framework
potential = struct('shape','conic','xGoal1',[0;0],'repulsiveWeight',20); 

% NCell1 = 50
    % Run function
    [graphVector1] = sphereworld_freeSpace_graph(NCell1);


for i = 1:(length(totalSortedTargets) - 1)

    % For each goal 
    xGoalVerify = xGoal1(:,i);
    xStartVerify = xStart1(:,i);

    tic;
    [xPathVerify] = graph_search_startGoal(graphVector1, xStartVerify, xGoalVerify);
    runtime = toc;
    combinedRuntime = combinedRuntime + runtime;
    runtimeVector = [runtimeVector runtime];
    
    figure;
    sphereworld_plot(world,xGoalVerify); % world = world in both .mat
    hold on;
    grid on;
    axis equal;
    graph_plot(graphVector1);
    plot(xPathVerify(1,:), xPathVerify(2,:), 'r',  'LineWidth', 2);
    hold on;
   
    % Plot all targets
    plot(totalSortedTargets(1,:), totalSortedTargets(2,:), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
    plot(xStart1(1, i), xStart1(2, i), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'DisplayName', 'Start');
    plot(xGoal1(1, i), xGoal1(2, i), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Goal');

    % Display runtime on the plot
    text(0.95, 0.95, sprintf('Runtime: %.4f sec', runtime), 'Units', 'normalized', 'FontSize', 12, 'HorizontalAlignment', 'right');

    rectangle('Position', [totalSortedTargets(1, end)-boxSize/2, totalSortedTargets(2, end)-boxSize/2, boxSize, boxSize], 'EdgeColor', 'm', 'LineWidth', 2);


    title(sprintf('A* Trajectory Plot (NCell = %d)', NCell1), 'FontSize', 18);
    xlabel('counts', 'FontSize', 18);
    ylabel('counts', 'FontSize', 18);

end


    
%% All plots together now
% Create a new figure
figure;

% Run function
[graphVector2] = sphereworld_freeSpace_graph(NCell1);

% Initialize stuff
xGoalVerify2 = zeros(2, length(xGoal1(1, :)));
xStartVerify2 = zeros(2, length(xStart1(1, :)));

% Create a matrix to store all paths
allPaths = [];

for i = 1:(length(totalSortedTargets) - 1)

    % For each goal 
    xGoalVerify2(:, i) = xGoal1(:, i);
    xStartVerify2(:, i) = xStart1(:, i);

    % Calculate and plot the path
    [xPathVerify2] = graph_search_startGoal(graphVector2, xStartVerify2(:, i), xGoalVerify2(:, i));

    % Append the current path to the matrix
    allPaths = [allPaths, xPathVerify2];

    sphereworld_plot(world, xGoalVerify2(:, i)); % world = world in both .mat
    hold on;
    grid on;
    axis equal;
    graph_plot(graphVector2);

    % Plot all paths so far
    plot(allPaths(1, :), allPaths(2, :), 'r', 'LineWidth', 2);
    
    % Plot the current path
    plot(xPathVerify2(1, :), xPathVerify2(2, :), 'r', 'LineWidth', 2);
end

% Plot the box denoting Dock
rectangle('Position', [totalSortedTargets(1, end)-boxSize/2, totalSortedTargets(2, end)-boxSize/2, boxSize, boxSize], 'EdgeColor', 'm', 'LineWidth', 4);

% Plot all targets
plot(totalSortedTargets(1,:), totalSortedTargets(2,:), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

% Plot start target
plot(totalSortedTargets(1,1), totalSortedTargets(2,1), 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
    
% Total Runtime
text(0.95, 0.95, sprintf('Total Runtime: %.4f sec', combinedRuntime), 'Units', 'normalized', 'FontSize', 12, 'HorizontalAlignment', 'right');

% Customize the plot
title('A* Full Trajectory Plot (NCell = 50)', 'FontSize', 18);
xlabel('counts', 'FontSize', 18);
ylabel('counts', 'FontSize', 18);
end