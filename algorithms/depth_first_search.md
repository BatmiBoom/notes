# Depth First Search (DFS)

Depth-first search (DFS) is an algorithm for traversing or searching tree or graph data structures. The algorithm starts at the root node (selecting some arbitrary node as the root node in the case of a graph) and explores as far as possible along each branch before backtracking.

```python
class Graph:
    def depth_first_search(self, start_vertex):
        visited = []
        self.depth_first_search_r(visited, start_vertex)

        return visited

    def depth_first_search_r(self, visited, current_vertex):
        visited.append(current_vertex)
        for sn in sorted(self.graph[current_vertex]):
            if sn not in visited:
                self.depth_first_search_r(visited, sn)
```
