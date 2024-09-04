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
    func findMinimumSpanningTree(for vertex: Vertex<T>? = nil) -> (spanningTree: Graph<T>, cost: Double) {

        /// BaseCondition
        guard let startVertex = vertex ?? graph.vertices.first else {
            return (Graph<T>(), .zero)
        }
        var visited = Set<Vertex<T>>()
        let mst = Graph<T>()
        let priorityQueue = PriorityQueue<Edge<T>>(isMaxHeap: false)

        visited.insert(startVertex)

        // Add edges from starting vertex to priority queue
        let neighbours = edges(for: startVertex)
        for edge in neighbours {
            priorityQueue.enqueue(edge)
        }

        while !priorityQueue.isEmpty {
            /// BaseCondition
            guard let edge = priorityQueue.dequeue() else { break }

            // Skip edges if destination is already visited
            if !visited.contains(edge.destination) {
                ///
                visited.insert(edge.destination)
                mst.addEdge(from: edge.source, to: edge.destination, weight: edge.weight)

                let neighbours = edges(for: edge.destination)
                for edge in neighbours {
                    priorityQueue.enqueue(edge)
                }
            }
        }

        var cost: Double = .zero
        for (_, edges) in mst.adjacencyList {
            for edge in edges {
                cost += edge.weight ?? .zero
            }
        }

        return (mst, cost)
    }
}
