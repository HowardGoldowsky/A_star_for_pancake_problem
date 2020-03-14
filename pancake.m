% Pancake Problem Main Program

function success_path = pancake(numPancakes, varargin)

if nargin == 2
    problem = A_star(numPancakes, varargin{1});
else
    problem = A_star(numPancakes);                                              % init a problem object as type A_star with numPancakes number of pancakes.
end

while ~isempty(problem.queue) && ~isequal(problem.goal,problem.queue(1).state)  % while fronteir queue is not empty and goal state has not been reached                 
        
    problem = problem.search;                                                   % recursive search based on A_star algorithm
     
end
      
success_path = problem.queue(1).path;                                           % display the success path
if(iscell(success_path))
    celldisp(success_path);
    tmpStr = sprintf('Cost = %d',problem.queue(1).path_cost);
    disp(tmpStr);
else
    disp('root node equals goal state');
    disp(success_path);
end