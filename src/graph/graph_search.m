%function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)
%Implements the  @x   A* algorithm, as described by the pseudo-code in Algorithm 
%alg:astar.
function [xPath,graphVector]=graph_search(graphVector,idxStart,idxGoal)

% Set a maximum limit of iterations in the main  @x   A* loop on line 
%it:astar-main-loop of Algorithm  alg:astar. This will prevent the algorithm from
%remaining stuck on malformed graphs (e.g., graphs containing a node as a
%neighbor of itself), or if you make some mistake during development.

% Initialize 
pqOpen = priority_prepare();
goalRendezvous = false;

% Add idxStart to O
[pqOpen] = priority_insert(pqOpen,idxStart,0);

% Set cost
graphVector(idxStart).g = 0; 

% Set backpointer
graphVector(idxStart).backpointer = [];

% C is closed set initialize to empty array
closedC = [];

% Getmin value 
[pqOpen,idxNBest,cost] = priority_minExtract(pqOpen);

% Add it to the closed set
closedC = [closedC, idxNBest];


while ~isempty(idxNBest) && goalRendezvous ~= true

     % neighbors of idxNBest not in C
    idxNeighbors = graph_getExpandList(graphVector,idxNBest,closedC);

    % expand them to O
    nNeighbors = numel(idxNeighbors);
    
    if nNeighbors == 1
        [graphVector,pqOpen] = graph_expandElement(graphVector,idxNBest,idxNeighbors,idxGoal,pqOpen);
    else
        for iNeigh = 1:nNeighbors
            [graphVector,pqOpen] = graph_expandElement(graphVector,idxNBest,idxNeighbors(iNeigh),idxGoal,pqOpen);
        end
    end

    if priority_isMember(pqOpen,idxGoal)
        goalRendezvous = true; 
    end

    % redo
    % Get the min value
    [pqOpen,idxNBest,cost]=priority_minExtract(pqOpen);

    % Add it to C
    closedC=[closedC, idxNBest];
    
end
%graph
xPath = graph_path(graphVector,idxStart,idxGoal);

end

