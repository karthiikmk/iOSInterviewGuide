//
//  PriorityQueue.swift
//  Algorithms
//
//  Created by Karthik on 15/03/24.
//

import Foundation

class PriorityQueue<T: Comparable> {

    let heap: Heap<T>

    init(isMaxHeap: Bool = true) {
        self.heap = Heap(maxHeap: isMaxHeap)
    }

    convenience init(isMaxHeap: Bool, array: [T]) {
        self.init(isMaxHeap: isMaxHeap)
        for item in array {
            enqueue(item)
        }
    }

    var isEmpty: Bool { self.heap.isEmpty }

    func enqueue(_ item: T) {
        self.heap.push(item)
    }

    func dequeue() -> T? {
        return self.heap.pop()
    }
}

extension PriorityQueue: CustomStringConvertible {

    public var description: String {
        return "\(heap.elements)"
    }
}
