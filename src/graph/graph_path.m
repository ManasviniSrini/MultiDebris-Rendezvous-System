%function [xPath]=graph_path(graphVector,idxStart,idxGoal)
%This function follows the backpointers from the node with index  @x   idxGoal in
% @x   graphVector to the one with index  @x   idxStart node, and returns the 
%coordinates (not indexes) of the sequence of traversed elements.
function [xPath]=graph_path(graphVector,idxStart,idxGoal)

% initialize variables
xPath = graphVector(idxGoal).x;
idxbackpointer = graphVector(idxGoal).backpointer;

% check backpointer is not the start index, get coords, and add to xPath
while idxbackpointer ~= idxStart
    % get coordinates of backpointer
    coordBackPointer = graphVector(idxbackpointer).x;

    % concatenate to xPath
    xPath = [xPath coordBackPointer];

    % Update backpointer
    idxbackpointer = graphVector(idxbackpointer).backpointer;
end

% Add the start index to path, flip the traversal to get start to goal
xPath = fliplr([xPath graphVector(idxStart).x]);
end
