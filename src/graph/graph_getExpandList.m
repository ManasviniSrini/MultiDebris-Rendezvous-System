%function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)
%Finds the neighbors of element  @x   idxNBest that are not in  @x   idxClosed
%(line  it:expansion in Algorithm  alg:astar).
function [idxExpand]=graph_getExpandList(graphVector,idxNBest,idxClosed)

%Ensure that the vector  @x   idxBest is not included in the list of neighbors
%(i.e., avoid self-loop edges in the graph).

% Find index in graphVector
currentElement = graphVector(idxNBest).neighbors;

% find the neighbors
currentNeighbors = currentElement(:);

% Condition 1: find neighbors of element idxNBest is NOT in idxClosed
notInidxClosed = ~ismember(currentNeighbors, idxClosed);

% Condition 2: Array indicating whether each element in currentNeighbors is equal to the idxNBest node
duplicateElement = currentNeighbors ~= idxNBest;

% get ride of Conditions in idxExpand
idxExpand = currentNeighbors(notInidxClosed & duplicateElement);

end