%function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)
%This function expands the vertex with index  @x   idxX (which is a neighbor of
%the one with index  @x   idxNBest) and returns the updated versions of  @x  
%graphVector and  @x   pqOpen.
function [graphVector,pqOpen]=graph_expandElement(graphVector,idxNBest,idxX,idxGoal,pqOpen)

%This function corresponds to lines  it:expansion-start-- it:expansion-end in
%Algorithm  alg:astar.
% check if index in pqOpen already with priority*
idxinpqOpen = priority_isMember(pqOpen, idxX);

% Cost Move from idxX to idxNBest
neighbors = graphVector(idxNBest).neighbors;
idxNeighbors = neighbors == idxX;
cost = graphVector(idxNBest).neighborsCost(idxNeighbors);

% Find cost of moving from vertex idxX to idxNBest & neighbors
if ~idxinpqOpen
    % Set backpointer cost g(x) = g(nbest) + c(nbest,x)
    graphVector(idxX).g = graphVector(idxNBest).g + cost;

    % set backpointer of x to nbest 
    graphVector(idxX).backpointer = idxNBest;

    % Compute the heuristic h(x)
    heuristic = graph_heuristic(graphVector, idxX, idxGoal);
    
    % Add x to O with value f(x) = g(x) + h(x)
    gofx = graphVector(idxX).g;
    fofx = gofx + heuristic;

    % Update pqOpen
    pqOpen = priority_insert(pqOpen, idxX, fofx);

% if g(x) > g(nbest) + c(nbest,x)
elseif graphVector(idxX).g > graphVector(idxNBest).g + cost

    gofx = graphVector(idxX).g;
    gnBest = graphVector(idxNBest).g;

    % update backpointer cost g(x) = g(nbest) + c(nbest,x)
    gofx = gnBest + cost;

    % Update the backpointer cost g(x) = g(nbest) + c(nbest,x)
    graphVector(idxX).backpointer = idxNBest;
end
end