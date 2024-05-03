%function [xPath]=graph_search_startGoal(graphVector,xStart,xGoal)
%This function performs the following operations: enumerate  the two indexes  @x 
% idxStart,  @x   idxGoal in  @x   graphVector that are closest to  @x   xStart
%and  @x   xGoal (using graph_nearestNeighbors twice, see Question 
%q:graph-nearest).  graph_search to find a feasible sequence of points  @x  
%xPath from  @x   idxStart to  @x   idxGoal.   @x   xStart and  @x   xGoal,
%respectively, to the beginning and the end of the array  @x   xPath. enumerate
function [xPath]=graph_search_startGoal(graphVector,xStart,xGoal)

% find idxStart and idxGoal closest to xStart and xGoal w/
% graph_nearestNeighbors() 2x
k_nearest = 1;

[idxStart] = graph_nearestNeighbors(graphVector, xStart, k_nearest);
[idxGoal] = graph_nearestNeighbors(graphVector, xGoal, k_nearest);

% find sequence of points xPath from idxStart to idxGoal
xPath = graph_search(graphVector, idxStart, idxGoal);

% Append xStart and xGoal to beginning and end of xPath
xPath = [xStart xPath];
xPath = [xPath xGoal];
end
