//
//  Prims.swift
//  Algorithms
//
//  Created by Karthik on 17/03/24.
//

import Foundation

/// We gonna build a new graph itself
/// We need a graph, from that we gonna build a new graph which will be give mst
class Prims<T: Hashable> {

    let graph: Graph<T>

    init(graph: Graph<T>) {
        self.graph = graph
    }

    /// - NOTE: Merly looks like bfs Leverl-Order traversal
    /// Instead of returning results in some collection for, here we are creating new graph and returning.
    func findMinimumSpanningTree(for vertex: Vertex<T>? = nil) -> Double {
        
        guard let root = vertex ?? graph.vertices.first else { return .zero }
        var visited = Set<Vertex<T>>()
        let mst = Graph<T>() // *** Constructing new graph
        let queue = PriorityQueue<Edge<T>>(.min) // important

        mst.addVertex(root)
        visited.insert(root)
        if let edges = graph.adjacencyList[root] {
            edges.forEach { queue.enqueue($0) }
        }
        
        while !queue.isEmpty {
            /// BaseCondition
            if let edge = queue.dequeue(), !visited.contains(edge.destination) {
                visited.insert(edge.destination)
                // Ensure both source and destination vertices are in the MST
                mst.addVertex(edge.source)
                mst.addVertex(edge.destination)
                mst.addEdge(edge) // ***
                ///
                let neighbours = graph.adjacencyList[edge.destination] ?? []
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
        print("MST: \(mst)")
        return cost
    }
}

//let graph = Graph<String>()
//let a: Vertex<String> = .init(value: "A")
//let b: Vertex<String> = .init(value: "B")
//let c: Vertex<String> = .init(value: "C")
//let d: Vertex<String> = .init(value: "D")
//let e: Vertex<String> = .init(value: "E")
//
//graph.addVertex(a)
//graph.addVertex(b)
//graph.addVertex(c)
//graph.addVertex(d)
//graph.addVertex(e)
//
//graph.addEdge(.init(source: a, destination: b, weight: 4))
//graph.addEdge(.init(source: a, destination: c, weight: 2))
//graph.addEdge(.init(source: b, destination: d, weight: 5))
//graph.addEdge(.init(source: c, destination: d, weight: 1))
//graph.addEdge(.init(source: d, destination: e, weight: 3))
//
//// print(graph)
//// graph.dfs(of: one)
//// graph.mst()
//let prims = Prims<String>(graph: graph)
//prims.mst(a)
//print("End")
