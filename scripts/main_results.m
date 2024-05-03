%% This script produces all figures and calls all necessary functions to execute the calculations
clear all; close all; clc;

%% A. Multi-Target Debris Queue Ordering
% This function returns the x,y coordinates of targets sorted in order of retrival
% It also displays the targets in a figure
[totalSortedTargets] = Multi_Target_Debris_Queue_Ordering();

%% B. Artifical Potential Field (APF) Method
% This function calculates all of the paths from a target to the next and
% displays the path, and saves the xPaths to xPathData.mat to use with the
% MPC
APF_runtimeVector = APF_all(totalSortedTargets);


%% C. Model Predictive Control (MPC) Method 
% This function takes in the xPathData.mat and uses it to locally refine
% the trajectory with [what factors does it consider].
mpc_rf();



%% D. Verification Method: Comparison with A* & base APF
% This function compares the speed of path calculation with the A*
% algorithm
% This function takes in the number of cells for the grid path, sorted
% targets, and outputs a figure of A* finding goals
NCells = 50;
Astar_runtimeVector = Astar_Verification(NCells, totalSortedTargets);

% Plotting of Runtime Vectors
segments = 1:1:length(APF_runtimeVector);

figure;
plot(segments, APF_runtimeVector ,'r',  'LineWidth', 2);
hold on;
plot(segments, Astar_runtimeVector, 'b',  'LineWidth', 2);
%plot(segments, [MPC runtimeVector, 'g', LineWidth', 2);
legend('Base APF', 'A*', 'FontSize', 18);
xlabel('Path Segments Between Targets','FontSize', 18);
ylabel('Time to Execute (seconds)', 'FontSize', 18);
title('Execution Time of Path Segments with Different Methods', 'FontSize', 18);
grid on;





