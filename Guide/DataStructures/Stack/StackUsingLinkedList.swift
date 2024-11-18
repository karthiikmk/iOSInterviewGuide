//
//  StackUsingLinkedList.swift
//  Algorithms
//
//  Created by Karthik on 16/03/24.
//

import Foundation

// MARK: Stack using linked list
// Description: This Stack uses linked list to hold the items.
// The time complexity always O(1), since all the insert and removal happening on the node
class StackUsingLinkedList<T>: CustomStringConvertible {

    var head: Node<T>? = nil
    var isEmpty: Bool { head == nil }

    func push(_ value: T) {
        let newNode = Node(value: value)
        newNode.next = self.head
        self.head = newNode
    }

    func pop() -> Node<T>? {
        let currentHead = self.head
        self.head = currentHead?.next
        return currentHead
    }

    func peek() -> Node<T>? {
        self.head
    }
    
    var description: String {
        guard let hd = head else { return "------ Stack is Empty -------"}
        return "--------- Stack Begings ----------- \n"
        + String(describing: hd)
        + "\n-------- Stack Ends -----------"
    }
}
