%% Multi-Target Debris Queue Ordering
% This function returns the x,y coordinates of targets sorted in order of retrival
% It also displays the targets in a figure

function [totalSortedTargets] = Multi_Target_Debris_Queue_Ordering()

% Create randomized 2D points and set the seed
rng(30)
nbTargets = 10;

%targets = randi(10, [2, nbTargets]);
targets = 25*rand([2, nbTargets]);
targets = targets - 15;

% Find the column index of the minimum and maximum x values
[~, minColIndexX] = min(targets(1, :));
[~, maxColIndexX] = max(targets(1, :));

% Extract the minx points and maxx points
minXTarget = targets(:, minColIndexX);
maxXTarget = targets(:, maxColIndexX);

% Find the line equation between them
x1 = minXTarget(1);
y1 = minXTarget(2);
x2 = maxXTarget(1);
y2 = maxXTarget(2);

% Calculate the slope (m) and y-intercept (b) of the line
m = (y2 - y1) / (x2 - x1);
b = y1 - m * x1;

% Display the results
disp('Targets:')
disp(targets)

disp('MinX Target:')
disp(minXTarget)

disp('MaxX Target:')
disp(maxXTarget)

disp('Line Equation:')
disp(['y = ', num2str(m), 'x + ', num2str(b)])

% Put the targets into Top or Bottom based on above or below line
aboveTargets = [];
belowTargets = [];

for i = 1:nbTargets 
    if targets(2,i) > m * targets(1,i) + b
        aboveTargets = [aboveTargets targets(:,i)];
    else
        belowTargets = [belowTargets targets(:,i)];
    end
end


% Sort targets based on the first column (X-coordinate)
sortedAboveTargets = sortrows(aboveTargets', 1)';
sortedBelowTargets = sortrows(belowTargets', 1, 'descend')';

% Display the sorted targets
disp('Sorted AboveTargets (based on the first column):');
disp(sortedAboveTargets);
disp('Sorted BelowTargets (based on the first column):');
disp(sortedBelowTargets);

% Concatenate the sortedAboveTargets and sortedBelowTargets
totalSortedTargets = [sortedAboveTargets sortedBelowTargets];
totalSortedTargets = [totalSortedTargets totalSortedTargets(:,1)];

% Plotting
figure;
hold on;

% Plot the line between min and max X targets
plot([minXTarget(1), maxXTarget(1)], [minXTarget(2), maxXTarget(2)], 'k--', 'DisplayName', 'Line between MinX and MaxX');

% Plot arrows for sortedAboveTargets
quiver(totalSortedTargets(1, 1:end-1), totalSortedTargets(2, 1:end-1), ...
    diff(totalSortedTargets(1, :)), diff(totalSortedTargets(2, :)), ...
    0, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 0.2, 'DisplayName', 'Order of Queued Targets');

% Plot the original targets
scatter(targets(1, :), targets(2, :), 'b', 'filled', 'DisplayName', 'Targets');

% Plot the first target in a green color
scatter(totalSortedTargets(1,end-1), totalSortedTargets(2,end-1), 'green','filled',  'DisplayName', 'START');

% Draw a box centered around the green dot
boxSize = 1; % You can adjust the size of the box
rectangle('Position', [totalSortedTargets(1, end-1)-boxSize/2, totalSortedTargets(2, end-1)-boxSize/2, boxSize, boxSize], 'EdgeColor', 'm', 'LineWidth', 2);

% Set axis labels and legend
xlabel('X-axis');
ylabel('Y-axis');
legend('Location', 'Best');
title('Multi-Target Debris Queue Ordering');
grid on
axis equal

% Initialize font size
set(gca, 'FontSize', 14); % Adjust the font size as needed

hold off;
end
