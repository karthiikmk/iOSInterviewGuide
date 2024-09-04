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
 - minimum cost spanning tree
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

    init(data: T) {
        self.data = data
    }

    var description: String {
        return "\(data)"
    }
}

struct Edge<T: Hashable>: Hashable, Comparable {

    var source: Vertex<T>
    var destination: Vertex<T>
    var weight: Double?

    static func < (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.weight ?? 0 < rhs.weight ?? 0
    }
}

class Graph<T: Hashable> {

    /// - NOTE: Set is used to store edges
    /// For undirected graph, there would be chance of duplication. in order to avoid set ds choosen.
    var adjacencyList: [Vertex<T>: Set<Edge<T>>] = [:]

    func addVertex(_ data: T) -> Vertex<T> {
        let vertex = Vertex(data: data)
        if adjacencyList[vertex] == nil {
            adjacencyList[vertex] = []
        }
        return vertex
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

    /// Level order traversal.
    /// Computing the shortest path between a source node and each of the other nodes (only for unweighted graphs).
    /// Calculating the minimum spanning tree/) on an unweighted graph.
    /// returns: They way the tree was spanned.
    func bfs(for vertex: Vertex<T>) -> [Vertex<T>] {

        var visited = Set<Vertex<T>>()
        var queue = [Vertex<T>]()
        var result = [Vertex<T>]()

        visited.insert(vertex)
        queue.append(vertex)

        while !queue.isEmpty {
            let currentVertex = queue.removeFirst()
            result.append(currentVertex)
            let neighbours = adjacencyList[currentVertex] ?? []
            for edge in neighbours where !visited.contains(edge.destination) {
                visited.insert(edge.destination)
                queue.append(edge.destination)
            }
        }
        return result
    }

    /// - NOTE: Graph must be connected, but no cycle. basically BFS
    /// Edges count must be = Total number of vertex - 1
    func minumumSpanning(for vertex: Vertex<T>) {

        var visited = Set<Vertex<T>>()
        var queue = [Vertex<T>]()

        visited.insert(vertex)
        queue.append(vertex)

        while !queue.isEmpty {
            let currentVertex = queue.removeFirst()
            let neighbours = adjacencyList[currentVertex] ?? []
            for edge in neighbours {
                /// IMP: Sinde already visted, no need to keep it as neighbours
                if visited.contains(edge.destination) {
                    var neighbours = adjacencyList[currentVertex] ?? []
                    for neighbour in neighbours where neighbour.destination == edge.destination {
                        neighbours.remove(neighbour)
                        adjacencyList[currentVertex] = neighbours
                    }
                } else {
                    visited.insert(edge.destination)
                    queue.append(edge.destination)
                }
            }
        }
    }

    /// Depth order traversal == Binary Tree Pre-order traversal.
    /// Finding connected components of a sparse graph
    /// Topological sorting of nodes in a graph
    func dfs(for vertex: Vertex<T>) -> [Vertex<T>] {
        var result = [Vertex<T>]()
        var visited = Set<Vertex<T>>()

        // Recursive operation
        func dfs(from vertex: Vertex<T>) {
            visited.insert(vertex)
            result.append(vertex)
            let neighbours = adjacencyList[vertex] ?? []
            for edge in neighbours where !visited.contains(edge.destination) {
                dfs(from: edge.destination)
            }
        }
        dfs(from: vertex)
        return result
    }
}

// MARK: - Helpers
extension Graph {

    var vertices: [Vertex<T>] {
        Array(adjacencyList.keys)
    }

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
        guard let edges = adjacencyList[source] else { // 1
            return nil
        }
        for edge in edges { // 2
            if edge.destination == destination { // 3
                return edge.weight
            }
        }
        return nil // 4
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
