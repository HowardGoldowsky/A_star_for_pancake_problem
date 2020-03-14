% This code defines the Node class

classdef Node
    
    properties
        
        state          % node's pancake order (numPancakes+1 corresponds to the pan underneath and never changes position)
        action         % under which pancake to place spatula
        path           % path to this node from start node (cell array of states)
        path_cost      % cost (distance) to this node from start node
        heuristic      % heuristic cost to goal node (an underestimate of the actual cost)
        
    end % properties
        
    methods
        
        function obj = Node(parent,action)  % Constructor
            
            if nargin == 0                  % If no arguments then init to empty sets                       
                
                obj.state = [];   
                obj.action = [];
                obj.path = {};
                obj.path_cost = 0;
                obj.heuristic = 0;
                
            else
           
                obj.state = [flip(parent.state(1:action));parent.state(action+1:end)];  % flip parent where the spatula comes in (action = pancake under which to flip)
                obj.action = action;
                obj.path = [parent.path;{obj.state}];                                   % append node's state to parent's path
                obj.path_cost = parent.path_cost + 1;                                   % distance/cost between all states is the same
                obj.heuristic = gap_heuristic(obj);                                     % calculate gap heuristic
                
            end
            
        end % function Node(obj)
        
        function heuristic = gap_heuristic(obj) 
            
            % Gap Heuristic, based on Malte Helmert's paper "Landmark 
            % Heuristics for the Pancake Problem." The heuristic value is the
            % number of stack positions for which the pancake at that position
            % is not of adjacent size to the pancake below.
        
            heuristic = sum( abs(diff(obj.state)) > 1 );
            
        end % function calculate_heuristic()
        
    end % methods
    
end % classdef
    

