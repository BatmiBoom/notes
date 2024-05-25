# Breadth First Search (BFS)

Is an algorithm for traversing or searching tree or graph data structures. It starts at the tree root (or some arbitrary node of a graph), and explores all of the neighbor nodes at the present depth before moving on to the nodes at the next depth level.

```python
sorted_set = sorted(unsorted_set)
```

Complete the breadth_first_search method on the Graph class, and take note that we're using unique strings instead of integers for our vertexes here.

```python
class Graph:
    def breadth_first_search(self, v):
        visited = []
        to_visit = []

        to_visit.append(v)

        while len(to_visit) > 0:
            vertex = to_visit.pop(0)
            visited.append(vertex)

            for sn in sorted(self.graph[vertex]):
                if sn not in visited and sn not in to_visit:
                    to_visit.append(sn)

        return visited

```
