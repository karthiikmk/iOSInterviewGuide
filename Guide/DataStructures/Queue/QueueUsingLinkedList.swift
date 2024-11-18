//
//  QueueUsingLinkedList.swift
//  Algorithms
//
//  Created by Karthik on 16/03/24.
//

import Foundation

// ===================================================================================================
// MARK: Queue using linked list.
// Having Linked list make the time complexity to O(1) always
// Since its working with node. so it will always lies on the O(1)
// moreover here we are using class, since its refrence type it can take the space complexity as well much smaller
// comparing to the value types.
// ===================================================================================================
class QueueUsingLinkedList<T>: CustomStringConvertible {

    var head: Node<T>? = nil

    var description: String {
        guard let hd = self.head else { return "------- Queue is Empty --------"}
        return "--------- Queue Begins --------- \n"
        + String(describing: hd)
        + "\n----------- Queue Ends ----------"
    }

    /// should be inserted at the bottom
    func enqueue(_ value: T) {
        guard let head else {
            self.head = Node(value: value)
            return
        }
        head.insert(value)
    }

    // Can be decided to return value or return node.
    func dequeue() -> T? {
        let head = self.head
        self.head = head?.next
        return head?.value
    }
}
