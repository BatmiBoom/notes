# Graphs

Is an abstract data type that represents a set of vertices and the edges taht connect those vertices

```text
Vertices
| 0 | ------ | 1 | -----|
  |            |        |
  |            |      | 2 |
  |            |        |
  |     Edge   |        |
| 4 | -------| 3 |------|
```

For now, we'll use a matrix to represent the edges in a graph that connect each pair of vertices. For example, here's a matrix that represents the graph above

|   | 0 | 1 | 2 | 3 | 4 |
| - | - | - | - | - | - |
| 0 | F | T | F | F | T |
| 1 | T | F | T | T | T |
| 2 | F | T | F | T | F |
| 3 | F | T | T | F | T |
| 4 | T | T | F | T | F |

In python, we can ue a list of lists to represent this matrix:

```python
[
  [False, True, False, False, True],
  [True, False, True, True, True],
  [False, True, False, True, False],
  [False, True, True, False, True],
  [True, True, False, True, False]
]
```

In any cell where a True is found, the corresponding vertices are connected by an edge

## PROPERTIES

- Graphs can have between 0 and n vertices, there's no maximum
- Graphs can have between 0 and n(n - 1)/2 edges, where n is the number of vertices
- Vertices don't need to be connected at all (they can have no edges). That said, they may be unreachable if this is the case
- An edge connects exactly 2 vertices, and there can't be 2 edges between the same two vertices.
- Some graphs (called weighted graphs) assign a "cost" to each edge. For example, if a graph represented a geographical map of cities in the real world, the cities would be vertices and the edges would be roads. The weight on the roads could be their lengths. We won't be using weighted graphs for now.

## GRAPH - ADD

When an algorithm traverses a graph, it typically moves across the edges. For example, the traveling salesman problem is best represented using a graph data structure.

### Adjancency Matrix

Is a square matrix used to represent a finite graph. The elements of the matrix indicate whether pirs of vertices re adjacent or not in the graph. `true` indicates the precense of an edge, `false` represents the absence

```python
class Graph:
    def __init__(self, num_vertices: int) -> None:
        self.num_vertices = num_vertices
        self.graph = []
        for i in range(num_vertices):
            self.graph.append([])
            for j in range(num_vertices):
                self.graph[i].append(False)


    def add_edge(self, u:int, v:int) -> None:
        self.graph[u][v] = True
        self.graph[v][u] = True


    def edge_exists(self, u:int, v:int) -> bool :
        if u < 0 or u >= len(self.graph):
            return False
        if len(self.graph) == 0:
            return False
        row1 = self.graph[0]
        if v < 0 or v >= len(row1):
            return False
        return self.graph[u][v]
```

### Adjacency List

Stores a list of vertices for each vertex that indicates where the connectios are.

```python
# {
#     "0": [1, 4],
#     "1": [0, 2, 3, 4],
#     "2": [1, 3],
#     "3": [1, 2, 4],
#     "4": [0, 1, 3]
# }

class Graph:
    def __init__(self) -> None:
        self.graph = {}

    def add_edge(self, u , v) -> None:
        if u not in self.graph:
            self.graph[u] = []
        if v not in self.graph:
            self.graph[v] = []

        self.graph[u].append(v)
        self.graph[v].append(u)
```

## GRAPH - Adjacent Nodes

It takes a node (an integer) and returns a list of all the adjacent nodes in order

```python
class Graph:
    def adjacent_nodes(self, node: int) -> list[int]:
        return self.graph[node]
```

## GRAPH - Unconnected Vertices

It should return a list of vertices (integers) that have no connections. A vertex with no edges will have an empty set as its value in the self.graph dictionary.

```python
class Graph:
    def unconnected_vertices(self) -> list[int]:
        return list(filter(lambda x: len(self.graph[x]) == False, self.graph))
```

## GRAPH - Breadth First Search (BFS) & Depth First Search (DFS)

Is an algorithm for traversing or searching tree or graph data structures. It starts at the tree root (or some arbitrary node of a graph), and explores all of the neighbor nodes at the present depth before moving on to the nodes at the next depth level.

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

So, should you use DFS or BFS when traversing a graph? Well, it depends. Let's look at some rules of thumb we can use to help make the decision.

