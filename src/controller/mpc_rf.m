% Main function to run the simulation with preset parameters
function mpc_rf()
    % Load the data points for the trajectory
    load('xPathData.mat', 'xPath');
    xPath= horzcat(xPath{:});
    % Define parameters for trajectory refinement
    dt = 0.1;
    N = 20; % Prediction horizon
    controlEffortWeight = 0.5;
    smoothnessWeight = 0.5;
    % Run the MPC-based trajectory refinement
    refinedTrajectory = refineTrajectoryNonlinear(xPath, dt, N, controlEffortWeight, smoothnessWeight);
     % Apply post-processing smoothing to the refined trajectory
    windowSize = 5; % Size of the moving average window
    refinedTrajectorySmoothed = smoothTrajectory(refinedTrajectory, windowSize);

    % Plot the initial and refined trajectories
    plotTrajectories(xPath, refinedTrajectorySmoothed);
    % Calculate and display metrics
    initialMetrics = calculateTrajectoryMetrics(xPath, dt);
    refinedMetrics = calculateTrajectoryMetrics(refinedTrajectorySmoothed, dt);
    dispMetrics(initialMetrics, refinedMetrics);
    
end

% Function to refine trajectory using MPC
function refinedTrajectory = refineTrajectoryNonlinear(xPath, dt, N, controlEffortWeight, smoothnessWeight)
    totalPoints = size(xPath, 2);
    refinedTrajectory = zeros((N + 1) * (totalPoints - 1), 2);
    initialGuess = repmat([0.1, 0], N, 1);
    currentIndex = 1;

    options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'MaxIterations', 1000, 'TolFun', 1e-6, 'Display', 'iter-detailed');

    for i = 1:(totalPoints - 1)
        xInitial = [xPath(1, i); xPath(2, i); 0; 0];
        xTarget = xPath(:, i+1);
        costFunction = @(u) calculateCostWithoutObstacles(u, xInitial, xTarget, dt, N, controlEffortWeight, smoothnessWeight);
        [optimizedControls, ~] = fminunc(costFunction, initialGuess, options);

        refinedSegment = zeros(N + 1, 2);
        refinedSegment(1, :) = xInitial(1:2)';
        for j = 1:N
            control = optimizedControls(2*j-1:2*j);
            xInitial = kinematicDynamics2D(xInitial, control, dt);
            refinedSegment(j + 1, :) = xInitial(1:2)';
        end

        endIndex = currentIndex + N; 
        refinedTrajectory(currentIndex:endIndex, :) = refinedSegment(1:end, :); 
        currentIndex = endIndex + 1;
        initialGuess = optimizedControls;
    end
    refinedTrajectory = refinedTrajectory(1:currentIndex-1, :);
end

% Function to calculate the cost for the optimizer
function totalCost = calculateCostWithoutObstacles(u, xInitial, xTarget, dt, N, controlEffortWeight, smoothnessWeight)
    u = reshape(u, [N, 2]);
    totalCost = 0;
    xTemp = xInitial;
    for j = 1:N
        xTemp = kinematicDynamics2D(xTemp, u(j, :), dt);
        trackingError = sum((xTemp(1:2) - xTarget).^2);
        controlEffort = sum(u(j, :).^2);
        totalCost = totalCost + trackingError + controlEffortWeight * controlEffort;
        
        if j > 1
            deltaControl = sum((u(j, :) - u(j-1, :)).^2);
            totalCost = totalCost + smoothnessWeight * deltaControl;
        end
    end
end

% Kinematic dynamics for 2D movement
function newState = kinematicDynamics2D(state, control, dt)
    x = state(1);
    y = state(2);
    vx = state(3);
    vy = state(4);
    ax = control(1);
    ay = control(2);
    new_x = x + vx * dt + 0.5 * ax * dt^2;
    new_y = y + vy * dt + 0.5 * ay * dt^2;
    new_vx = vx + ax * dt;
    new_vy = vy + ay * dt;
    newState = [new_x; new_y; new_vx; new_vy];
end

