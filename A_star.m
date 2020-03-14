% Class definition for the A_star_Search problem

classdef A_star
    
    properties
     
        numPancakes     % number of pancakes (int)
        goal            % objective state, a list of [numPancakes] pancakes in order
    	root_node       % starting node of problem 
        queue           % frontier queue
        closed          % set of previously visited nodes
        
    end % properties
    
    methods
    
        function obj = A_star(numPancakes, varargin)                        % Constructor for the problem
            
            obj.numPancakes = numPancakes;
            obj.goal = [1:numPancakes,numPancakes+1]';                      % goal includes the pan, the largest layer, at the bottom
            
            obj.root_node = Node;                                           % call constructor for a generic node
            if nargin == 2
                obj.root_node.state = [varargin{1},numPancakes+1]';
            else
                obj.root_node.state = [randperm(numPancakes),numPancakes+1]';   % random start state; always put the pan, the largest layer, at the bottom   
            end
            obj.root_node.path = obj.root_node.state;                       % including starting state as part of the overall path
            
            obj.queue = obj.root_node;                                      % init a one-element queue (object array) consisting of the root node.
            obj.closed = {};                                                % init set of previously visited nodes
            
        end % function A_star
        
        function obj = search(obj)                                    
            
            % A* algorithm, aka Branch-and-bound search algorithm with dynamic programming and underestimates (heuristics),
            % Winston, Patrick Henrey, Artificial Intelligence, Second Edition, Addison-Wesley, 1984

            tmp_queue = obj.queue;                                          % setup a temporary unsorted queue in which to work
            parent = obj.queue(1);
            obj.closed = [obj.closed; {parent.state}];                      % add parent to list of closed/visited states
            tmp_queue(1) = [];                                              % remove first element from the queue

            for flip_location = 2:obj.numPancakes                           % flipping the top pancake does nothing, so we begin by flipping the second one

                child_node = Node(parent, flip_location);                   % open a new child node, based on flip location

                if (cellfun(@isequal,{obj.closed},{child_node.state}))      % if child nodes/states are part of the closed set then ignore them
                    continue;
                end

                % If a child node reaches an existing node state on the queue, then keep only the node with the minimum path_cost + heuristic.
                % tmp_queue is already sorted, so we can ignore all matches except the first one.
                
                if (~isempty(tmp_queue))
                    
                    idx = find(cellfun(@isequal,{tmp_queue.state},repmat({child_node.state},1,numel(tmp_queue)))); % find similar node state

                    if (~isempty(idx))                                          % if there is a revisited node
                      
                        if (tmp_queue(idx(1)).path_cost > child_node.path_cost) % and the child node is a smaller cost to this point
                            
                            tmp_queue(idx(1)) = child_node;                     % then use the child_node with a lower cost
                            
                        end
                        
                    end
                    
                end

                tmp_queue = [tmp_queue,child_node];                             %#ok<AGROW> % add child to queue        

            end 

            % sort all open nodes in queue by [estimate = cost(node) + heuristic(node)] by smallest estimate
            
            [~, ind] = sort([tmp_queue.path_cost] + [tmp_queue.heuristic],'ascend');    
            obj.queue = tmp_queue(ind);

        end % function queue = A_star_search(queue)
         
    end % methods
    
end % class