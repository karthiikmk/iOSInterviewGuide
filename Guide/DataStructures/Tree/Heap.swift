//
//  BinaryHeap.swift
//  Algorithms
//
//  Created by Karthik on 14/03/24.
//

import Foundation

/*
 https://www.youtube.com/watch?v=HqPJF2L5h9U&list=PLDN4rrl48XKpZkf03iYFl-O29szjTrs_O&index=32
 https://www.youtube.com/watch?v=xqbPBAgl18w

 Heap: A binary heap is a particular type of binary tree (not binary search tree) that satisfies two key properties, making it an efficient data structure for
 priority queue implementations, sorting algorithms, and managing priorities or order in various algorithms

 Time Complexity:
    Search: O(n) (Heap is not designed for efficient arbitrary element search)
    Insertion: O(log n) (heapify up)
    Deletion: O(log n) (remove the root and then heapify down)
 Storage Complexity: O(n)

 *Properties of a Binary Heap*:
 Heap Property: This is the most critical characteristic that defines the binary heap. There are two types of heap property:
 Min-Heap Property: In a min-heap, for any given node, its value is less than or equal to the values of its children. The minimum element is always at the root.
 Max-Heap Property: In a max-heap, for any given node, its value is greater than or equal to the values of its children. The maximum element is always at the root.
 Complete Binary Tree Property: A binary heap is a complete binary tree. This means the tree is completely filled at all levels except possibly the last level, which is filled from left to right. This property is crucial for the efficiency of the operations performed on the heap.

 Why Use a Binary Heap?
 Efficiency: Operations such as finding the minimum or maximum element (depending on whether it's a min-heap or max-heap), inserting a new element, and removing the minimum or maximum element can all be performed in logarithmic time, O(logn).
 Simplicity in Storing: Due to its complete binary tree structure, a binary heap can be efficiently stored in an array without any gaps. This simplifies the implementation and optimizes space usage.
 Priority Queue Implementation: Binary heaps are widely used to implement priority queues. A priority queue is a data structure where each element has a "priority" associated with it, and access to elements is based on priority rather than a first-in-first-out (FIFO) manner.

 Uses of Heaps:
 Priority Queues: Heaps are ideal for implementing priority queues where elements need to be frequently inserted and removed based on their priority rather than a first-in-first-out (FIFO) basis.
 Heap Sort: A sorting algorithm that uses a heap to sort elements. It benefits from the heap property to sort elements in
 O(nlogn) time.
 Graph Algorithms: Algorithms like Dijkstra's and Prim's algorithm use priority queues (often implemented with heaps) to find the shortest path and minimum spanning tree, respectively.

 Full binary tree - all nodes except leaf node, has two child nodes
 Complete binary tree - A complete binary tree is a type of binary tree in which every level, except possibly the last, is completely filled,
 and all nodes are as far left as possible. This definition ensures no gaps in the representation of the tree, making it ideal for array-based storage
 Perfect binary - each node has two childs, and all leaves are at the same level

 Formulas:
 ParentIndex = (currentIndex - 1) / 2
 LeftChildIndex = (2 * currentIndex) + 1
 RigthChildIndex = LeftChildIndex + 1
*/

/*
Pre-requsites:
 - A binary heap is a particular type of binary tree that satisfies two key properties
 - min or max heap property & complete binary tree.
 - insertion must happen only at the leaf node
 - remove should happen only on the root node
 - heapify up or heapify down should be performed to ensure the tree correctness
*/

class Heap<T: Comparable> {

    let isMaxHeap: Bool
    var elements: [T] = [T]()
    var isEmpty: Bool { elements.isEmpty }

    init(maxHeap: Bool) {
        self.isMaxHeap = maxHeap
    }

    // Height of the tree log(n)
    // Time taken to insert and delete = nlog(n)

    /// - NOTE: Time complexity
    /// 0(1) to O(logn)
    /// Insert must happen only at the leaf level
    func push(_ item: T) {
        self.elements.append(item)
        heapfyUp(from: elements.count - 1)
    }

    /// - NOTE: Remove must happen only at the root level.
    /// only root can be remove, no other option.
    /// we can NOT remove whatever we want.
    func pop() -> T? {
        guard !elements.isEmpty else { return nil } // Basecase
        guard elements.count > 1 else { return elements.removeFirst() } // BaseCase2
        elements.swapAt(0, elements.count - 1)
        let removed = elements.removeLast()
        heapfyDown(from: 0)
        return removed
    }

    func remove(at index: Int) -> T? {
        guard index < elements.count else { return nil } // BaseCase
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            let removed = elements.removeLast()
            heapfyDown(from: index)
            heapfyUp(from: index)
            return removed
        }
    }
}

///  create a heap, delete all the elements == HEAP sort.

extension Heap: CustomStringConvertible {

    var description: String {
        return "\(elements)"
    }

    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }

    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
}

// MARK: - Algorithm
extension Heap {

    /// - NOTE: When a new element is added to the heap, it's initially placed at the end of the array 
    /// (which represents the lowest and rightmost position available in the complete binary tree structure of the heap).
    /// If the newly inserted element violates the heap property by being larger (max-heap) or smaller (min-heap) than its parent,
    /// it needs to be moved up the heap until the property is restored.
    private func heapfyUp(from index: Int) {
        var currentIndex = index
        let currentValue = elements[currentIndex]

        // This process continues (moving up the tree) until either the element does not violate the heap property with its parent (meaning no swap is necessary)
        // or the element reaches the root of the tree (at index 0)
        while currentIndex > 0 {
            // Starting with the newly added element, the algorithm repeatedly compares the element with its parent
            // and swaps them if the heap property is violated.
            let compare: (T, T) -> Bool = isMaxHeap ? { $0 > $1 } : { $0 < $1 }
            let parentIndex = (currentIndex - 1) / 2
            let parentValue = elements[parentIndex]
            let isHeapViolated = compare(currentValue, parentValue)
            if isHeapViolated {
                elements[currentIndex] = elements[parentIndex]
                currentIndex = parentIndex
            } else {
                break // no viloation found.
            }
        }
        elements[currentIndex] = currentValue
    }

    private func heapfyDown(from index: Int) {
        var currentIndex = index
        let currentValue = elements[currentIndex]
        let count = elements.count

        // The function enters a loop that continues as long as the current node has at least a left child.
        // left child because of the complete binary tree, Every level is fully filled, except possibly the last level,
        // which is filled from left to right,
        // if a node has a right child, it must also have a left child. The converse, however, is not necessarily true:
        while 2 * currentIndex + 1 < count {
            let leftChildIndex = 2 * currentIndex + 1
            let rightChildIndex = leftChildIndex + 1
            var smallestIndex = leftChildIndex
            let compare: (T, T) -> Bool = isMaxHeap ? { $0 > $1 } : { $0 < $1 }

            // Determine the Larger Child: Check for the existence of a right child and whether it should be swapped with
            if rightChildIndex < count && compare(elements[rightChildIndex], elements[smallestIndex]) {
                smallestIndex = rightChildIndex
            }
            // Swap if Necessary
            let isHeapViolated = compare(elements[smallestIndex], currentValue)
            if isHeapViolated {
                elements[currentIndex] = elements[smallestIndex]
                currentIndex = smallestIndex // Repeat
            } else {
                break
            }
        }
        elements[currentIndex] = currentValue
        // debugPrint(elements)
    }
}

struct Task {
    let priority: Int
    let name: String
}

extension Task: Comparable {

    static func < (lhs: Task, rhs: Task) -> Bool {
        return lhs.priority < rhs.priority
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.priority == rhs.priority
    }
}