- Is the solution close to the root?

  - If you have a good reason to believe the vertex you're looking for is close to the root (where you plan to start searching) then BFS should be faster.

- Is the graph extremely wide, but not very deep (from the root)?

  - Imagine a tree with 10 vertices on the first level. Each of those ten vertexes point to another ten vertexes. The number of vertices at each level would be:
    ```text
    level 0: 1
    level 1: 10
    level 2: 100
    level 3: 1000
    level 4: 10000
    ```
    - Because BFS stores entire horizontal levels in memory, you may not have enough memory on your machine to execute the search.

- Is the search space infinite?

  - In some searches, the graph has infinite size. For example, imagine a simulation of a game of chess.
    The first level of the graph would be all the possible current moves, the next level would be all the possible 2nd moves, and this could go on forever, especially when you consider that there are loops within the game. For example, each player could just move their queens back and forth forever.
    In these cases, true DFS is practically impossible, you would need to either use BFS, another algorithm, or put a limit on how far your DFS algorithm can search before returning.

- Are you trying to reach an "end"?

  - Think of a maze simulator. You want your algorithm to explore the end of a path before exiting to know if it has hit a dead end. DFS will typically find a solution much more quickly than BFS for this kind of exhaustive search.

## GRAPH - Shortest Path

Rather than traversing the entire graph, we need to find the shortest path between two points in out graph using BFS.

```python
    # start : cairo, end : san francisco
    def bfs_path(self, start, end):
        visited = []
        to_visit = [start] # [cairo]
        path = {start: None} # {"cairo": None}
        while to_visit:
            current_vertex = to_visit.pop(0) # San Fracisco
            visited.append(current_vertex) 
            # [cairo, new york, madrid, kyiv, buenos aires, london, tokyo, san francisco]
            if current_vertex == end: # TRUE
                # current_vertex = san_francico
                path_list = []
                while current_vertex is not None:
                    path_list.append(current_vertex) 
                    """
                    path_list:
                    [san francisco]
                    [san francisco, kyiv]
                    [san francisco, kyiv, cairo]
                    """
                    current_vertex = path[current_vertex] # kyiv -> cairo -> None
                path_list.reverse()
                return path_list

            sorted_neighbors = sorted(self.graph[current_vertex]) # {'new york', 'buenos aires'}
            for neighbor in sorted_neighbors:
                if neighbor not in visited and neighbor not in to_visit:
                    to_visit.append(neighbor)
                    path[neighbor] = current_vertex

            """
            to_visit : ['new york','madrid','kyiv']
                       ['madrid', 'kyiv', 'buenos aires', 'london', 'tokyo']
                       ['kyiv', 'buenos aires', 'london', 'tokyo']
                       ['buenos aires', 'london', 'tokyo', 'san fransico']
                       ['london', 'tokyo', 'san francisco']
                       ['tokyo', 'san francisco', 'dubai']
                       ['san fransico', 'dubai']
                       ['dubai']

            path : {'kiyv': cairo, madrid: cairo, new_york: cairo}
                   {'london': new_york, buenos_aires: new_york, tokyo: new_york}
                   {'london': new_york, buenos_aires: new_york, tokyo: new_york}
                   {'san_fransico': kyiv}
                   {'dubai: london'}

                    {
                        'kiyv': cairo, 
                        'madrid': cairo, 
                        'new_york': cairo,
                        'london': new_york, 
                        'buenos_aires': new_york, 
                        'tokyo': new_york,
                        'san_fransico': kyiv,
                        'dubai': london
                    }
            """
       return None

{
    'New York': {'London', 'Buenos Aires', 'Cairo', 'Tokyo'}, 
    'London': {'Dubai', 'New York', 'Madrid'}, 
    'Cairo': {'Kyiv', 'Madrid', 'New York'}, 
    'Tokyo': {'New York', 'Buenos Aires'}, 
    'Dubai': {'London'}, 
    'Kyiv': {'San Francisco', 'Cairo'}, 
    'Madrid': {'London', 'Cairo'}, 
    'Buenos Aires': {'New York', 'Tokyo'}, 
    'San Francisco': {'Kyiv'}
}

```

## Complete Graph

A complete graph is a graph in which every pair of vertices is connected by an edge

To know how many edges a graph can have, we can apply this formulae

`edges = (vertices * (vertices - 1)) / 2`
