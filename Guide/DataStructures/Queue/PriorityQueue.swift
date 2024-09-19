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

/// NOTE: Interesting one
/// Where we are enforcing how the sorting comparision should happen
func runPriorityQueue() {
    
    struct Task: Comparable {
        let priority: Int
        let name: String
        
        static func < (lhs: Task, rhs: Task) -> Bool {
            return lhs.priority < rhs.priority
        }
        
        static func == (lhs: Task, rhs: Task) -> Bool {
            return lhs.priority == rhs.priority
        }
    }
    
    let priorityQueue = PriorityQueue<Task>(.max)
    let task1 = Task(priority: 1, name: "eat")
    let task2 = Task(priority: 3, name: "sleep")
    let task3 = Task(priority: 2, name: "drink")
    priorityQueue.enqueue(task1)
    priorityQueue.enqueue(task2)
    priorityQueue.enqueue(task3)
    
    while let removed = priorityQueue.dequeue() {
        debugPrint(removed.name)
    }
}
