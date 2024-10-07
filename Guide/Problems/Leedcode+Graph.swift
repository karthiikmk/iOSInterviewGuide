//
//  Leedcode+Graph.swift
//  Algorithms
//
//  Created by Karthik on 23/03/24.
//

import Foundation

/*
 16. Implement depth-first search (DFS) on a graph.
 17. Implement breadth-first search (BFS) on a graph.
 18. Check if a graph is connected.
    - A connected graph is one where all vertices are reachable from any other vertex.
 19. Check if a graph has cycle.
 20. Implement Prim's algorithm for minimum spanning tree. - done
 19. Implement Dijkstra's algorithm for shortest path.
 21. Implement Kruskal's algorithm for minimum spanning tree.
*/

extension LeetCode {

    func runGraph() {

        let one: Vertex<Int> = .init(value: 1)
        let two: Vertex<Int> = .init(value: 2)
        let three: Vertex<Int> = .init(value: 3)
        let four: Vertex<Int> = .init(value: 4)

        let graph = Graph<Int>()

//        graph.add(vertex: one)
//        graph.add(vertex: two)
//        graph.add(vertex: three)
//        graph.add(vertex: four)

        let oneToTwo: Edge<Int> = .init(source: one, desitination: two)
        graph.addEdge(oneToTwo)

        let oneToThree: Edge<Int> = .init(source: one, desitination: three)
        graph.addEdge(oneToThree)

        let twoToOne: Edge<Int> = .init(source: two, desitination: one)
        graph.addEdge(twoToOne)

        let twoToFour: Edge<Int> = .init(source: two, desitination: four)
        graph.addEdge(twoToFour)

        let threeToOne: Edge<Int> = .init(source: three, desitination: one)
        graph.addEdge(threeToOne)

        let threeToFour: Edge<Int> = .init(source: three, desitination: four)
        graph.addEdge(threeToFour)

        let fourToTwo: Edge<Int> = .init(source: four, desitination: two)
        graph.addEdge(fourToTwo)

        let fourToThree: Edge<Int> = .init(source: four, desitination: three)
        graph.addEdge(fourToThree)

        print(graph)

//        let dfsResult = graph.bfs(one)
//        print(dfsResult)
    }

    struct Vertex<T: Hashable>: Hashable, CustomStringConvertible {
        let value: T
        var description: String {
            return "\(value)"
        }
    }

    struct Edge<T: Hashable>: Hashable, Comparable {
        static func < (lhs: LeetCode.Edge<T>, rhs: LeetCode.Edge<T>) -> Bool {
            (lhs.weight ?? 0) < (rhs.weight ?? 0)
        }
        var source: Vertex<T>
        var desitination: Vertex<T>
        var weight: Double?
    }

    class Graph<T: Hashable>: CustomStringConvertible {

        var adjacentList = [Vertex<T>: Set<Edge<T>>]()
        var vertices: [Vertex<T>] { Array(adjacentList.keys) }

        func add(vertex: Vertex<T>) {
            if adjacentList[vertex] == nil {
                adjacentList[vertex] = []
            }
        }

        /// NOTE: Make sure source and destination vertext already added to the list
        /// Failing which can't map the edges to the vertex
        func addEdge(_ edge: Edge<T>) {
            adjacentList[edge.source]?.insert(edge)
        }

        func addEdge(source: Vertex<T>, destination: Vertex<T>, weight: Double? = nil) {
            let edge: Edge<T> = .init(source: source, desitination: destination, weight: weight)
            adjacentList[source]?.insert(edge)
        }

        func dfs(_ vertex: Vertex<T>) -> [T] {
            var result = [T]()
            var visiteds = Set<Vertex<T>>()
            let stack = Stack<Vertex<T>>()
            stack.push(vertex)

            while !stack.isEmpty {
                if let vertex = stack.pop(), !visiteds.contains(vertex) {
                    visiteds.insert(vertex)
                    result.append(vertex.value)
                    // Neighbours
                    if let edges = adjacentList[vertex] {
                        for edge in edges where !visiteds.contains(edge.desitination) {
                            stack.push(edge.desitination)
                        }
                    }
                }
            }
            return result
        }

        func bfs(_ vertex: Vertex<T>) -> [T] {
            var result = [T]()
            var visiteds = Set<Vertex<T>>()
            var queue = [Vertex<T>]()
            queue.append(vertex)

            while !queue.isEmpty {
                let vertex = queue.removeFirst()
                if !visiteds.contains(vertex) {
                    visiteds.insert(vertex)
                    result.append(vertex.value)
                    if let edges = adjacentList[vertex] {
                        for edge in edges where !visiteds.contains(edge.desitination) {
                            queue.append(edge.desitination)
                        }
                    }
                }
            }
            return result
        }

