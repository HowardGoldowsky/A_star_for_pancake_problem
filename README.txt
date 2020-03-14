# A_star_for_pancake_problem
Solves the pancake problem using the A* search algorithm.

Problem Definition
We can define the Pancake problem as a recursive search problem with the following definitions:
• Each node in the search tree equals a different state, a different ordering of pancakes.
• The root node/state = random initial ordering of pancakes (or an ordering of the user’s
choice).
• Backward-Cost function = how many flips required to get from the root node to an open
node.
• Heuristic function = Gap heuristic, based on Malte Helmert’s paper, “Landmark Heuristics
for the Pancake Problem.” The heuristic value is the number of stack positions for which the pancake at that position is not of adjacent size to the pancake below.
