
function sphereworld_search(NCells)

% Load the variables xStart, xGoal from sphereworld.mat
load("sphereworld.mat");
load("graph_testData.mat");
color = ["r", "g", "b", "c", "m"];
colorstring = string(color);

%NCells = [6, 20, 200]

NCell1 = NCells(1);
NCell2 = NCells(2);
NCell3 = NCells(3);

%potential=struct('shape','conic','xGoal',[0;0],'repulsiveWeight',10); % Change conic to quadratic later

% NCell1 = 6
    % Run function
    [graphVector1] = sphereworld_freeSpace_graph(NCell1);

    % For goal 1
    xGoal1 = xGoal(:,1);
    xPath1 = zeros(2,length(xStart(1,:)));

    figure(1)
    sphereworld_plot(world,xGoal1)
    hold on;

    for i = 1:size(xStart,2)
        [xPath1] = graph_search_startGoal(graphVector1, xStart(:,i),xGoal1);
        hold on;
        grid on;
        axis equal;
        plot(xPath1(1,:), xPath1(2,:), colorstring(i), 'LineWidth', 2);
        graph_plot(graphVector1)
    end
    title('Sphere World Trajectory Plot (NCell = 6, Goal #1)', 'FontSize', 18);
    xlabel('counts', 'FontSize', 18);
    ylabel('counts', 'FontSize', 18);
    grid on
    axis equal

    % For goal 2
    xGoal2 = xGoal(:,2);
    xPath2 = zeros(2,length(xStart(1,:)));

    figure(2)
    sphereworld_plot(world,xGoal2)
    hold on;

    for i = 1:size(xStart,2)
        [xPath2] = graph_search_startGoal(graphVector1, xStart(:,i),xGoal2);
        hold on;
        grid on;
        axis equal;
        plot(xPath2(1,:), xPath2(2,:), colorstring(i), 'LineWidth', 2);
        graph_plot(graphVector1)
    end

    title('Sphere World Trajectory Plot (NCell = 6, Goal #2)', 'FontSize', 18);
    xlabel('counts', 'FontSize', 18);
    ylabel('counts', 'FontSize', 18);
    grid on
    axis equal

% NCell2 = 20
    % Run function
    [graphVector2] = sphereworld_freeSpace_graph(NCell2);

    % For goal 1
    xGoal1 = xGoal(:,1);
    xPath1 = zeros(2,length(xStart(1,:)));

    figure(3)
    sphereworld_plot(world,xGoal1)
    hold on;

    for i = 1:size(xStart,2)
        [xPath1] = graph_search_startGoal(graphVector2, xStart(:,i),xGoal1);
        hold on;
        grid on;
        axis equal;
        plot(xPath1(1,:), xPath1(2,:), colorstring(i), 'LineWidth', 2);
        graph_plot(graphVector2)
    end

    title('Sphere World Trajectory Plot (NCell = 20, Goal #1)', 'FontSize', 18);
    xlabel('counts', 'FontSize', 18);
    ylabel('counts', 'FontSize', 18);
    grid on
    axis equal
    
    % For goal 2
    xGoal2 = xGoal(:,2);
    xPath2 = zeros(2,length(xStart(1,:)));

    figure(4)
    sphereworld_plot(world,xGoal2)
    hold on;

    for i = 1:size(xStart,2)
        [xPath2] = graph_search_startGoal(graphVector2, xStart(:,i),xGoal2);
        hold on;
        grid on;
        axis equal;
        plot(xPath2(1,:), xPath2(2,:), colorstring(i), 'LineWidth', 2);
        graph_plot(graphVector2)
    end

    title('Sphere World Trajectory Plot (NCell = 20, Goal #2)', 'FontSize', 18);
    xlabel('counts', 'FontSize', 18);
    ylabel('counts', 'FontSize', 18);
    grid on
    axis equal


% NCell3 = 200
    % Run function
    [graphVector3] = sphereworld_freeSpace_graph(NCell3);

    % For goal 1
    xGoal1 = xGoal(:,1);
    xPath1 = zeros(2,length(xStart(1,:)));

    figure(5)
    sphereworld_plot(world,xGoal1)
    hold on;

    for i = 1:size(xStart,2)
        [xPath1] = graph_search_startGoal(graphVector3, xStart(:,i),xGoal1);
        hold on;
        grid on;
        axis equal;
        plot(xPath1(1,:), xPath1(2,:), colorstring(i), 'LineWidth', 2);
        graph_plot(graphVector3)
    end

    title('Sphere World Trajectory Plot (NCell = 200, Goal #1)', 'FontSize', 18);
    xlabel('counts', 'FontSize', 18);
    ylabel('counts', 'FontSize', 18);
    grid on
    axis equal
    
    % For goal 2
    xGoal2 = xGoal(:,2);
    xPath2 = zeros(2,length(xStart(1,:)));

    figure(6)
    sphereworld_plot(world,xGoal2)
    hold on;

    for i = 1:size(xStart,2)
        [xPath2] = graph_search_startGoal(graphVector3, xStart(:,i),xGoal2);
        hold on;
        grid on;
        axis equal;
        plot(xPath2(1,:), xPath2(2,:), colorstring(i), 'LineWidth', 2);
        graph_plot(graphVector3)
    end

    title('Sphere World Trajectory Plot (NCell = 200, Goal #2)', 'FontSize', 18);
    xlabel('counts', 'FontSize', 18);
    ylabel('counts', 'FontSize', 18);
    grid on
    axis equal
end