        /// NOTE: Need minimum priorty queue
        /// As we are finding minimum spanning, we should work with edges and its weights
        func mst(_ vertex: Vertex<T>) -> [Edge<T>] {
            var result = [Edge<T>]()
            var visiteds = Set<Vertex<T>>()
            let queue = PriorityQueue<Edge<T>>(.min) // Important

            visiteds.insert(vertex)
            let edges = adjacentList[vertex] ?? []
            edges.forEach { queue.enqueue($0) } // Enqueueing all the edges first.

            while !queue.isEmpty {
                if let edge = queue.dequeue() {
                    ///
                    if visiteds.contains(edge.desitination) { continue }
                    result.append(edge)
                    visiteds.insert(edge.desitination)
                    ///
                    let edges = adjacentList[edge.desitination] ?? []
                    for edge in edges where !visiteds.contains(edge.desitination) {
                        queue.enqueue(edge)
                    }
                }
            }
            return result
        }

        /// - NOTE: A connected graph is one where all vertices are reachable from any other vertex.
        /// Kind of dfs traversal, visiting all the vertex.
        /// Eg: 1,2,3,4,5 (1 -> 2 -> 3 -> 4 - > 5 -> 1)
        /// Idea is just to dfs 
        func isConnected(_ rootVertex: Vertex<T>? = nil) -> Bool {
            guard let vertex = rootVertex ?? adjacentList.first?.key else { return false }

            var visiteds = Set<Vertex<T>>()
            let stack = Stack<Vertex<T>>()
            stack.push(vertex)

            while !stack.isEmpty {
                if let vertex = stack.pop() {
                    if visiteds.contains(vertex) { continue } /// Already visited
                    visiteds.insert(vertex)
                    let edges = adjacentList[vertex] ?? []
                    for edge in edges where !visiteds.contains(edge.desitination) {
                        stack.push(edge.desitination)
                    }
                }
            }
            /// Keys holds the vertices
            return visiteds.count == adjacentList.keys.count
        }

        /// In the DFS traversal, if you revisit a vertex that’s already been visited,
        /// that means there is a cycle. 
        /// However, `there is one exception`: if you revisit the parent of the current vertex,
        /// it does not indicate a cycle. That’s because the parent is the vertex you just came from,
        /// so revisiting it is natural in an undirected graph.
        ///
        /// In Undirected graph, we dont need to keep track of the path how it came from.
        /// Simply if anything revisited and that neighbour is not parent of the current is cycle.
        ///
        /// HINT: Parent is the key here.
        /// Revisiting the parent is not cycle.
        /// Revisting other than parent which already visited is cycle
        func hasCycleInUndirectedGraph() -> Bool {
            var visiteds = Set<Vertex<T>>()

            func hasCycle(vertex: Vertex<T>, parent: Vertex<T>?) -> Bool {
                visiteds.insert(vertex)
                /// Edges
                if let edges = adjacentList[vertex] {
                    for edge in edges {
                        let neighbour = edge.desitination

                        if !visiteds.contains(neighbour) {
                            if hasCycle(vertex: neighbour, parent: vertex) {
                                return true
                            }
                        } else if neighbour != parent { // checking if revisiting the parent of the current vertex
                            return true
                        }
                    }
                }
                return false
            }

            for vertex in vertices {
                if !visiteds.contains(vertex) {
                    if hasCycle(vertex: vertex, parent: nil) {
                        return true
                    }
                }
            }
            return false
        }

        /// NOTE: on the directed graph
        /// if any neigbour is visited which is in the recursion stack is a cycle
        /// Eg: A -> B -> C -> D -> A
        /// recurssionStack keep trak of [A,B,C,D], when we explore A from D, then its cycle
        /// and when we completing the recurssion we should remove the vertext as well
        func hasCycleInDirectedGraph() -> Bool {

            var visiteds = Set<Vertex<T>>()
            var recurssionStack = Set<Vertex<T>>()

            func hasCycle(vertex: Vertex<T>) -> Bool {
                visiteds.insert(vertex)
                recurssionStack.insert(vertex)
                /// Edges
                if let edges = adjacentList[vertex] {
                    for edge in edges {
                        let neighbour = edge.desitination /// Visting Neighbour
                        if !visiteds.contains(neighbour) {
                            if hasCycle(vertex: neighbour) {
                                return true
                            }
                        } else if recurssionStack.contains(neighbour) {
                            return true
                        }
                    }
                }
                recurssionStack.remove(vertex) // important
                return false
            }

            for vertex in vertices {
                if !visiteds.contains(vertex) {
                    if hasCycle(vertex: vertex) {
                        return true
                    }
                }
            }
            return false
        }

        var description: String {
            var result = ""
            for (vertex, edges) in adjacentList {
                var edgeString = ""
                for edge in edges {
                    edgeString += "\(edge.desitination) "
                }
                result += "\(vertex): [\(edgeString)]\n"
            }
            return result
        }
    }
}
