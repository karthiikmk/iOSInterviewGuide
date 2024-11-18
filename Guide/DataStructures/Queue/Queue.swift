//
//  Queue.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

// ===================================================================================================
// MARK: Queue (using array)
// Description: Using Array for queue is not that performant.
// Since append takes O(1), but dequeuing taking O(n), because it has to move all the index one step up.
// So to avoid this, we are not removing the element, instead marking them as nil.
// keeping a index property to track the current index.
// Periodically removing the nill values, resetting the index back to zero.
// This way we can avoid O(n), but for resetting will happen in O(n)
// ===================================================================================================
struct Queue<T> {

    //Optional to nill the elements.
    var storage = [T?]()
    var index: Int = 0
    var isEmpty: Bool { storage.isEmpty }

    var front: T? {
        guard !isEmpty else { return nil }
        return storage[index]
    }

    mutating
    func enqeue(_ element: T) {
        storage.append(element)
    }

    mutating
    func dequeue() -> T? {
        guard let element = front else { return nil }
        self.storage[index] = nil
        self.index += 1

        // flush the nilled elements after sometimes
        // if head >= 30% of total array
        let percentage = Double(index)/Double(storage.count) * 100 // double is very important here
        if percentage >= 50 { print("Clearing out the nills")
            self.storage.removeFirst(self.index) // remove first (3) elements
            self.index = 0 // Resetting index to 0
        }

        return element
    }
}

extension Queue: CustomStringConvertible {

    var description: String {
        return "------- Queue Begins --------- \n"
        + storage.map { "\(String(describing: $0))" }.joined(separator: "\n")
        + "\n --------- Queue Ends ----------"
    }
}

// ===================================================================================================
// MARK: Dequeue
// Forwared Enqueue, Forwared Dequeue
// Backward Enqueue, Backward Dequeue

// Description: enqueue and dequeue can happen in both the sides of the queue.
// Enqueue takes O(n), and dequeue O(1), array by default has some buffer space at the bottom.
// Which makes the dequeue more effiecent. we gonna follow the same for enqueue as well.
// So manually we will be creatingg some nill space in the front of the array. in that space, the enqueue
// element can be inserted in O(1). head position must be maintained carefully to track the first position
// inserting at 0th index in array is not that efficient,
// ===================================================================================================
class Dequeue<T>: CustomStringConvertible {

    var storage: [T?]
    var head: Int
    var capacity: Int

    init(capacity: Int = 5) {
        self.storage = [T?](repeating: nil, count: capacity)
        self.capacity = capacity
        self.head = capacity
    }

    var description: String {
        return "\(storage)\n\nHead is at \(self.head)"
    }

    // This will handle adding more buffer in the forward side.
    func forwardEnqueue(_ value: T) {
        if head == 0 { //Creating buffer
            capacity *= 2
            let buffers = [T?](repeating: nil, count: capacity)
            self.storage.insert(contentsOf: buffers, at: 0)
            self.head = capacity
        }

        self.head -= 1 // this is to create index postion
        self.storage[head] = value
    }

    // This will handle, clearing the forward buffer if it's not used.
    func forwardDequeue() -> T? {
        guard let value = self.storage[head] else { return nil }
        self.storage[head] = nil
        self.head += 1
        // clear if the forward buffer is big
        if head >= capacity*2 {
            let removables = capacity + capacity/2
            self.storage.removeFirst(removables)
            self.capacity -= removables
            self.capacity /= 2 // minimizingg the capacity
        }

        return value
    }

    func backwardEnqueue(_ element: T) {
        self.storage.append(element)
    }

    func backwardDequeue() -> T? {
        return self.storage.removeLast()
    }
}

//let dequeue = Dequeue<String>()
//dequeue.forwardEnqueue("1")
//dequeue.forwardEnqueue("2")
//dequeue.forwardEnqueue("3")
//dequeue.forwardEnqueue("4")
//dequeue.forwardEnqueue("5")
//dequeue.forwardEnqueue("6")
//dequeue.forwardDequeue()
//print(dequeue.description)
//
//dequeue.backwardDequeue()
//print(dequeue.description)
//dequeue.forwardDequeue()
//print(dequeue.description)
//dequeue.forwardDequeue()
//print(dequeue.description)

// MARK: Priority Queue (Heap Queue)
// Most important element will kept at the top
// An array which holds the binary tree.
// it can be max priority queue (holds the largest value in the top of the tree)
// it can be min priority queue (holds the smalles value in the root)
// Insert: insert always happens on the bottom of the tree and shifted upto root for sorting.
// Remove: always happen on the root, to fill that blank space, last element from the tree taken up and put in the space
// then shifted down for the sorting
// when we remove particular node, its either shifted up/down for the sorting.
