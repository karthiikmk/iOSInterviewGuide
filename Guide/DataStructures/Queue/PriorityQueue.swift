//
//  PriorityQueue.swift
//  Algorithms
//
//  Created by Karthik on 15/03/24.
//

import Foundation

enum PriorityQueueType {
    case min
    case max
}

class PriorityQueue<T: Comparable> {

    var array = [T]()
    var type: PriorityQueueType
    var isEmpty: Bool { self.array.isEmpty }

    init(_ type: PriorityQueueType) {
        self.type = type
    }

    convenience init(_ type: PriorityQueueType, array: [T]) {
        self.init(type)
        for item in array {
            enqueue(item)
        }
    }

    func enqueue(_ item: T) {
        array.append(item)
        heapify()
    }

    func dequeue() -> T? {
        return (array.isEmpty) ? nil : array.removeFirst()
    }

    private func heapify() {
        type == .min
        ? array.sort() // asc sorting
        : array.sort(by: >) // desc sorting
    }
}

extension PriorityQueue: CustomStringConvertible {

    public var description: String {
        return "\(array)"
    }
}
