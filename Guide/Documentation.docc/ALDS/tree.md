
# Tree 

| Data Structure     | Search      | Insertion   | Deletion    | Storage Complexity      |
|--------------------|-------------|-------------|-------------|-------------------------|
| Binary Tree        | O(n)        | O(n)        | O(n)        | O(n)                    |
| BST                | O(n)        | O(n)        | O(n)        | O(n)                    |
| AVL Tree           | O(log n)    | O(log n)    | O(log n)    | O(n) + O(log n)         |
| Red-Black Tree     | O(log n)    | O(log n)    | O(log n)    | O(n) + O(1)             |
| Heap               | O(n)        | O(log n)    | O(log n)    | O(n)                    |
| Graph (Adj List)   | O(V+E)      | O(1)        | O(E)        | O(V+E)                  |
| Graph (Adj Matrix) | O(V^2)      | O(1)        | O(1)        | O(V^2)                  |

- For BST, the time complexity can degrade to O(n) in the worst case (unbalanced tree)
- AVL Trees require additional space for storing balance information (height or balance factor) for each node.
- Red-Black Trees require an extra bit for the color of each node.
