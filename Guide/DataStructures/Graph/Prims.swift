//
//  Prims.swift
//  Algorithms
//
//  Created by Karthik on 17/03/24.
//

import Foundation

class Prims<T: Hashable> {

    let graph: Graph<T>

    init(graph: Graph<T>) {
        self.graph = graph
    }

    func edges(for vertex: Vertex<T>) -> Set<Edge<T>> {
        graph.adjacencyList[vertex] ?? []
    }

    /// - NOTE: Merly looks like bfs Leverl-Order traversal
    /// Instead of returning results in some collection for, here we are creating new graph and returning.
    func findMinimumSpanningTree(for vertex: Vertex<T>? = nil) -> (spanningTree: Graph<T>, cost: Double) {

        /// BaseCondition
        guard let startVertex = vertex ?? graph.vertices.first else {
            return (Graph<T>(), .zero)
        }
        var visited = Set<Vertex<T>>()
        let mst = Graph<T>() // constructing new graph
        let queue = PriorityQueue<Edge<T>>(.min) // important

        visited.insert(startVertex)
        mst.addVertex(startVertex)
        // Add edges from starting vertex to priority queue
        let neighbours = edges(for: startVertex)
        for edge in neighbours {
            queue.enqueue(edge)
        }

        while !queue.isEmpty {
            /// BaseCondition
            if let edge = queue.dequeue() {
                // Skip edges if destination is already visited
                if visited.contains(edge.destination) { continue }
                ///
                visited.insert(edge.destination)
                // Ensure both source and destination vertices are in the MST
                mst.addVertex(edge.source)
                mst.addVertex(edge.destination)
                mst.addEdge(edge) // This is very important.
                ///
                let neighbours = edges(for: edge.destination)
                for edge in neighbours where !visited.contains(edge.destination) {
                    queue.enqueue(edge)
                }
            }
        }

        /// Taking the newly constructed graph. 
        var cost: Double = .zero
        for (_, edges) in mst.adjacencyList {
            for edge in edges {
                cost += edge.weight ?? .zero
            }
        }

        return (mst, cost)
    }
}
