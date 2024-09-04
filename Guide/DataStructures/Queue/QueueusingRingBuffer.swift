//
//  RingBuffer.swift
//  Algorithms
//
//  Created by Karthik on 13/03/24.
//

import Foundation

/*
 https://victorqi.gitbooks.io/swift-algorithm/content/ring_bufferhuan_xing_huan_chong_533a29.html

 All operations are O(1).

 Circular Behavior: The modulo operator ensures that the index wraps around the array when it reaches the end.
 For example, if the buffer size is 4, adding an element at index 4 should place it back at index 0, since 4 % 4 = 0. 
 This behavior is essential for achieving the circular, reusable nature of the ring buffer without needing to resize or shift elements within the underlying array.
*/

// MARK: - Support only enqueue and dequeue
class QueueUsingRingBuffer<T> {

    var array: [T?]
    var readIndex: Int = 0
    var writeIndex: Int = 0

    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }

    var availableSpaceToRead: Int { writeIndex - readIndex }
    var availableSpaceToWrite: Int { array.count - availableSpaceToRead } // Imp

    var isEmpty: Bool { availableSpaceToRead == 0 }
    var isFull: Bool { availableSpaceToWrite == 0 }

    // 0 % 4 = 0
    // 1 % 4 = 1
    // 4 % 4 = 0
    func enqueue(element: T) -> Bool {
        // BaseCase
        guard !isFull else { return false }
        array[writeIndex % array.count] = element // imp
        writeIndex += 1
        return true
    }

    func dequeue() -> T? {
        // BaseCase
        guard !isEmpty else { return nil }
        let element = array[readIndex % array.count] // imp
        readIndex += 1
        return element
    }
}
