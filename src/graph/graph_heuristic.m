%function [hVal]=graph_heuristic(graphVector,idxX,idxGoal)
%Computes the heuristic  @x   h given by the Euclidean distance between the nodes
%with indexes  @x   idxX and  @x   idxGoal.
function [hVal]=graph_heuristic(graphVector,idxX,idxGoal)

% Extract the coordinates of the current and goal node
currentCoords = graphVector(idxX).x;
goalCoords = graphVector(idxGoal).x;

% Calculate the Euclidean distance b/w the 2 nodes
dispX = currentCoords(1,1) - goalCoords(1,1);
dispY = currentCoords(2,1) - goalCoords(2,1);

hVal = sqrt(dispX^2 + dispY^2);

end
