//
//  Graph.swift
//  Algorithms
//
//  Created by Karthik on 16/03/24.
//

import Foundation

/*

 linear datastructrue - array, linkedlist, stack, queue
 tree - non linear datastructure (hierarchal datastructure)
 Graphs are fundamental, non-linear data structures that consist of a collection of vertices (nodes) and edges connecting these vertices.

 Vertex (Node): A fundamental unit of which graphs are formed. A graph is said to contain vertices.
 Edge (Link): A connection between two vertices in a graph. The edge may have a direction, distinguishing between directed and undirected graphs.
 Graph (G): Represented as a pair G = (V, E), where V is a set of vertices and E is a set of edges connecting those vertices.

 UnDirected: Social netowrk is an example for undirected graph
 Directed: web pages is an example for directed graph
 Weighted: google maps ( road with kms )

 Types of Graph:
 Undirected Graph: A graph where edges have no direction. The edge (u, v) is identical to (v, u).
 Directed Graph (Digraph): A graph where each edge has a direction associated with it, going from one vertex to another.
 Simple Digraph: A directed graph with no self-loops (edges that connect a vertex to itself) or parallel edges (multiple edges between the same pair of vertices).
 Non-Connected Graph: A graph that consists of multiple disconnected components.
 Strongly Connected Graph: In a directed graph, a graph is strongly connected if there is a path from any vertex to every other vertex.
 Directed Acyclic Graph (DAG): A directed graph with no cycles, meaning it's impossible to start at any vertex and follow a continuous path that eventually loops back to the starting vertex.
 Topological Ordering: An ordering of the vertices in a DAG so that for every directed edge from vertex u to vertex v, u comes before v in the ordering.

 Graph Traversal Methods
 Traversal methods are algorithms to visit all the vertices of a graph in a systematic manner.

 Breadth-First Search (BFS): 
 This method starts at a specific vertex and explores its neighbors before moving on to the neighbors of those vertices, effectively traversing the graph in level-wise order. It uses a queue to keep track of the vertices to visit next. The resulting tree is called the BFS spanning tree.
 Depth-First Search (DFS):
 This method explores as far as possible along each branch before backtracking, essentially visiting the depth of each vertex. It uses a stack (either explicitly or through recursion) to keep track of the vertices. The traversal can resemble the pre-order traversal of a binary tree.
 This method starts at a speicif vertex and deeps dive into the each path before switching to the adjacent neighbours

 Traversal methods - BFS, DFS
 spanning tree - vertex should be connected and should not have any cycle
 minimum cost spanning tree
 prince and krushkal algo helps to find minimum cost spanning tree.

 Spanning Tree: Constructing/Traversing a graph to form a tree. The resulting tree would be called as spanning tree.
 It should follow certain rules. that is
 1. Vertex/Nodes should be connected,
 2. It should not create any cycles, then that will be called as graph.
*/

enum EdgeType {
    case directed, undirected
}

/// - NOTE: As we are using Dicationry as Adjacent list, Vertext should be hashable.
struct Vertex<T: Hashable>: Hashable, CustomStringConvertible {

    let data: T
    init(_ data: T) {
        self.data = data
    }
    var description: String {
        return "\(data)"
    }
}

/// Struct is by default hashable
struct Edge<T: Hashable>: Hashable, Comparable {

    var source: Vertex<T>
    var destination: Vertex<T>
    var weight: Double?

    static func < (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.weight ?? 0 < rhs.weight ?? 0
    }
}

class Graph<T: Hashable> {

    /// - NOTE: Adjacency refers to the relationship between two vertices (nodes) in a graph.
    /// Set is used to store edges
    /// For undirected graph, there would be chance of duplication. in order to avoid set ds choosen.
    var adjacencyList: [Vertex<T>: Set<Edge<T>>] = [:]

    func addVertex(_ vertex: Vertex<T>) {
        if adjacencyList[vertex] == nil {
            adjacencyList[vertex] = [] // Initially empty edges
        }
    }

    @discardableResult
    func addVertex(value data: T) -> Vertex<T> {
        let vertex = Vertex(data)
        addVertex(vertex)
        return vertex
    }