% Function to calculate trajectory metrics
function metrics = calculateTrajectoryMetrics(trajectory, dt)
    % Calculate path length
    metrics.length = calculatePathLength(trajectory);
    
    % Calculate fuel consumption
    metrics.fuelConsumption = calculateFuelConsumption(trajectory, dt);
    
    % Calculate smoothness
    metrics.smoothness = calculateSmoothness(trajectory);
    
    % Calculate time to completion
    metrics.totalTime = calculateTimeToCompletion(trajectory, dt);
    
    % Calculate maximal acceleration and deceleration
    [maxAccel, maxDecel] = calculateMaxAccelDecel(trajectory, dt);
    metrics.maxAccel = maxAccel;
    metrics.maxDecel = maxDecel;
    
    % Count the number of waypoints
    metrics.numWaypoints = countWaypoints(trajectory);
    
    % Calculate total curvature
    metrics.totalCurvature = calculateTotalCurvature(trajectory);
end

% Function to calculate the path length
function pathLength = calculatePathLength(trajectory)
    diffs = diff(trajectory);
    pathLength = sum(sqrt(sum(diffs.^2, 2)));
end

% Function to calculate fuel consumption
function fuelConsumption = calculateFuelConsumption(trajectory, dt)
    N = size(trajectory, 1);
    fuelConsumption = 0;

    % Define the interval for aggregating data points
    interval = 10000; % Adjust this interval based on your trajectory's resolution

    for i = 1:interval:(N - interval)
        % Calculate velocity over a larger interval to capture more significant movement
        v = (trajectory(i + interval, :) - trajectory(i, :)) / (interval * dt);
        segmentFuelConsumption = norm(v) * interval * dt;

        % Aggregate the fuel consumption
        fuelConsumption = fuelConsumption + segmentFuelConsumption;
    end
end


% Function to calculate smoothness of the trajectory
function smoothness = calculateSmoothness(trajectory)
    accels = diff(trajectory, 2); % Second derivative approximating acceleration changes
    smoothness = mean(sqrt(sum(accels.^2, 2)));
end

% Function to smooth the trajectory using a moving average filter
function smoothedTrajectory = smoothTrajectory(trajectory, windowSize)
    smoothedTrajectory = trajectory;
    for i = 1:size(trajectory, 2)
        smoothedTrajectory(:, i) = movmean(trajectory(:, i), windowSize);
    end
end

% Function to plot both the initial and refined trajectories
function plotTrajectories(initialPath, refinedPath)
    figure(1);
    plot(initialPath(1, :), initialPath(2, :), 'bo-', 'LineWidth', 1);
    title('Potential Planner Path', 'FontSize', 18); % Increase font size
    xlabel('X-axis', 'FontSize', 18); % Increase font size
    ylabel('Y-axis', 'FontSize', 18); % Increase font size
    grid on;
    
    % Plot refined path
    figure(2);
    plot(refinedPath(:, 1), refinedPath(:, 2), 'r*-', 'LineWidth', 1);
    title('Refined Trajectory', 'FontSize', 18); % Increase font size
    xlabel('X-axis', 'FontSize', 18); % Increase font size
    ylabel('Y-axis', 'FontSize', 18); % Increase font size
    grid on;
end

% Function to display metrics
function dispMetrics(initialMetrics, refinedMetrics)
    disp('Initial Trajectory Metrics:');
    disp(initialMetrics);
    disp('Refined Trajectory Metrics:');
    disp(refinedMetrics);
end
function totalTime = calculateTimeToCompletion(trajectory, dt)
    % Total time is simply the number of steps times the time step
    totalTime = size(trajectory, 1) * dt;
end
function [maxAccel, maxDecel] = calculateMaxAccelDecel(trajectory, dt)
    velocities = diff(trajectory) / dt;
    accelerations = diff(velocities) / dt;

    maxAccel = max(sqrt(sum(accelerations.^2, 2))); % Maximum acceleration
    maxDecel = min(sqrt(sum(accelerations.^2, 2))); % Maximum deceleration (min of magnitudes)
end
function numWaypoints = countWaypoints(trajectory)
    numWaypoints = size(trajectory, 1);
end
function totalCurvature = calculateTotalCurvature(trajectory)
    % Calculate the angle change at each point
    angles = atan2(diff(trajectory(:,2)), diff(trajectory(:,1)));
    angleDiffs = abs(diff(angles));
    
    % Sum of all angle changes
    totalCurvature = sum(angleDiffs);
end







