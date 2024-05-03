%function graph_search_test()
%Call graph_search to find a path between the bottom left node and the top right
%node of the @boxIvory2 graphVectorMedium graph from the
%@boxIvory2!70!DarkSeaGreen2 graph_testData.mat file (see Question~ q:graph test
%data). Then use graph_plot() to visualize the result.
function graph_search_test()

load("graph_testData.mat");

% Find path b/w bottom left node and top right node of graphVectorMedium
idxStart = 1;
idxGoal = 15;
[xPath,graphVector] = graph_search(graphVectorMedium,idxStart,idxGoal);

figure(1)
graph_plot(graphVectorMedium, 'nodeLabels',true,'edgeWeights',true,...
    'backpointerCosts',true,...
    'heuristic',true,...
    'start',4,'goal',2)
title('graphVectorMedium Test Plot', 'FontSize', 18);
ylabel('counts', 'FontSize', 18);
xlabel('counts', 'FontSize', 18);
grid on;

figure(2)
graph_plot(graphVectorMedium_solved,'nodeLabels',true,'edgeWeights',true,...
    'backpointerCosts',true,...
    'heuristic',true,...
    'start',4,'goal',2)
title('graphVectorMedium Solved Plot', 'FontSize', 18);
ylabel('counts', 'FontSize', 18);
xlabel('counts', 'FontSize', 18);
grid on;
end