    func addEdge(_ edge: Edge<T>) {
        addEdge(
            from: edge.source,
            to: edge.destination,
            weight: edge.weight,
            type: .undirected
        )
    }

    func addEdge(
        from source: Vertex<T>,
        to destination: Vertex<T>,
        weight: Double? = nil,
        type: EdgeType = .undirected
    ) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }
}

// MARK: - Traversal
extension Graph {

    /// Depth order traversal == Binary Tree Pre-order traversal.
    /// Finding connected components of a sparse graph
    /// Topological sorting of nodes in a graph
    func dfs(for vertex: Vertex<T>) -> [Vertex<T>] {

        var result = [Vertex<T>]()
        var visteds = Set<Vertex<T>>()
        let stack = Stack<Vertex<T>>() // Stacking vertex
        stack.push(vertex)

        while !stack.isEmpty {
            /// To avoid duplication visit, created a set
            if let vertex = stack.pop() {
                visteds.insert(vertex)
                result.append(vertex)
                let edges = adjacencyList[vertex] ?? []
                for edge in edges where !visteds.contains(edge.destination) {
                    stack.push(edge.destination)
                }
            }
        }
        return result
    }

    /// Level order traversal.
    /// Computing the shortest path between a source node and each of the other nodes (only for unweighted graphs).
    /// Calculating the minimum spanning tree/) on an unweighted graph.
    /// returns: They way the tree was spanned.
    func bfs(for vertex: Vertex<T>) -> [Vertex<T>] {

        var result = [Vertex<T>]()
        var visiteds = Set<Vertex<T>>()
        var queue = Queue<Vertex<T>>() // Queueing vertex
        queue.enqeue(vertex)

        while !queue.isEmpty {
            if let vertex = queue.dequeue() {
                visiteds.insert(vertex)
                result.append(vertex)
                let edges = adjacencyList[vertex] ?? []
                for edge in edges where !visiteds.contains(edge.destination) {
                    queue.enqeue(edge.destination)
                }
            }
        }
        return result
    }

    /// NOTE: Minimu spanning
    /// Tree should be connected (should touch all the vertex)
    /// No cycle between vertex
    /// With that criteria, find the minimum path
    func mst(for vertex: Vertex<T>) -> [Edge<T>] {
        ///  as we are finding path, lets work with edges, we always prefer min edges
        var visiteds = Set<Vertex<T>>()
        var result = [Edge<T>]()
        let queue = PriorityQueue<Edge<T>>(.min) // important

        /// Collecting all the edges of the start vertex using min queue.
        visiteds.insert(vertex)
        if let edges = adjacencyList[vertex] {
            edges.forEach { queue.enqueue($0) }
        }
        ///
        while !queue.isEmpty {
            if let edge = queue.dequeue() {
                // If the destination vertex is already visited, skip it
                if visiteds.contains(edge.destination) { continue }
                // Otherwise, add the edge to the result and mark the destination as visited
                visiteds.insert(edge.destination)
                result.append(edge)
                // Add all edges of the destination vertex to the priority queue
                if let neighbours = adjacencyList[edge.destination] {
                    for neighbour in neighbours where !visiteds.contains(neighbour.destination) {
                        queue.enqueue(neighbour)
                    }
                }
            }
        }
        return result
    }
}

// MARK: - Helpers
extension Graph {

    var vertices: [Vertex<T>] { Array(adjacencyList.keys) }

    private func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyList[source]?.insert(edge)
    }

    private func addUndirectedEdge(vertices: (Vertex<T>, Vertex<T>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }

    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        guard let edges = adjacencyList[source] else { return nil }
        for edge in edges where edge.destination == destination {
            return edge.weight
        }
        return nil
    }
}

extension Graph: CustomStringConvertible {

    var description: String {
        var result: String = ""
        for (vertex, edges) in adjacencyList {
            var edgeString = ""
            for edge in edges {
                edgeString += "\(edge.destination) "
            }
            result += "\(vertex) ---> [ \(edgeString) ] \n"
        }
        return result
    }
}
