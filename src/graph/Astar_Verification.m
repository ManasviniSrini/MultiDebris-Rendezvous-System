function [runtimeVector] = Astar_Verification(NCells, totalSortedTargets)
% This function takes in the number of cells for the grid path, sorted
% targets, and outputs a figure of A* finding goals

load("graph_testData.mat")

% Run A* with NCells
[runtimeVector] = sphereworld_search2(NCells, totalSortedTargets);

end